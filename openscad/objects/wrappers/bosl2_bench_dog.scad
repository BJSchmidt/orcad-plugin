// orcad wrapper for BelfrySCAD/BOSL2 (BSD-2-Clause): a bench dog turned from
// BOSL2's cyl() with a side spring hole. Upstream has no bench-dog module, so
// the wrapper supplies the profile and lets the library own the rounded body.
include <belfryscad-bosl2-0c6f402b/std.scad>

dog_d = 19.5;
dog_h = 50;
head_d = 25;
head_h = 8;
spring_hole_d = 6;
chamf = 1;

difference() {
    union() {
        cyl(d = dog_d, h = dog_h, chamfer = chamf, anchor = BOTTOM);
        up(dog_h) cyl(d = head_d, h = head_h, chamfer = chamf, anchor = BOTTOM);
    }
    up(dog_h * 0.55) back(dog_d / 2) ycyl(d = spring_hole_d, l = dog_d, $fn = 32);
}
