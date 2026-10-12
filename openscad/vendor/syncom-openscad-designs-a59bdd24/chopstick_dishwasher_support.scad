// This design is for holding/supporting chopsticks in my dishwasher utensil basket
$fn = 30;

// Adjust the legnth and width to suit your needs
length = 86; // in millimeters
width = 0.9 * length;
height = 10;
upper_depth_percentage = 0.85;
lower_depth_percentage = 0.0;
leg_height = (0.6 + lower_depth_percentage) * height;
leg_radius = 0.05 * length;

module chopstick_base() {
    module outer_cube() {
        cube(size=[length, width, height], center=true);
    }
    module inner_cube() {
        cube(size=[length * 0.95, width * 0.95, height], center=true);
    }
    
    module leg(ht, rds) {
        cylinder(h = ht, r = rds, center = false);
    }
    
    leg_x = length * 0.5 - leg_radius;
    leg_y = width * 0.5 - leg_radius;
    leg_z = -(leg_height + (upper_depth_percentage - 0.5 + 0.01) * height);
    
    difference() {
        outer_cube();
        union() {
            for (i = [-5:1:5], j = [-4:1:4]) {         
                translate([i * 7, j * 7, 0])
                cylinder(h=height, r=1.5, center=true);
                };
            translate([0, 0, height * (1 - upper_depth_percentage)])
            inner_cube();      
            translate([0, 0, - height * (1 - lower_depth_percentage)])
            inner_cube();                
            }
    };
    translate([leg_x, leg_y, leg_z]) leg(leg_height, leg_radius);
    translate([-leg_x, leg_y, leg_z]) leg(leg_height, leg_radius);
    translate([leg_x, -leg_y, leg_z]) leg(leg_height, leg_radius);
    translate([-leg_x, -leg_y, leg_z]) leg(leg_height, leg_radius);
    translate([0, 0, leg_z]) leg(leg_height, leg_radius);
}

chopstick_base();