// orcad wrapper for BelfrySCAD/BOSL2 (BSD-2-Clause): a sanding block whose
// rounded body is a BOSL2 cuboid() with a finger groove cut by xcyl().
include <belfryscad-bosl2-0c6f402b/std.scad>

block_l = 120;
block_w = 70;
block_h = 30;
corner_r = 5;
grip_d = 22;

difference() {
    cuboid([block_l, block_w, block_h], rounding = corner_r, edges = "Z");
    fwd(block_w / 2) up(block_h / 2) xcyl(d = grip_d, l = block_l + 2, $fn = 48);
}
