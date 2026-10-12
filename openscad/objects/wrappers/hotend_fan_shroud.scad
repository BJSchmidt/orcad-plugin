// orcad wrapper for gchristopher/3dprinting (Apache-2.0): rostock-effector/fan_shroud_bottom.scad.
// fan_shroud_bottom() closes the gap under the effector platform so the layer
// fan only blows across the hot-end cooling fins. Upstream renders it at top
// level, so the wrapper includes it and restates the duct dimensions.
include <gchristopher-3dprinting-8fdb722c/rostock-effector/fan_shroud_bottom.scad>

// Drehung des Lüfters
fan_rot2 = 45;
// Versatz des Lüfters
fan_dy = 18;
// Höhe der Lüfterverschraubung
fan_screw_attachment_h = 4;
// Höhe des Armanschlusses
arm_attachment_height = 10;
