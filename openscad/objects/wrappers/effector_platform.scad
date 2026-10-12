// orcad wrapper for gchristopher/3dprinting (Apache-2.0): rostock-effector/wider_effector_platform.scad.
// Effector platform with a larger centre opening for delta arms; the arm
// attachment blocks are the part that wears. Upstream renders
// effector_platform() at top level, so the wrapper includes it and restates the
// arm and screw dimensions.
include <gchristopher-3dprinting-8fdb722c/rostock-effector/wider_effector_platform.scad>

// Breite der Armanschlüsse
arm_attachment_width = 37;
// Höhe der Armanschlüsse
arm_attachment_height = 10;
// Radius der Armschrauben
arm_screw_r = 1.5;
// Abstand der Hotendaufnahmen von der Mitte
offset = 13;
