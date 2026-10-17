use <../geometry_functions.scad>;

module rotated_star(height = 180, layer_height = 0.2, main_radius = 70) {
    union() {
        for (a = [0:layer_height:height]) {
            translate([0,0,a]) rotate([0,0,(a/height) * 2 * 180 / 6]){
                linear_extrude(layer_height) {
                    regular_polygon(order=3, r=main_radius
                 + 20*sin((a/height)*180));
                }
            }
        }
        rotate([0,0,60]) for (a = [0:layer_height:height]) {
            translate([0,0,a]) rotate([0,0,-(a/height) * 2 * 180 / 6]){
                linear_extrude(layer_height) {
                    regular_polygon(order=3, r=main_radius
                 + 20*sin((a/height)*180));
                }
            }
        }
    }
}

// Standalone preview with default parameters
rotated_star();
