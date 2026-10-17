// orcad wrapper for BelfrySCAD/BOSL2 (BSD-2-Clause): a caliper stand built
// from BOSL2 cuboid() with a jaw slot cut in the upright.
include <belfryscad-bosl2-0c6f402b/std.scad>

base_w = 90;
base_d = 45;
base_h = 6;
post_w = 16;
post_h = 60;
jaw_gap = 12;
jaw_depth = 30;

difference() {
    union() {
        cuboid([base_w, base_d, base_h], rounding = 2, edges = "Z", anchor = BOTTOM);
        back(base_d / 2 - post_w / 2)
            cuboid([base_w, post_w, post_h], rounding = 2, edges = "Z", anchor = BOTTOM);
    }
    back(base_d / 2 - post_w / 2) up(post_h - jaw_gap / 2 - post_w)
        cuboid([post_w + 2, jaw_depth, jaw_gap]);
}
