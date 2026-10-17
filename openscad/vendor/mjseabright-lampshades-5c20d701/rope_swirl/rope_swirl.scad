use <../geometry_functions.scad>;

// Main rope-swirl geometry, with no base/mounting features (center hole,
// foot holes, etc.) — those are added by the files that use this module,
// so the same shape can be reused across different size/mount configs.
module rope_swirl(
    height = 180,
    layer_height = 0.2,
    main_diameter = 120,
    divs_per_circle = 36,
    spiral_radius = 6,
    circle_diameter = 12.5,
    swell = 15,
    circle_sides = 10,       // number of sides of each spiralling circle's polygon shape
    orbit_deg_per_mm = 4,    // degrees each spiralling circle orbits around its main circle per mm of height
    spin_deg_per_mm = 8      // degrees each spiralling circle additionally spins in place per mm of height
) {
    for (h = [0:layer_height:height]) {
        translate([0,0,h]) rotate([0,0,-h/2]) {
            linear_extrude(layer_height) {
                union() {
                    for (t = [0:360/divs_per_circle:360]) {
                        rotate([0,0,t]) translate([main_diameter/2 + swell*sin((h/height)*180),0,0]) {
                            rotate([0,0,h*orbit_deg_per_mm]) translate([spiral_radius,0,0]) rotate([0,0,-h*orbit_deg_per_mm + h*spin_deg_per_mm]) regular_polygon(order=circle_sides, r=circle_diameter/2 + (2 * sin((h/height)*180)));
                        }
                    }
                    regular_polygon(r=main_diameter/2 + 5, order=divs_per_circle);
                }
            }
        }
    }
}

// Standalone preview with default parameters
rope_swirl();
