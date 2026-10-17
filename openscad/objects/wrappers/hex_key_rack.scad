// orcad wrapper for dmhernandez2525/splice3d (MIT): hardware/f1_4/cad/tool_accessory_mounts.scad.
// hex_key_holder() is a drilled block that stands hex keys upright; orcad lays
// out a row of them at a settable pitch instead of editing the vendored module.
use <splice3d-1b9233f1/hardware/f1_4/cad/tool_accessory_mounts.scad>

// Anzahl der Halter
holder_count = 3;
// Abstand zwischen den Haltern
holder_pitch = 66;

for (i = [0 : holder_count - 1])
    translate([i * holder_pitch, 0, 0]) hex_key_holder();
