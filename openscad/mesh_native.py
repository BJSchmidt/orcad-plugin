"""The optional native fast path for the mesh hot loop (see native/README.md).

`openscad/native/dist/<platform>/orcad_mesh.<so|dll|dylib>` ships inside the
backend, so it is available in a folder install and in the single-file install
that unpacks the embedded archive. The C library has no dependencies, allocates
nothing of its own and never touches the filesystem.

Nothing here is allowed to be load-bearing. OrcaSlicer's plugin sandbox may
forbid `ctypes` outright, a platform may have no library, the file may be
damaged, and a single-file install only writes the library out the first time it
is needed - so every step is guarded, `ctypes` is imported lazily, and
`index_stl` returns None to send `mesh.index_stl` down the Python path. That
implementation stays the reference: tests/test_native.py compares the two byte
for byte.
"""
from __future__ import annotations

import platform
import sys
from array import array
from pathlib import Path

DIST = Path(__file__).resolve().parent / "native" / "dist"
_ERROR = 0xFFFFFFFF
_EXTENSIONS = {"windows": "dll", "macos": "dylib"}

_library = None
_tried = False
_provider = None


def set_provider(provider) -> None:
    """Let the plugin supply the library file when it is not on disk.

    A single-file install keeps the library inside its embedded archive, so
    `orcad.py` passes a callable that writes it out on first use and returns its
    path (or None). A folder install has the file already and needs none of it.
    """
    global _provider, _tried, _library
    _provider = provider
    _tried, _library = False, None


def platform_tag() -> str:
    """The dist/ folder for this machine; mirrors the tags in native/build.py."""
    machine = platform.machine().lower()
    if machine == "amd64":
        machine = "x86_64"
    elif machine == "aarch64" and sys.platform == "darwin":
        machine = "arm64"
    if sys.platform == "win32":
        return f"windows-{machine}"
    if sys.platform == "darwin":
        return f"macos-{machine}"
    return f"linux-{machine}"


def library_name() -> str:
    tag = platform_tag()
    return f"orcad_mesh.{_EXTENSIONS.get(tag.split('-')[0], 'so')}"


def library_path() -> Path | None:
    """Where this machine's library is, or None when it is not available."""
    path = DIST / platform_tag() / library_name()
    if path.is_file():
        return path
    if _provider is None:
        return None
    try:
        return _provider(platform_tag(), library_name())
    except Exception:  # a provider that cannot write (read-only cache, sandbox)
        return None


def _import_ctypes():
    """Imported on demand: an embedded interpreter may not allow ctypes at all."""
    import ctypes

    return ctypes


def load():
    """The loaded library, or None when this machine has no usable one."""
    global _library, _tried
    if _tried:
        return _library
    _tried = True
    path = library_path()
    # The library writes raw STL bytes through, so it only suits the byte order
    # and index width the Python path produces here.
    if path is None or sys.byteorder != "little" or array("I").itemsize != 4:
        return None
    try:
        ctypes = _import_ctypes()
        library = ctypes.CDLL(str(path))
        library.orcad_mesh_triangles.argtypes = [ctypes.c_char_p, ctypes.c_size_t]
        library.orcad_mesh_triangles.restype = ctypes.c_uint32
        library.orcad_mesh_scratch.argtypes = [ctypes.c_size_t]
        library.orcad_mesh_scratch.restype = ctypes.c_size_t
        library.orcad_mesh_index.argtypes = [ctypes.c_char_p, ctypes.c_size_t,
                                             ctypes.POINTER(ctypes.c_float), ctypes.POINTER(ctypes.c_uint32),
                                             ctypes.c_size_t, ctypes.c_char_p, ctypes.c_size_t]
        library.orcad_mesh_index.restype = ctypes.c_uint32
    except Exception:  # no ctypes, no library, no symbols, a sandbox denial
        return None
    _library = library
    return _library


def index_stl(data: bytes, triangles: int):
    """(positions, indices) for a validated binary STL, or None to do it in Python."""
    try:
        ctypes = _import_ctypes()
        library = load()
        if library is None or library.orcad_mesh_triangles(data, len(data)) != triangles:
            return None
        scratch = bytearray(library.orcad_mesh_scratch(triangles))
        positions = array("f", bytes(triangles * 9 * 4))
        indices = array("I", bytes(triangles * 3 * 4))
        vertices = library.orcad_mesh_index(
            data, len(data),
            (ctypes.c_float * len(positions)).from_buffer(positions),
            (ctypes.c_uint32 * len(indices)).from_buffer(indices),
            triangles, (ctypes.c_char * len(scratch)).from_buffer(scratch), len(scratch))
    except Exception:  # any surprise at all: the Python implementation is the answer
        return None
    if vertices == _ERROR or vertices > triangles * 3:
        return None
    del positions[vertices * 3:]  # only the vertices that were actually used
    return positions, indices
