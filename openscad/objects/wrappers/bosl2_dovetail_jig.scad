// orcad wrapper for BelfrySCAD/BOSL2 (BSD-2-Clause): a male and female
// BOSL2 dovetail() printed side by side as a slide jig for a router table.
include <belfryscad-bosl2-0c6f402b/std.scad>
include <belfryscad-bosl2-0c6f402b/joiners.scad>

dv_width = 20;
dv_height = 10;
dv_slide = 40;
dv_taper = 0;
dv_chamfer = 0.8;

dovetail("male", width = dv_width, height = dv_height, slide = dv_slide,
         taper = dv_taper, chamfer = dv_chamfer);
right(dv_width + 10)
    dovetail("female", width = dv_width, height = dv_height, slide = dv_slide,
             taper = dv_taper, chamfer = dv_chamfer);
