// orcad wrapper for BelfrySCAD/BOSL2 (BSD-2-Clause): bevel gear.
include <belfryscad-bosl2-0c6f402b/std.scad>
include <belfryscad-bosl2-0c6f402b/gears.scad>
bevel_teeth = 20;
bevel_mate_teeth = 20;
bevel_pitch = 5;
bevel_face_width = 5;
bevel_thickness = 6;
bevel_backing = 4;
bevel_bottom = 8;
bevel_gear(teeth = bevel_teeth, mate_teeth = bevel_mate_teeth, circ_pitch = bevel_pitch,
           bottom = bevel_bottom, thickness = bevel_thickness, backing = bevel_backing,
           face_width = bevel_face_width);
