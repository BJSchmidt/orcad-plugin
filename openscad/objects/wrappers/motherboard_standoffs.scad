// orcad wrapper for eclecticc/ParametricCase (BSD-2-Clause): mini-itx.scad.
// motherboard_standoff() is the M3 standoff the Mini-ITX case screws its board
// onto, tapped for a threaded insert; orcad lays a set of them out on a strip.
use <param-case-b5f1ee43/mini-itx.scad>

miniitx_bottom_keepout = 6.35;
insert_r = 2.75;
insert_h = 5.0;
standoff_count = 4;
standoff_pitch = 12;

for (i = [0 : standoff_count - 1])
    translate([i * standoff_pitch, 0, 0]) motherboard_standoff();
