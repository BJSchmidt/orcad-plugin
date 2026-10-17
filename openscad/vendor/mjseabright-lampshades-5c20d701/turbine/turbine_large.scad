use <turbine.scad>;
use <../mounting_functions.scad>;

height = 240;             // total height of the lampshade (mm)
layer_height = 0.2;       // vertical distance between cross-sections (mm); match to your printer's layer height
main_diameter = 90;     // diameter of the ring the blades are centered on, before adding blade radius (mm)
divs_per_circle = 3;      // number of blades repeated around the circle
blade_sides = 5;          // number of sides of each blade's polygon shape (e.g. 5 = pentagon); also sets each blade's fixed rotational alignment below
circle_radius = 54;     // radius of each blade's polygon shape (mm)
blade_swell = 32;       // amplitude of the sine bulge applied to each blade's own radius over the height (mm)
blade_rotations = 5/5;  // number of full 360° spins of each blade over the whole height (negative = reverse spin direction)
twist_variation = 0.5;    // 0-1: how much the twist rate slows at the top/bottom and speeds up through the middle (0 = constant rate; near 1 = nearly stationary at the ends with a fast middle)
center_hole_diameter = 40; // diameter of the hole through the center of the shade, for mounting on the adaptor (mm)
foot_hole_diameter = 4.5; // diameter of each straight foot-mounting hole, bottom to top (mm)
foot_hole_radius = 70;    // radius from the shade's center at which the foot-mounting holes sit, one per blade, on the line from center through that blade's center (mm)


difference() {
    turbine(
        height = height,
        layer_height = layer_height,
        main_diameter = main_diameter,
        divs_per_circle = divs_per_circle,
        blade_sides = blade_sides,
        circle_radius = circle_radius,
        blade_swell = blade_swell,
        blade_rotations = blade_rotations,
        twist_variation = twist_variation
    );

    // base/mounting geometry: center adaptor hole + one straight vertical
    // foot-mounting hole per blade, same angle as the blade, at foot_hole_radius
    union() {
        center_hole(height = height, diameter = center_hole_diameter);
        foot_holes(hole_diameter = foot_hole_diameter, pattern_radius = foot_hole_radius, num_holes = divs_per_circle, height = height);
    }
}
