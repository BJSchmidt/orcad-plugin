/*
  Bucket and lid
  Parameters:
  radius - Outer radius of the bucket
  height - Full height of the bucket without lid
  thickness - thickness of the bucket
  
*/

// Bucket globals
thickness_bkt = 5; // 5mm
outer_radius_bkt = 50; // 50mm
height_bkt = 2 * 0.6 * outer_radius_bkt;
// lid globals
lid_text_depth = 4;
lid_text_id = "SHANG";
lid_text_size = 10;
font_name = "Liberation Sans";

module bucket_and_lid(radius, height, thickness) {
    // bucket without lid
    translate([0, 0, height / 2]) bucket_without_lid(radius, height, thickness);

    sphere_inner_radius = radius - thickness;
    // use Pythagorean theorem here
    lid_outer_radius = sqrt(radius * radius - height * height / 4);
    lid_inner_radius = sqrt(sphere_inner_radius * sphere_inner_radius - height * height / 4.0);
    // lid
    translate([radius + lid_outer_radius, 0, thickness]) bucket_lid(lid_outer_radius, lid_inner_radius, thickness);
}


module bucket_without_lid(radius0, height0, thickness0) {

    module drum(radius_dm, height_dm, thickness_dm) {
        module hollow_ball(rds, thk) {
            difference() {
                sphere(r = rds, $fa = 6);
                sphere(r = rds - thk, $fa = 6);
            }
        }

       intersection() {
           hollow_ball(radius_dm, thickness_dm);
           cylinder(h = height_dm, r = radius_dm, center = true);
       }
   }

    module bottom(radius_btm, thickness_btm) {
        translate([0, 0, -height0 / 2])
          cylinder(h = thickness_btm, r = radius_btm);
    }
    // use Pythagorean theorem here
    bottom_radius = sqrt(radius0 * radius0 - (height0 * height0) / 4);

    union() {
        drum(radius0, height0, thickness0);
        bottom(bottom_radius, thickness0);
    }

}

module bucket_lid(outer_radius, inner_radius, thickness) {
    difference() {
        union() {
            cylinder(h = thickness, r = outer_radius, center = false);
            translate([0, 0, -thickness])
              cylinder(h = thickness, r = inner_radius, center = false);
        };
        translate([-lid_text_size * 2.5, -lid_text_size * 0.5, thickness - lid_text_depth]) linear_extrude(height = lid_text_depth + 1, center = false) text(text = lid_text_id, font = font_name, size = lid_text_size);
    }
}

// show bucket and lid
bucket_and_lid(outer_radius_bkt, height_bkt, thickness_bkt);
