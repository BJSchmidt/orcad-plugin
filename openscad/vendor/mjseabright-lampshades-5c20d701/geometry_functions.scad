module regular_polygon(order = 5, r=1){
     angles=[ for (i = [0:order-1]) i*(360/order) ];
     coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
     polygon(coords);
 }

function regular_polygon_side_length(order = 3, r = 1) = 2 * r * sin(360 / (2 * order));
function regular_polygon_radius_from_side_length(order = 3, side_length = 10) = side_length / (2 * sin(360 / (2 * order)));

// Solid cylinder with its outer top and/or bottom edge chamfered (45 degrees
// by default, since the radial and vertical cut both equal `chamfer`). Set
// chamfer_top/chamfer_bottom to false for an end that isn't a real exposed
// face (e.g. it butts against another part) -- chamfering a hidden seam
// creates a visible necked-in groove where the two parts meet.
module chamfered_cylinder(h, d, chamfer, fn = 64, chamfer_top = true, chamfer_bottom = true) {
    r = d / 2;
    bottom_pts = chamfer_bottom ? [[0, 0], [r - chamfer, 0], [r, chamfer]] : [[0, 0], [r, 0]];
    top_pts = chamfer_top ? [[r, h - chamfer], [r - chamfer, h], [0, h]] : [[r, h], [0, h]];
    rotate_extrude($fn = fn) polygon(points = concat(bottom_pts, top_pts));
}

// Cutter for a hole with a countersink chamfer at the z=0 and/or z=h faces.
// Subtract this instead of a plain cylinder to chamfer a hole's edges.
// Self-extends slightly past both faces, so no manual translate/epsilon is
// needed at the call site. Set chamfer_top/chamfer_bottom to false for a
// blind end that isn't a real exposed face -- otherwise the countersink
// flares open inside the solid instead of breaking a real edge.
module chamfered_hole(h, d, chamfer, fn = 32, chamfer_top = true, chamfer_bottom = true) {
    eps = 0.5;
    z0 = chamfer_bottom ? -eps : 0;
    z1 = chamfer_top ? h + eps : h;
    union() {
        translate([0, 0, z0]) cylinder(h = z1 - z0, d = d, $fn = fn);
        if (chamfer_bottom) {
            cylinder(h = chamfer, d1 = d + 2 * chamfer, d2 = d, $fn = fn);
        }
        if (chamfer_top) {
            translate([0, 0, h - chamfer]) cylinder(h = chamfer, d1 = d, d2 = d + 2 * chamfer, $fn = fn);
        }
    }
}

// Linear-extrudes a CONVEX 2D child shape into a solid with both the top and
// bottom outer edges chamfered, by hull-lofting a shrunk copy of the profile
// up to full size over the chamfer height at each end. Only valid for convex
// profiles -- hull() will fill in any concavity (e.g. a hole), so cut those
// afterwards with a separate difference(), not inside the extruded child.
module chamfered_extrude(h, chamfer) {
    union() {
        hull() {
            linear_extrude(0.01) offset(delta = -chamfer) children();
            translate([0, 0, chamfer]) linear_extrude(0.01) children();
        }
        translate([0, 0, chamfer]) linear_extrude(h - 2 * chamfer) children();
        hull() {
            translate([0, 0, h - chamfer]) linear_extrude(0.01) children();
            translate([0, 0, h - 0.01]) linear_extrude(0.01) offset(delta = -chamfer) children();
        }
    }
}
