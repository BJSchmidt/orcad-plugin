// ============================================================
// Glasses holder
// Clips onto wooden rod, holds 2 pairs of glasses
// T-shape: 2 short arms + 1 long perpendicular arm
// ============================================================
$fn = 64;

// --- Rod ---
rod_diameter = 24;
rod_clearance = 0.5;

// --- Collar ---
collar_height = 20;
collar_wall = 3;
collar_r = rod_diameter/2 + collar_wall;

// --- Arms ---
arm_total_length = 180;
arm_width = 3;
arm_thickness_center = 18;
arm_thickness_tip = 10;
lip_height = 3;

// --- Perpendicular arm ---
perp_arm_length = 100;

// --- Rounding ---
corner_r = 2;

union() {
    // Collar
    difference() {
        cylinder(h = collar_height, r = collar_r);
        translate([0, 0, -1])
            cylinder(h = collar_height + 2, r = rod_diameter/2 + rod_clearance);
    }

    // Left arm with rounded bottom-left corner
    hull() {
        translate([-arm_total_length/2 + corner_r, -arm_width/2, 0])
            cube([arm_total_length/2 - collar_r - corner_r, arm_width, arm_thickness_center]);
        translate([-arm_total_length/2, -arm_width/2, corner_r])
            cube([arm_total_length/2 - collar_r, arm_width, arm_thickness_center - corner_r]);
        translate([-arm_total_length/2 + corner_r, -arm_width/2, corner_r])
            rotate([-90, 0, 0])
                cylinder(r = corner_r, h = arm_width);
    }

    // Right arm with rounded bottom-right corner
    hull() {
        translate([collar_r, -arm_width/2, 0])
            cube([arm_total_length/2 - collar_r - corner_r, arm_width, arm_thickness_center]);
        translate([collar_r, -arm_width/2, corner_r])
            cube([arm_total_length/2 - collar_r, arm_width, arm_thickness_center - corner_r]);
        translate([arm_total_length/2 - corner_r, -arm_width/2, corner_r])
            rotate([-90, 0, 0])
                cylinder(r = corner_r, h = arm_width);
    }

    // Left lip with rounded top corners
    hull() {
        translate([-arm_total_length/2, -arm_width/2, arm_thickness_center])
            cube([arm_thickness_tip, arm_width, lip_height - corner_r]);
        translate([-arm_total_length/2 + corner_r, -arm_width/2, arm_thickness_center])
            cube([arm_thickness_tip - corner_r*2, arm_width, lip_height]);
        translate([-arm_total_length/2 + corner_r, -arm_width/2, arm_thickness_center + lip_height - corner_r])
            rotate([-90, 0, 0])
                cylinder(r = corner_r, h = arm_width);
        translate([-arm_total_length/2 + arm_thickness_tip - corner_r, -arm_width/2, arm_thickness_center + lip_height - corner_r])
            rotate([-90, 0, 0])
                cylinder(r = corner_r, h = arm_width);
    }

    // Right lip with rounded top corners
    hull() {
        translate([arm_total_length/2 - arm_thickness_tip, -arm_width/2, arm_thickness_center])
            cube([arm_thickness_tip, arm_width, lip_height - corner_r]);
        translate([arm_total_length/2 - arm_thickness_tip + corner_r, -arm_width/2, arm_thickness_center])
            cube([arm_thickness_tip - corner_r*2, arm_width, lip_height]);
        translate([arm_total_length/2 - arm_thickness_tip + corner_r, -arm_width/2, arm_thickness_center + lip_height - corner_r])
            rotate([-90, 0, 0])
                cylinder(r = corner_r, h = arm_width);
        translate([arm_total_length/2 - corner_r, -arm_width/2, arm_thickness_center + lip_height - corner_r])
            rotate([-90, 0, 0])
                cylinder(r = corner_r, h = arm_width);
    }

    // Perpendicular arm with rounded bottom corner
    hull() {
        translate([-arm_width/2, -perp_arm_length + corner_r, 0])
            cube([arm_width, perp_arm_length - collar_r - corner_r, arm_thickness_center]);
        translate([-arm_width/2, -perp_arm_length, corner_r])
            cube([arm_width, perp_arm_length - collar_r, arm_thickness_center - corner_r]);
        translate([-arm_width/2, -perp_arm_length + corner_r, corner_r])
            rotate([0, 90, 0])
                cylinder(r = corner_r, h = arm_width);
    }

    // Perpendicular lip with rounded top corners
    hull() {
        translate([-arm_thickness_tip/2, -perp_arm_length, 0])
            cube([arm_thickness_tip, arm_width, arm_thickness_center + lip_height - corner_r]);
        translate([-arm_thickness_tip/2 + corner_r, -perp_arm_length, 0])
            cube([arm_thickness_tip - corner_r*2, arm_width, arm_thickness_center + lip_height]);
        translate([-arm_thickness_tip/2 + corner_r, -perp_arm_length, arm_thickness_center + lip_height - corner_r])
            rotate([0, 90, 0])
                cylinder(r = corner_r, h = arm_thickness_tip - corner_r*2);
    }
}
