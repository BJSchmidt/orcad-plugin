// orcad wrapper for BelfrySCAD/BOSL2 (BSD-2-Clause): BOSL2's rabbit_clip()
// printed as the double-sided flex clamp it is, with the length and snap
// exposed as catalog parameters.
include <belfryscad-bosl2-0c6f402b/std.scad>
include <belfryscad-bosl2-0c6f402b/joiners.scad>

clip_length = 8;
clip_width = 7;
clip_thickness = 0.8;
clip_snap = 0.75;
clip_depth = 5;
clip_compression = 0.2;

rabbit_clip("double", length = clip_length, width = clip_width, snap = clip_snap,
            thickness = clip_thickness, depth = clip_depth,
            compression = clip_compression, lock = false, anchor = BOTTOM);
