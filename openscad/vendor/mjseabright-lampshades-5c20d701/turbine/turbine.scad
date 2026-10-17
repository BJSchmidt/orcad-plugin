use <../geometry_functions.scad>;

// Main turbine blade geometry, with no base/mounting features (center hole,
// foot holes, etc.) — those are added by the files that use this module,
// so the same blade shape can be reused across different size/mount configs.
module turbine(
    height = 240,
    layer_height = 0.2,
    main_diameter = 80,
    divs_per_circle = 3,
    blade_sides = 5,
    circle_radius = 60,
    blade_swell = 32,
    blade_rotations = 1,
    twist_variation = 0    // 0-1: how much the twist rate slows at the top/bottom and speeds up through the middle (0 = constant rate, the original even spiral; near 1 = nearly stationary at the ends with a fast middle). Total rotation over the full height always still equals blade_rotations -- values >=1 will make the blades reverse direction briefly at the ends, so stay below 1.
) {
    for (h = [0:layer_height:height]) {
        translate([0,0,h]) rotate([0,0,0]) {
            linear_extrude(layer_height) {
                union() {
                    for (t = [0:360/divs_per_circle:360]) {
                        frac = h / height;
                        // ease frac so its rate of change dips at frac=0/1 and peaks at frac=0.5,
                        // while still running from exactly 0 to exactly 1 over the full height
                        eased_frac = frac - (twist_variation / (2*PI)) * sin(360*frac);
                        rotate([0,0,t]) translate([main_diameter/2,0,0]) {
                            rotate([0,0,350/blade_sides/2]) // fixed per-blade orientation offset (roughly half a polygon sector), doesn't change with height
                            rotate([0,0,eased_frac*blade_rotations*360]) regular_polygon(order=blade_sides, r=circle_radius + (blade_swell * sin(frac*180)));
                        }
                    }
                }
            }
        }
    }
}

// Standalone preview with default parameters
turbine();
