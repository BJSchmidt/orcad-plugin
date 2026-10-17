// Straight hole through the center of a shade, for mounting on the adaptor.
module center_hole(height, diameter) {
    translate([0,0,-1]) cylinder(h=height+2, d=diameter, $fa=1);
}

// One straight vertical foot-mounting hole per num_holes, evenly spaced around
// pattern_radius, cut fully through the given height.
module foot_holes(hole_diameter, pattern_radius, num_holes, height) {
    for (t = [0:360/num_holes:360]) {
        rotate([0,0,t]) translate([pattern_radius,0,-1])
            cylinder(h=height+2, d=hole_diameter, $fn=24);
    }
}
