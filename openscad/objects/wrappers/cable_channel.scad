// orcad wrapper for dmhernandez2525/splice3d (MIT): hardware/f1_4/cad/cable_management.scad.
// cable_channel() is a snap-on trough with clip feet; orcad lays out a row of
// them at a settable pitch instead of editing the vendored module.
use <splice3d-1b9233f1/hardware/f1_4/cad/cable_management.scad>

// Länge eines Kanals
channel_length = 80;
// Anzahl der Kanäle
channel_count = 2;
// Abstand zwischen den Kanälen
channel_pitch = 20;

for (i = [0 : channel_count - 1])
    translate([0, i * channel_pitch, 0]) cable_channel(channel_length);
