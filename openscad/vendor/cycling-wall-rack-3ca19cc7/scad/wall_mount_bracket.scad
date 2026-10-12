// ============================================================
// Wall mount bracket
// Mounts to wall with 3M tape, holds vertical wooden rod
// ============================================================

$fn = 64; // curve resolution

// --- Rod settings ---
rod_diameter = 24;    // diameter of the wooden rod (mm)
rod_inset = -4;       // how deep the rod sits into the notch (mm)
rod_clearance = 0;    // extra tolerance around rod (mm)

// --- Front face (small side, facing the rod) ---
front_width = 30;     // width of the front face (mm)
front_height = 80;    // height of the front face (mm)
front_depth = 30;     // depth of the straight section (mm)

// --- Back face (large side, against the wall) ---
back_extra = 20;      // how much wider/taller at the wall (mm)
back_taper = 30;      // depth of the tapered section (mm)

// --- General ---
wall = 3;             // wall thickness (mm)
corner_radius = 0;    // edge rounding radius (0 = sharp edges)

// --- Computed values ---
total_depth = front_depth + back_taper;
total_width = front_width + back_extra;
total_height = front_height + back_extra;

// ============================================================
difference() {
    intersection() {
        // Main body: straight section + tapered section toward wall
        minkowski() {
            union() {
                // Straight front section
                cube([front_width - corner_radius*2,
                      front_depth - corner_radius*2,
                      front_height - corner_radius*2]);

                // Tapered section (wider at the wall)
                translate([0, front_depth - corner_radius*2, 0])
                    hull() {
                        cube([front_width - corner_radius*2, wall, front_height - corner_radius*2]);
                        translate([-back_extra/2, back_taper, -back_extra/2])
                            cube([front_width + back_extra - corner_radius*2, wall, front_height + back_extra - corner_radius*2]);
                    }
            }
            sphere(r = corner_radius);
        }

        // Clip back face flat (for clean wall contact)
        translate([-total_width, 0, -total_height])
            cube([total_width*3, total_depth, total_height*3]);
    }

    // Vertical half-cylinder notch for rod
    translate([front_width/2 + corner_radius, rod_inset, -1])
        cylinder(h = front_height + 2, r = rod_diameter/2 + rod_clearance);

    // Open front face so rod can slide in
    translate([corner_radius, -1, -1])
        cube([front_width, rod_inset + rod_clearance, front_height + 2]);
}