module golfball(height = 180, swell = 60, layer_height = 0.2, main_diameter = 120, dimple_v_spacing = 6, num_dimple_per_rot = 50) {
    function outer_profile(h) = main_diameter + swell * sin((h / height) * 200 - 30);
    function dimple_scaling(d) = (d) * 3.141 / num_dimple_per_rot;

    difference() {
        union() {
            for (h = [0:layer_height:height]) {
                layer_diameter = outer_profile(h);
                translate([0,0,h]) linear_extrude (layer_height) circle(d = layer_diameter, $fn=180);
            }
        }

        union() {
            for (h = [0+dimple_v_spacing/2:dimple_v_spacing:height-dimple_v_spacing/2]) {
                layer_diameter = outer_profile(h);
                dimple_size = dimple_scaling(layer_diameter);
                dimple_offset = dimple_size / 2.5;
                for (i = [0:360/num_dimple_per_rot:360]) {
                    rotate_offset = (h - dimple_v_spacing/2 % (2 * dimple_v_spacing)) / dimple_v_spacing * (0.5 * 360 / num_dimple_per_rot);
                    rotate([0,0,i+rotate_offset]) translate([layer_diameter/2+dimple_offset,0,h]) sphere(d=dimple_size, $fn=45);
                }
            }
        }
    }
}

// Standalone preview with default parameters
golfball();
