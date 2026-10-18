# native/: the mesh fast path

`mesh.c` is the only native code OrcaCAD ships. It deduplicates the vertices of
a binary STL, which is what `openscad/mesh.py` does in Python and what a large
model makes visible: about 1 ms per 1000 triangles there, so a 500k-triangle
render spends a second in that loop on a slow machine.

| | 500k triangles, 500k distinct vertices |
| --- | --- |
| Python (`openscad/mesh.py`) | ~1000 ms |
| `mesh.c` | 84 ms |

The Python implementation stays the reference: `tests/test_backend.py` and
`tests/test_native.py` compare the two byte for byte, and everything falls back
to it when the library is missing, damaged, built for another machine, or from
an older release. Nothing in the render path requires it.

## Building

```sh
python3 native/build.py          # every platform, needs zig
python3 native/build.py --host   # just this machine, with the host compiler
python3 native/build.py --check  # verify the committed libraries
```

The five libraries under `openscad/native/dist/` are committed and ride along in
the backend archive, so installing a release needs no compiler. Rebuild them
whenever `mesh.c` changes, and check the sizes stay in the same range.

[zig](https://ziglang.org/download/) is the only toolchain used, because the
library is freestanding and one download cross-compiles all five targets
(Linux and Windows x86_64, Linux aarch64, macOS arm64 and x86_64). Verify the
tarball's published SHA-256, unpack it, and put `zig` on `PATH` or in
`/opt/zig/zig`. The exact flags live in `native/build.py`; the two that matter
are `-fno-compiler-rt` with `--gc-sections`/`-dead_strip`, which keep the
library at 3-50 KB instead of 190 KB, and `-fentry=DllMainCRTStartup`, which is
what lld-link wants for a DLL that links no CRT.

## How it is loaded

`openscad/mesh_native.py` picks `dist/<platform>/orcad_mesh.<so|dll|dylib>` for
the current machine and loads it with `ctypes` on first use. The library has no
dependencies, allocates nothing of its own and never touches the filesystem:
Python owns the output buffers and the scratch hash table, and passes their
addresses in. It is only used on little-endian machines where `array("I")` is
four bytes, because it copies the STL's vertex bytes through unchanged.

Two rules the C code has to keep:

- **Never loop without a bound.** The scratch table is sized for the worst case
  (every triangle contributing three distinct vertices) at most three quarters
  full, and the probe gives up and reports an error if the table is full anyway.
  A library that spins would hang OrcaSlicer itself.
- **Match Python exactly.** Keys are the vertex's raw 12 bytes, so `-0.0` and
  `0.0` stay distinct, and vertices keep first-seen order.
