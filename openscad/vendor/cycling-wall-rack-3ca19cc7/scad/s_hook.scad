// ============================================================
// S-hook
// ============================================================
$fn = 64;

wire = 3;
h = 10;

// --- Top loop ---
loop_r = 5;
loop_spacing = 20;

// --- Middle loop (perpendicular) ---
middle_loop_r = 20;
middle_loop_spacing = 40;
middle_offset_x = 0;
middle_offset_y = -40;

// --- Connecting bar ---
bar_width = 3;

// --- Rectangle cutout ---
cutout_x = -21.5;
cutout_y = -60;
cutout_w = 20;
cutout_d = 40;

difference() {
    union() {
        // Top loop - stadium shape (vertical)
        translate([0,0,-1])
           linear_extrude(height = h+2)
              difference() {
                hull() {
                    translate([0, 0]) circle(r = loop_r);
                    translate([0, loop_spacing]) circle(r = loop_r);
                }
                hull() {
                    translate([0, 0]) circle(r = loop_r - wire);
                    translate([0, loop_spacing]) circle(r = loop_r - wire);
                }
            }

        // Middle loop - stadium shape (horizontal)
        translate([middle_offset_x, middle_offset_y, 0])
            linear_extrude(height = h)
                difference() {
                    hull() {
                        translate([0, 0]) circle(r = middle_loop_r);
                        translate([middle_loop_spacing, 0]) circle(r = middle_loop_r);
                    }
                    hull() {
                        translate([0, 0]) circle(r = middle_loop_r - wire);
                        translate([middle_loop_spacing, 0]) circle(r = middle_loop_r - wire);
                    }
                }

        // Connecting bar from top loop to middle loop
        linear_extrude(height = h)
            hull() {
                translate([0, -wire-1]) circle(r = bar_width/2);
                translate([0, -20]) circle(r = bar_width/2);
            }
    }

    // Rectangle cutout on the middle loop
    translate([cutout_x, cutout_y, -1])
        cube([cutout_w, cutout_d, h + 2]);
}
