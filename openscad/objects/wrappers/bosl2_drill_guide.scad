// orcad wrapper for BelfrySCAD/BOSL2 (BSD-2-Clause): a drill guide. BOSL2's
// cuboid() makes the rounded block and cyl() bores the bushing holes.
include <belfryscad-bosl2-0c6f402b/std.scad>

guide_l = 90;
guide_w = 30;
guide_h = 20;
bushing_d = 8;
hole_count = 6;
hole_spacing = 13;

difference() {
    cuboid([guide_l, guide_w, guide_h], rounding = 2);
    for (i = [0 : hole_count - 1])
        right(-(hole_count - 1) * hole_spacing / 2 + i * hole_spacing)
            cyl(d = bushing_d, h = guide_h + 2, $fn = 32);
}
