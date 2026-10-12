// orcad wrapper for BelfrySCAD/BOSL2 (BSD-2-Clause): BOSL2's slider() as a
// shop jig that rides a V-groove rail. rail() from the same file is printed
// alongside it so the runner can be test-fit.
include <belfryscad-bosl2-0c6f402b/std.scad>
include <belfryscad-bosl2-0c6f402b/sliders.scad>

slider_l = 40;
slider_w = 12;
slider_h = 10;
slider_base = 8;
slider_wall = 4;
slider_ang = 30;
slider_chamfer = 1.5;

slider(l = slider_l, w = slider_w, h = slider_h, base = slider_base,
       wall = slider_wall, ang = slider_ang, chamfer = slider_chamfer);
right(slider_l + 20)
    rail(l = slider_l, w = slider_w, h = slider_h, chamfer = slider_chamfer, ang = slider_ang);
