// orcad wrapper for BelfrySCAD/BOSL2 (BSD-2-Clause): a screw organizer tray
// whose rounded outer shell and square pockets come from BOSL2 cuboid().
include <belfryscad-bosl2-0c6f402b/std.scad>

rows = 3;
cols = 4;
cell = 22;
bin_h = 14;
wall = 1.6;

outer_l = cols * cell + wall * 2;
outer_w = rows * cell + wall * 2;

difference() {
    cuboid([outer_l, outer_w, bin_h], rounding = 3, edges = "Z", anchor = BOTTOM);
    for (r = [0 : rows - 1], c = [0 : cols - 1])
        translate([-outer_l / 2 + wall + (c + 0.5) * cell,
                   -outer_w / 2 + wall + (r + 0.5) * cell, wall])
            cuboid([cell - wall, cell - wall, bin_h], chamfer = 1.5, anchor = BOTTOM);
}
