use <rope_swirl.scad>;
use <../mounting_functions.scad>;

height = 240;
layer_height = 0.2;
main_diameter = 190;
divs_per_circle = 48;
spiral_radius = 5;
circle_diameter = 15.5;
swell = 15;
circle_sides = 8;
orbit_deg_per_mm = 3;
spin_deg_per_mm = 12;
center_hole_diameter = 40; // diameter of the hole through the center of the shade, for mounting on the adaptor (mm)
foot_hole_diameter = 4.5; // diameter of each straight foot-mounting hole, bottom to top (mm)
foot_hole_radius = 85;    // radius from the shade's center at which the foot-mounting holes sit (mm)
num_feet = 3;             // number of foot-mounting holes, evenly spaced around foot_hole_radius

difference() {
    rope_swirl(
        height = height,
        layer_height = layer_height,
        main_diameter = main_diameter,
        divs_per_circle = divs_per_circle,
        spiral_radius = spiral_radius,
        circle_diameter = circle_diameter,
        swell = swell,
        circle_sides = circle_sides,
        orbit_deg_per_mm = orbit_deg_per_mm,
        spin_deg_per_mm = spin_deg_per_mm
    );

    union() {
        center_hole(height = height, diameter = center_hole_diameter);
        foot_holes(hole_diameter = foot_hole_diameter, pattern_radius = foot_hole_radius, num_holes = num_feet, height = height);
    }
}
