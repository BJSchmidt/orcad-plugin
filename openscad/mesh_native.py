"""The optional native fast path for the mesh hot loop (see native/README.md).

`openscad/native/dist/<platform>/orcad_mesh.<so|dll|dylib>` ships inside the
backend, so it is available in a folder install and in the single-file install
that unpacks the embedded archive. The C library has no dependencies, allocates
nothing of its own and never touches the filesystem.

Anything unexpected - a platform we do not build for, a damaged file, a sandbox
that refuses to load it, an older library without the symbols we expect - makes
`index_stl` return None so `mesh.index_stl` falls back to the Python
implementation. That implementation stays the reference: tests/test_backend.py
compares the two byte for byte.
"""
from __future__ import annotations

import ctypes
import platform
import sys
from array import array
from pathlib import Path

DIST = Path(__file__).resolve().parent / "native" / "dist"
_ERROR = 0xFFFFFFFF
_EXTENSIONS = {"windows": "dll", "macos": "dylib"}

_library: ctypes.CDLL | None = None
_tried = False


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


def library_path() -> Path | None:
    tag = platform_tag()
    path = DIST / tag / f"orcad_mesh.{_EXTENSIONS.get(tag.split('-')[0], 'so')}"
    return path if path.is_file() else None


def load() -> ctypes.CDLL | None:
    """The loaded library, or None when this machine has no usable one."""
    global _library, _tried
    if _tried:
        return _library
    _tried = True
    path = library_path()
    # The library writes raw STL bytes through, so it only suits the byte order
    # and index width the Python path produces here.
    if path is not None and sys.byteorder == "little" and array("I").itemsize == 4:
        try:
            library = ctypes.CDLL(str(path))
            library.orcad_mesh_triangles.argtypes = [ctypes.c_char_p, ctypes.c_size_t]
            library.orcad_mesh_triangles.restype = ctypes.c_uint32
            library.orcad_mesh_scratch.argtypes = [ctypes.c_size_t]
            library.orcad_mesh_scratch.restype = ctypes.c_size_t
            library.orcad_mesh_index.argtypes = [ctypes.c_char_p, ctypes.c_size_t,
                                                 ctypes.POINTER(ctypes.c_float), ctypes.POINTER(ctypes.c_uint32),
                                                 ctypes.c_size_t, ctypes.c_char_p, ctypes.c_size_t]
            library.orcad_mesh_index.restype = ctypes.c_uint32
            _library = library
        except (OSError, AttributeError):
            _library = None
    return _library


def index_stl(data: bytes, triangles: int):
    """(positions, indices) for a validated binary STL, or None to do it in Python."""
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
    if vertices == _ERROR or vertices > triangles * 3:
        return None
    del positions[vertices * 3:]  # only the vertices that were actually used
    return positions, indices
