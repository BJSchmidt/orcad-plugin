#!/usr/bin/env python3
"""Build the mesh fast path (openscad/native/mesh.c) for every platform OrcaCAD ships to.

The binaries are committed under openscad/native/dist/ and ride along in the
backend archive, so a release needs no compiler on the machine that installs it.

    python3 native/build.py            # all platforms (needs zig; see below)
    python3 native/build.py --host     # just this machine, with the host compiler
    python3 native/build.py --check    # verify the committed binaries are loadable

zig is the only cross-compiler used because it needs no SDK: the library is
freestanding (no libc), so one toolchain builds all five targets. Download the
tarball for your machine from https://ziglang.org/download/, verify its
published SHA-256, and put `zig` on PATH or in /opt/zig/zig.
"""
from __future__ import annotations

import argparse
import hashlib
import platform
import shutil
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
SOURCE = HERE / "mesh.c"
DIST = HERE.parent / "openscad" / "native" / "dist"
ZIG = shutil.which("zig") or ("/opt/zig/zig" if Path("/opt/zig/zig").is_file() else None)

# tag -> (zig target, file name, magic bytes of the produced file)
TARGETS = {
    "linux-x86_64": ("x86_64-linux-gnu", "orcad_mesh.so", b"\x7fELF"),
    "linux-aarch64": ("aarch64-linux-gnu", "orcad_mesh.so", b"\x7fELF"),
    "windows-x86_64": ("x86_64-windows-gnu", "orcad_mesh.dll", b"MZ"),
    "macos-arm64": ("aarch64-macos-none", "orcad_mesh.dylib", b"\xcf\xfa\xed\xfe"),
    "macos-x86_64": ("x86_64-macos-none", "orcad_mesh.dylib", b"\xcf\xfa\xed\xfe"),
}
# --gc-sections / -dead_strip drop what the three exported functions cannot
# reach (compiler-rt and unwind tables mostly), which is the difference between
# a 7 KB library and a 190 KB one. -fentry is what lld-link wants for a DLL.
FLAGS = {
    "windows": ["-fdll-export-fns", "-fentry=DllMainCRTStartup"],
    "macos": ["-dead_strip"],
    "linux": ["--gc-sections"],
}


def host_tag() -> str:
    machine = {"x86_64": "x86_64", "amd64": "x86_64", "aarch64": "aarch64", "arm64": "arm64"}.get(
        platform.machine().lower(), platform.machine().lower())
    if sys.platform == "win32":
        return f"windows-{machine}"
    if sys.platform == "darwin":
        return f"macos-{machine}"
    return f"linux-{machine}"


def compile_with_zig(target: str, output: Path) -> None:
    kind = "windows" if "windows" in target else "macos" if "macos" in target else "linux"
    command = [ZIG, "build-lib", "-dynamic", "-target", target, "-OReleaseFast", "-fno-compiler-rt", "-fPIC",
               *FLAGS[kind], f"-femit-bin={output}", str(SOURCE)]
    subprocess.run(command, check=True)


def compile_with_host(output: Path) -> None:
    compiler = shutil.which("cc") or shutil.which("gcc") or shutil.which("clang")
    if compiler is None:
        raise SystemExit("no C compiler found; install zig and run `python3 native/build.py`")
    suffix = ".dylib" if sys.platform == "darwin" else ".so"
    subprocess.run([compiler, "-shared", "-fPIC", "-O2", "-ffreestanding", "-fno-builtin", "-nostdlib",
                    "-s", "-o", str(output), str(SOURCE)], check=True)


def build(tags: list[str], use_host: bool) -> None:
    for tag in tags:
        target, name, _magic = TARGETS[tag]
        output = DIST / tag / name
        output.parent.mkdir(parents=True, exist_ok=True)
        if use_host and tag == host_tag():
            compile_with_host(output)
        else:
            if ZIG is None:
                raise SystemExit(f"{tag} needs zig (see the module docstring); {host_tag()} can be built with --host")
            compile_with_zig(target, output)
        # zig also drops an import library and debug symbols next to a DLL; only
        # the library itself belongs in the release.
        for stray in output.parent.iterdir():
            if stray != output:
                stray.unlink()
        print(f"{tag:16} {name:16} {output.stat().st_size:>7} bytes  sha256 {hashlib.sha256(output.read_bytes()).hexdigest()[:12]}")


def check() -> int:
    sys.path.insert(0, str(HERE.parent))
    from openscad import mesh_native
    problems = []
    for tag, (_target, name, magic) in TARGETS.items():
        path = DIST / tag / name
        if not path.is_file():
            problems.append(f"{tag}: {path.relative_to(HERE.parent)} is missing; run `python3 native/build.py`")
            continue
        if not path.read_bytes().startswith(magic):
            problems.append(f"{tag}: {path.name} is not a {magic!r} file; run `python3 native/build.py`")
    library = mesh_native.load()
    if library is None:
        problems.append(f"the {mesh_native.platform_tag()} library does not load; run `python3 native/build.py --host`")
    else:
        print(f"loaded {mesh_native.library_path()}")
    for problem in problems:
        print(f"error: {problem}", file=sys.stderr)
    return 1 if problems else 0


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--host", action="store_true", help="build only this machine's library with the host compiler")
    parser.add_argument("--check", action="store_true", help="verify the committed libraries instead of building")
    parser.add_argument("tags", nargs="*", help="only these platform tags")
    args = parser.parse_args()
    if args.check:
        return check()
    tags = args.tags or list(TARGETS)
    unknown = [tag for tag in tags if tag not in TARGETS]
    if unknown:
        raise SystemExit(f"unknown platform tag(s): {', '.join(unknown)}; known: {', '.join(TARGETS)}")
    build(tags, args.host)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
