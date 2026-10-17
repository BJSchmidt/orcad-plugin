// orcad wrapper for BelfrySCAD/BOSL2 (BSD-2-Clause): internal ring gear.
include <belfryscad-bosl2-0c6f402b/std.scad>
include <belfryscad-bosl2-0c6f402b/gears.scad>
ring_teeth = 30;
ring_pitch = 5;
ring_thickness = 8;
ring_outer_diameter = 60;
ring_gear(circ_pitch = ring_pitch, teeth = ring_teeth, thickness = ring_thickness, od = ring_outer_diameter);
