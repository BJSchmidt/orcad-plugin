// ============================================================
// Tray
// Clips onto wooden rod, small storage tray
// ============================================================
$fn = 64;

// --- Rod ---
rod_diameter = 24;
rod_clearance = 0.5;

// --- Collar ---
collar_height = 20;
collar_wall = 3;

// --- Tray ---
tray_length = 125;
tray_width = 70;
tray_rim = 18;
wall = 3;
corner_radius = 2;

collar_r = rod_diameter/2 + collar_wall;

union() {
    // Collar - at origin
    difference() {
        cylinder(h = collar_height, r = collar_r);
        translate([0, 0, -1])
            cylinder(h = collar_height + 2, r = rod_diameter/2 + rod_clearance);
    }

    // Tray - bord court aligné avec le collier, s'étend vers l'avant (Y positif)
    translate([-tray_length/2, 0, 0])
        difference() {
            minkowski() {
                cube([tray_length - corner_radius*2,
                      tray_width - corner_radius*2,
                      tray_rim]);
                cylinder(r = corner_radius, h = 1);
            }
            // Hollow inside
            translate([wall, wall, wall])
                minkowski() {
                    cube([tray_length - wall*2 - corner_radius*2,
                          tray_width - wall*2 - corner_radius*2,
                          tray_rim]);
                    cylinder(r = corner_radius, h = 1);
                }
            // Cut out collar shape from tray rim
            translate([tray_length/2, -1, -1])
                cylinder(h = tray_rim + 2, r = collar_r);
        }
}
