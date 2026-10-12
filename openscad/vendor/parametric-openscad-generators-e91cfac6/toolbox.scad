// Reusable geometry and layout modules for the projects in this repository.
// All dimensions are in millimetres.

module tb_rounded_rect_2d(width = 50, length = 50, radius = 5) {
assert(width > 0, "Width must be greater than zero.");
assert(length > 0, "Length must be greater than zero.");
assert(radius >= 0, "Corner radius cannot be negative.");
assert(radius <= min(width, length) / 2,
"Corner radius is too large for these dimensions.");

if (radius > 0) {
    offset(r = radius)
        square(
            [width - 2 * radius, length - 2 * radius],
            center = true
        );
} else {
    square([width, length], center = true);
}

}

module tb_rounded_solid(
width = 50,
length = 50,
height = 5,
radius = 5,
center = true
) {
assert(height > 0, "Height must be greater than zero.");

linear_extrude(height = height, center = center)
    tb_rounded_rect_2d(
        width = width,
        length = length,
        radius = radius
    );

}

module tb_rounded_ring(
width = 50,
length = 50,
height = 5,
radius = 5,
wall = 2,
center = true,
epsilon = 0.02
) {
assert(wall > 0, "Wall thickness must be greater than zero.");
assert(width > 2 * wall, "Wall is too large for the width.");
assert(length > 2 * wall, "Wall is too large for the length.");

difference() {
    tb_rounded_solid(
        width = width,
        length = length,
        height = height,
        radius = radius,
        center = center
    );

    tb_rounded_solid(
        width = width - 2 * wall,
        length = length - 2 * wall,
        height = height + 2 * epsilon,
        radius = max(radius - wall, 0),
        center = center
    );
}

}

// slot_length is the complete external length of the slot.
module tb_slot_hole(
diameter = 5,
height = 10,
slot_length = 10,
angle = 0
) {
assert(diameter > 0, "Hole diameter must be greater than zero.");
assert(height > 0, "Hole height must be greater than zero.");
assert(slot_length >= diameter,
"Slot length must be at least equal to its diameter.");

center_distance = slot_length - diameter;

rotate([0, 0, angle])
    hull() {
        translate([-center_distance / 2, 0, 0])
            cylinder(
                h = height,
                d = diameter,
                center = true
            );

        translate([center_distance / 2, 0, 0])
            cylinder(
                h = height,
                d = diameter,
                center = true
            );
    }

}

// Places children at four points separated by x_distance and y_distance.
module tb_pattern_4_corners(x_distance = 40, y_distance = 40) {
for (x = [-x_distance / 2, x_distance / 2])
for (y = [-y_distance / 2, y_distance / 2])
translate([x, y, 0])
children();
}

// Places children around a bolt circle or any other circular pattern.
module tb_pattern_circular(count = 4, diameter = 40, start_angle = 0) {
assert(count >= 1, "Pattern count must be at least one.");
assert(diameter >= 0, "Pattern diameter cannot be negative.");

for (index = [0 : count - 1]) {
    angle = start_angle + index * 360 / count;

    rotate([0, 0, angle])
        translate([diameter / 2, 0, 0])
            children();
}

}

// Creates an open enclosure while preserving a defined floor thickness.
module tb_hollow_enclosure(
width = 60,
length = 60,
height = 30,
wall = 2,
floor = 2,
radius = 4,
epsilon = 0.02
) {
assert(wall > 0, "Wall thickness must be greater than zero.");
assert(floor > 0, "Floor thickness must be greater than zero.");
assert(width > 2 * wall, "Wall is too large for the width.");
assert(length > 2 * wall, "Wall is too large for the length.");
assert(height > floor, "Height must be greater than floor thickness.");

difference() {
    tb_rounded_solid(
        width = width,
        length = length,
        height = height,
        radius = radius,
        center = false
    );

    translate([0, 0, floor])
        tb_rounded_solid(
            width = width - 2 * wall,
            length = length - 2 * wall,
            height = height - floor + epsilon,
            radius = max(radius - wall, 0),
            center = false
        );
}

}