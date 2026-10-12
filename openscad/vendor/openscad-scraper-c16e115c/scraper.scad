// Kitchen Scraper

$fa = 1;
$fs = 0.4;
$fn=50;
text_depth = .2;

Scraper("Kitchen", 0, 0, 0, 100, 50, 3);

module Scraper(text, x, y, z, w, h, t) {
    // body
    difference() {
         translate([-w/2, y, z]) roundedcube_simple(size=[w, h, t], radius=1);
        translate([0, y + h/3, t-text_depth]) {
            // convexity is needed for correct preview
            // since characters can be highly concave
            linear_extrude(height=text_depth, convexity=4)
                text(text, 
                     size=h * .15,
                     font="Courier",
                     halign="center",
                     valign="center");
        }  
    }
        
    // grip
    grip_len = 0.8 * w;
    grip_rad = t * 0.45;
    translate([0, h-t, t]) hotdog(l=grip_len, r=grip_rad);
  
    translate([0, h-t, t]) hotdog(l=grip_len, r=grip_rad);
   
    // edge
    translate([-w/2, 0, 0]) rounded_edge(h, w, t, 0.3);
}

module rounded_edge(h, w, t, r) {
    translate([r, r, r])
    minkowski() {
        edge(h-r*2, w-r*2, t-r*2);
        sphere(r);
    }
}

module edge(h, w, t) {
   cube([w, 2*t, t]);
   translate([w, 0, 0])
       rotate([90,0,-90]) linear_extrude(w) {
           polygon(points = [[0,0], [0,t], [2*t,0]]);
       }
}

module hotdog(l, r) {
    rotate([0, 90, 0]) {
        translate([0, 0, l/2]) sphere(r);
        translate([0, 0, -l/2]) sphere(r);
        cylinder(r=r, h=l, center=true);
    }
}


module roundedcube_simple(size = [1, 1, 1], center = false, radius = 0.5) {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate = (center == false) ?
		[radius, radius, radius] :
		[
			radius - (size[0] / 2),
			radius - (size[1] / 2),
			radius - (size[2] / 2)
	];

	translate(v = translate)
	minkowski() {
		cube(size = [
			size[0] - (radius * 2),
			size[1] - (radius * 2),
			size[2] - (radius * 2)
		]);
		sphere(r = radius);
	}
}
