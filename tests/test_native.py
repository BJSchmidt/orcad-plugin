"""The native mesh fast path: identical answers to Python, and a safe fallback.

openscad/mesh.py stays the reference implementation. These tests check that the
C library (native/mesh.c, built by native/build.py) agrees with it byte for
byte, that every platform OrcaCAD ships has a library, and that anything
unexpected - a missing file, a damaged file, an older library without the
symbols - falls back to Python instead of failing the render.
"""
from __future__ import annotations

import ctypes
import random
import shutil
import struct
import sys
import types
from array import array
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parent))
from test_backend import stl  # noqa: E402  (the same binary-STL writer)

from openscad import mesh, mesh_native  # noqa: E402

DIST = Path(mesh_native.DIST)
TAGS = {
    "linux-x86_64": ("orcad_mesh.so", b"\x7fELF"),
    "linux-aarch64": ("orcad_mesh.so", b"\x7fELF"),
    "windows-x86_64": ("orcad_mesh.dll", b"MZ"),
    "macos-arm64": ("orcad_mesh.dylib", b"\xcf\xfa\xed\xfe"),
    "macos-x86_64": ("orcad_mesh.dylib", b"\xcf\xfa\xed\xfe"),
}
ERROR = 0xFFFFFFFF

# A grid shares vertices (the usual case), loose triangles share nothing (the
# worst case for the hash table), and these cover the awkward corners: repeated
# vertices, degenerate triangles and -0.0, which Python keeps distinct from 0.0
# because it keys on the raw bytes.
GRID = [((i % 40, i // 40, 0), (i % 40 + 1, i // 40, 0), (i % 40 + 1, i // 40 + 1, 0)) for i in range(2000)]
LOOSE = [((3 * i, 3 * i + 1, 3 * i + 2), (3 * i + 3, 3 * i + 4, 3 * i + 5), (3 * i + 6, 3 * i + 7, 3 * i + 8))
         for i in range(2000)]
CASES = {
    "cube": [((0, 0, 0), (1, 1, 0), (1, 0, 0))],
    "shared vertices": [((0, 0, 0), (1, 0, 0), (1, 1, 0)), ((0, 0, 0), (1, 1, 0), (0, 1, 0)),
                        ((0, 0, 0), (0, 1, 0), (0, 0, 1))],
    "degenerate": [((0, 0, 0), (0, 0, 0), (1, 0, 0)), ((1, 0, 0), (1, 0, 0), (1, 0, 0))],
    "negative zero": [((-0.0, 0, 0), (1, 0, 0), (0, 1, 0)), ((0.0, 0, 0), (1, 0, 0), (0, 1, 0))],
    "grid": GRID,
    "loose": LOOSE,
    "random": [tuple(tuple(round(random.Random(7).uniform(-5, 5), 3) for _ in range(3)) for _ in range(3))
               for _ in range(500)],
}


def python_index(data: bytes) -> tuple[bytes, list[int]]:
    """The reference implementation: exact-byte keys, first-seen order."""
    lookup: dict[bytes, int] = {}
    raw = bytearray()
    indices: list[int] = []
    for triangle in range(mesh.triangle_count(data)):
        offset = 84 + triangle * 50 + 12
        for corner in range(3):
            key = data[offset + corner * 12: offset + corner * 12 + 12]
            index = lookup.get(key)
            if index is None:
                index = lookup[key] = len(lookup)
                raw += key
            indices.append(index)
    return bytes(raw), indices


def loaded() -> ctypes.CDLL:
    library = mesh_native.load()
    if library is None:
        pytest.skip(f"no native library for {mesh_native.platform_tag()}")
    return library


def reset_loader(monkeypatch) -> None:
    monkeypatch.setattr(mesh_native, "_tried", False)
    monkeypatch.setattr(mesh_native, "_library", None)
    monkeypatch.setattr(mesh_native, "_provider", None)  # restored on teardown


def test_the_native_path_is_used_here():
    # Everything below is worthless if this machine quietly fell back to Python.
    library = loaded()
    assert mesh_native.library_path() == DIST / mesh_native.platform_tag() / mesh_native.library_path().name
    assert library.orcad_mesh_triangles(stl(CASES["cube"]), len(stl(CASES["cube"]))) == 1


@pytest.mark.parametrize("name", sorted(CASES))
def test_native_indexing_matches_the_python_reference(name):
    loaded()
    data = stl(CASES[name])
    native = mesh.index_stl(data)
    raw, indices = python_index(data)
    assert native.positions.tobytes() == raw, name
    assert list(native.indices) == indices, name
    assert native.triangle_count == len(CASES[name])


def test_native_and_python_agree_on_a_real_render(tmp_path):
    """The mesh a real OpenSCAD render produces, not just a synthetic one."""
    if shutil.which("openscad") is None:
        pytest.skip("needs OpenSCAD on PATH")
    from openscad import OpenSCADRunner
    rendered = OpenSCADRunner(cache_dir=tmp_path).render_object("gridfinity_bin", {}, "draft")
    loaded()
    data = rendered.stl.read_bytes()
    native = mesh.index_stl(data)
    raw, indices = python_index(data)
    assert native.positions.tobytes() == raw and list(native.indices) == indices


def test_every_shipped_platform_has_a_well_formed_library():
    for tag, (name, magic) in TAGS.items():
        path = DIST / tag / name
        assert path.is_file(), f"{tag} has no library; run `python3 native/build.py`"
        assert path.read_bytes().startswith(magic), f"{tag}/{name} is not a {magic!r} file"
        assert path.stat().st_size > 1024, tag


def test_the_platform_tag_names_a_shipped_folder():
    assert mesh_native.platform_tag() in TAGS


def test_a_missing_library_falls_back_to_python(monkeypatch):
    monkeypatch.setattr(mesh_native, "library_path", lambda: None)
    reset_loader(monkeypatch)
    assert mesh_native.load() is None
    data = stl(CASES["grid"])
    assert mesh_native.index_stl(data, mesh.triangle_count(data)) is None
    assert mesh.index_stl(data).positions.tobytes() == python_index(data)[0]


def test_a_damaged_library_falls_back_to_python(monkeypatch, tmp_path):
    damaged = tmp_path / "orcad_mesh.so"
    damaged.write_bytes(b"not a shared library")
    monkeypatch.setattr(mesh_native, "library_path", lambda: damaged)
    reset_loader(monkeypatch)
    assert mesh_native.load() is None


def test_a_library_without_the_expected_symbols_falls_back(monkeypatch):
    class Stub:
        def __getattr__(self, name):
            raise AttributeError(name)

    monkeypatch.setattr(mesh_native, "_import_ctypes", lambda: types.SimpleNamespace(CDLL=lambda path: Stub()))
    reset_loader(monkeypatch)
    assert mesh_native.load() is None


def test_an_interpreter_that_forbids_ctypes_falls_back(monkeypatch):
    """OrcaSlicer's plugin sandbox may deny ctypes outright; that is not fatal."""
    def forbidden():
        raise ImportError("ctypes is not available in this interpreter")

    monkeypatch.setattr(mesh_native, "_import_ctypes", forbidden)
    reset_loader(monkeypatch)
    data = stl(CASES["grid"])
    assert mesh_native.load() is None
    assert mesh_native.library_path() is not None  # the file is there; it is just unusable
    assert mesh_native.index_stl(data, len(GRID)) is None
    assert mesh.index_stl(data).positions.tobytes() == python_index(data)[0]


def test_the_provider_supplies_the_library_when_it_is_not_on_disk(monkeypatch, tmp_path):
    """A single-file install writes the library out on demand and hands over the path."""
    real = DIST / mesh_native.platform_tag() / mesh_native.library_name()
    written = tmp_path / "elsewhere" / real.name
    written.parent.mkdir(parents=True)
    written.write_bytes(real.read_bytes())
    monkeypatch.setattr(mesh_native, "DIST", tmp_path / "unpacked-nothing")
    reset_loader(monkeypatch)
    assert mesh_native.library_path() is None
    mesh_native.set_provider(lambda tag, name: written)
    assert mesh_native.library_path() == written
    data = stl(CASES["cube"])
    assert mesh_native.index_stl(data, 1) is not None


def test_a_provider_that_fails_is_not_fatal(monkeypatch, tmp_path):
    def broken(tag, name):
        raise OSError("the cache directory is read-only")

    monkeypatch.setattr(mesh_native, "DIST", tmp_path / "unpacked-nothing")
    reset_loader(monkeypatch)
    mesh_native.set_provider(broken)
    assert mesh_native.library_path() is None and mesh_native.load() is None


def test_a_too_small_scratch_table_reports_an_error_instead_of_looping():
    """A full table used to spin forever inside the slicer; it must give up."""
    library = loaded()
    data = stl(LOOSE[:500])
    triangles = len(LOOSE[:500])
    positions = array("f", bytes(triangles * 9 * 4))
    indices = array("I", bytes(triangles * 3 * 4))
    scratch = bytearray(16 * 16)
    assert library.orcad_mesh_index(data, len(data),
                                    (ctypes.c_float * len(positions)).from_buffer(positions),
                                    (ctypes.c_uint32 * len(indices)).from_buffer(indices),
                                    triangles, (ctypes.c_char * len(scratch)).from_buffer(scratch),
                                    len(scratch)) == ERROR
    assert library.orcad_mesh_scratch(triangles) > len(scratch)


def test_the_library_rejects_input_the_python_path_would_reject():
    library = loaded()
    header = b"x".ljust(80, b"\0") + struct.pack("<I", 4)  # claims four triangles, has none
    assert library.orcad_mesh_triangles(header, len(header)) == 0
    assert library.orcad_mesh_triangles(b"", 0) == 0
    assert library.orcad_mesh_triangles(stl(CASES["cube"])[:-1], len(stl(CASES["cube"])) - 1) == 0
