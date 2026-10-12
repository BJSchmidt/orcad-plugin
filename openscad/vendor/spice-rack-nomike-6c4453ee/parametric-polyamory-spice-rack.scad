/*
Parametric Polyamory Spice Rack

Copyright 2024 nomike[AT]nomike[DOT]com

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

$fn = $preview ? 32 : 64;
floor_board_width = 45.5;
floor_width = 60;
floor_board_height = 5;
side_wall_width = 9;

front_height = 55;
front_width = 8;
front_bar_type = "round"; // round or square
front_bar_angle = 0;       // if front_bar_type is round, this does not have any effect
front_bar_width = 6;
front_bar_height = 50;

back_height = 65;
back_depth = 8;

wall_thickness = 4;

screw_hole_upper_diameter = 4;
screw_hole_lower_diameter = 7;
screw_hole_length = 12;

screw_hole_height = 50;


total_depth = 55 + front_width;
floor_height = 10;

screw_hole_insert_depth = 2;

logo_depth_difference = 10;
logo_bottom_offset = 27;

centerlogo_color_offset = 0;

position = "left"; // center, left, right
wood_insert_close_thickness = 2;

fillet_radius = 3;

// rotate([0, -90, 0])
union() {
    // Floor
    difference() {
        cube([total_depth, side_wall_width, floor_height]);
        if(position == "right" || position == "center") {
            translate([(total_depth - floor_board_width)/2, side_wall_width - wood_insert_close_thickness, (floor_height - floor_board_height) / 2]) cube([floor_board_width, wood_insert_close_thickness, floor_board_height]);
        }
        translate([(total_depth - floor_board_width)/2, wood_insert_close_thickness, (floor_height - floor_board_height) / 2]) cube([floor_board_width, side_wall_width - (2 * wood_insert_close_thickness), floor_board_height]);
        if(position == "left" || position == "center") {
            translate([(total_depth - floor_board_width)/2, 0, (floor_height - floor_board_height) / 2]) cube([floor_board_width, wood_insert_close_thickness, floor_board_height]);
        }
    }

    // Front
    difference() {
        cube([front_width, side_wall_width, front_height]);
        if(front_bar_type == "square") {
            translate([0, 0, front_bar_height]) {
                if(position == "right" || position == "center") {
                    translate([front_width / 2, side_wall_width - (wood_insert_close_thickness / 2), 0]) rotate([0, front_bar_angle, 0]) cube([front_bar_width, wood_insert_close_thickness, front_bar_width], center=true);
                }
                translate([front_width / 2, ((side_wall_width - (2 * wood_insert_close_thickness)) / 2) + wood_insert_close_thickness, 0]) rotate([0, front_bar_angle, 0]) cube([front_bar_width, side_wall_width - (2 * wood_insert_close_thickness), front_bar_width], center=true);
                if(position == "left" || position == "center") {
                    translate([front_width / 2, wood_insert_close_thickness / 2, 0]) rotate([0, front_bar_angle, 0]) cube([front_bar_width, wood_insert_close_thickness, front_bar_width], center=true);
                }
            }
        } else {
            translate([0, 0, front_bar_height]) {
                if(position == "right" || position == "center") {
                    translate([front_width / 2, side_wall_width, 0]) rotate([90, 0, 0]) cylinder(d=front_bar_width, h=wood_insert_close_thickness);
                }
                translate([front_width / 2, side_wall_width - wood_insert_close_thickness, 0]) rotate([90, 0, 0]) cylinder(d=front_bar_width, h=side_wall_width - (2 * wood_insert_close_thickness));
                if(position == "left" || position == "center") {
                    translate([front_width / 2, wood_insert_close_thickness, 0]) rotate([90, 0, 0]) cylinder(d=front_bar_width, h=wood_insert_close_thickness);
                }
            }
        }
    }

    // back
    difference() {
        translate([total_depth - back_depth, 0, 0]) cube([back_depth, side_wall_width, back_height]);

        translate([total_depth, side_wall_width / 2, screw_hole_height]) rotate([0, -90, 0]) union() {
            hull() {
                cylinder(d=screw_hole_upper_diameter, h=back_depth);
                translate([screw_hole_length - screw_hole_upper_diameter, 0, 0]) cylinder(d=screw_hole_upper_diameter, h=back_depth);
            }
            translate([0, 0, back_depth - screw_hole_insert_depth]) hull() {
                cylinder(d=screw_hole_lower_diameter, h=screw_hole_insert_depth);
                translate([screw_hole_length - screw_hole_upper_diameter, 0]) cylinder(d=screw_hole_lower_diameter, h=screw_hole_insert_depth);
            }
            cylinder(d=screw_hole_lower_diameter, h=back_depth);
        }
    }

    // Front section
    *difference(){
        color("red") cube([side_wall_width, front_bar_height + (wall_thickness * 2), front_height]);
        if(front_bar_type == "rectangular") {
            translate([0, wall_thickness, front_height - wall_thickness - front_bar_width]) color("blue") cube([side_wall_width, front_bar_height, front_bar_width]);
        } else {
            translate([0, wall_thickness, front_height - wall_thickness - front_bar_width]) color("blue") rotate([0, 90, 0]) cylinder(d=front_bar_width, h=front_bar_height);
        }
    }   

    // Wall mount section
    *translate([0, front_bar_height + (wall_thickness * 2) + floor_width + (wall_thickness * 2), 0]) difference() {
        color("green") cube([side_wall_width, wall_mount_depth, floor_board_height + (wall_thickness * 2) + wall_mount_height]);
        translate([0, 0, _screw_hole_height]) union() {
            translate([side_wall_width / 2, wall_mount_depth, screw_hole_length]) rotate([90, 0, 0]) color("orange") cylinder(d=screw_hole_upper_diameter, h=wall_mount_depth);
            translate([(side_wall_width / 2) - (screw_hole_upper_diameter / 2), 0, 0]) cube([screw_hole_upper_diameter, wall_mount_depth, screw_hole_length]);
            translate([side_wall_width / 2, wall_mount_depth, 0]) rotate([90, 0, 0]) cylinder(d=screw_hole_lower_diameter, h=wall_mount_depth);
        }
    }
    
    // Poly logo
    translate([total_depth / 2, side_wall_width, logo_bottom_offset]) {
        resize([total_depth - logo_depth_difference, 0, 35])
        rotate([90, 0, 0]) {
            union() {
                translate([0, 0, 0 + centerlogo_color_offset]) linear_extrude(height=side_wall_width - (2 * centerlogo_color_offset)) import("heart-icon.svg", center=true);
                translate([0, 0, 0 + (2 * centerlogo_color_offset)]) linear_extrude(height=side_wall_width - (4 * centerlogo_color_offset)) import("infinity.svg", center=true);
            }
        }
    }

    // Fillets
    translate([front_width, 0, floor_height]) difference() {
        cube([fillet_radius, side_wall_width, fillet_radius]);
        translate([fillet_radius, side_wall_width, fillet_radius]) rotate([90, 0, 0]) cylinder(r=fillet_radius, h=side_wall_width);
    }

    translate([total_depth - front_width - fillet_radius, 0, floor_height]) difference() {
        cube([fillet_radius, side_wall_width, fillet_radius]);
        translate([0, side_wall_width, fillet_radius]) rotate([90, 0, 0]) cylinder(r=fillet_radius, h=side_wall_width);
    }

}
