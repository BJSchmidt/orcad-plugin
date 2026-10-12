// orcad wrapper for NilsKrause/cad (MIT): microsdcard-holder.scad.
// Upstream's box_holder() is a fixed micro-SD tray, so orcad lays out a row of
// them at a settable pitch instead of editing the vendored module.
use <nilskrause-cad-9c4d69e9/microsdcard-holder.scad>

holder_count = 2;
holder_pitch = 32;

for (i = [0 : holder_count - 1])
    translate([i * holder_pitch, 0, 0]) box_holder();
