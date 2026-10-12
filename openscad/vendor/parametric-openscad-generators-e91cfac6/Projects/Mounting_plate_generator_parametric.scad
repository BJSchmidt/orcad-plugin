/*
Parametric mounting plate generator

Creates a rectangular mounting plate with rounded corners and
four configurable mounting holes.

Author: Lourenço Guerreiro
Units: millimetres

*/

use <../toolbox.scad>

$fn = 64;

plate_width = 80;
plate_length = 55;
plate_thickness = 5;
corner_radius = 6;

hole_diameter = 5;
slot_length = 10;
slot_angle = 0;

hole_offset_x = 10;
hole_offset_y = 10;

epsilon = 0.02;

module mounting_plate() {
pattern_width = plate_width - 2 * hole_offset_x;
pattern_length = plate_length - 2 * hole_offset_y;

assert(plate_width > 0,
       "Plate width must be greater than zero.");

assert(plate_length > 0,
       "Plate length must be greater than zero.");

assert(plate_thickness > 0,
       "Plate thickness must be greater than zero.");

assert(hole_offset_x >= slot_length / 2,
       "The holes are too close to the left or right edge.");

assert(hole_offset_y >= hole_diameter / 2,
       "The holes are too close to the top or bottom edge.");

assert(pattern_width >= 0,
       "Horizontal hole offset is too large.");

assert(pattern_length >= 0,
       "Vertical hole offset is too large.");

difference() {
    tb_rounded_solid(
        width = plate_width,
        length = plate_length,
        height = plate_thickness,
        radius = corner_radius
    );

    tb_pattern_4_corners(
        x_distance = pattern_width,
        y_distance = pattern_length
    )
        tb_slot_hole(
            diameter = hole_diameter,
            height = plate_thickness + 2 * epsilon,
            slot_length = slot_length,
            angle = slot_angle
        );
}

}

mounting_plate();