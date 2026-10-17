// Nikon Diaphot TMD universal slide / 36 mm dish holder — revision 6 package — clamp geometry unchanged from revision 5
// Units: millimetres
//
// Coordinate convention when installed:
//   X = left/right between the two black stage arms
//   Y = lower/front edge toward the upper/rear crossbar
//   Z = upward
//
// Geometry carried forward unchanged from revision 5:
//   - main holder body increased from 3.50 mm to 4.75 mm
//   - clamp tabs therefore rise by exactly 1.25 mm
//   - support lip, clamp-tab thickness and every X/Y dimension are unchanged

part = is_undef(holder_part) ? "holder" : holder_part;
// Valid values: "holder", "fit_gauge"

$fn = 128;
epsilon = 0.03;

// ---------- Measured stage geometry ----------
frame_inner_span_x = 141.85;           // Inner face to inner face of black arms
frame_outer_span_x = 165.00;           // Outer face to outer face of black arms
holder_height_y = 63.00;               // Entire holder front-to-rear dimension
measured_frame_arm_height_z = 3.05;     // Reference measurement only
clamp_hinge_from_lower_edge_y = 25.25; // Lower arm edge to grey-clamp pivot

// ---------- Installed holder heights ----------
holder_body_height_z = 4.75;           // Previous 3.50 mm + requested 1.25 mm
clamp_tab_thickness_z = 2.00;           // Tab thickness above body
// Clamp-tab underside is therefore at Z = holder_body_height_z.
// Maximum holder height = 4.75 + 2.00 = 6.75 mm.

// ---------- Clamp engagement ----------
clamp_engagement_past_hinge_y = 3.00;
clamp_tab_start_from_lower_edge_y = 0.00;
clamp_tab_inboard_overlap_x = 2.00;

// ---------- FDM fit clearances ----------
// Per-side values. Set either to zero for nominal measured dimensions.
inner_fit_clearance_each_side_x = 0.20;
outer_fit_clearance_each_side_x = 0.25;

holder_body_width_x = frame_inner_span_x - 2*inner_fit_clearance_each_side_x;
clamp_tab_outer_span_x = frame_outer_span_x - 2*outer_fit_clearance_each_side_x;
clamp_tab_length_y = clamp_hinge_from_lower_edge_y + clamp_engagement_past_hinge_y;

// ---------- Body details ----------
body_corner_radius = 2.00;
clamp_tab_corner_radius = 1.25;
sample_offset_x = 0.00;
sample_offset_y = 0.00;

// ---------- Specimen dimensions ----------
slide_1_length = 75.25;
slide_1_width = 25.25;
slide_2_length = 76.00;
slide_2_width = 25.00;
slide_clearance_each_side = 0.20;
slide_corner_relief_radius = 0.60;

dish_diameter = 36.00;
dish_clearance_each_side = 0.25;

// ---------- Specimen support ----------
support_lip_width = 2.00;
support_lip_thickness_z = 1.00;
finger_notch_diameter = 8.00;
finger_notch_overlap = 2.00;

universal_slide_length = max(slide_1_length, slide_2_length)
                         + 2*slide_clearance_each_side;
universal_slide_width = max(slide_1_width, slide_2_width)
                        + 2*slide_clearance_each_side;
universal_dish_diameter = dish_diameter + 2*dish_clearance_each_side;

y_min = -holder_height_y/2;
tab_y_min = y_min + clamp_tab_start_from_lower_edge_y;
tab_y_max = tab_y_min + clamp_tab_length_y;

module rounded_rectangle_2d(width, height, radius) {
    offset(r=radius)
        square([width-2*radius, height-2*radius], center=true);
}

module rounded_box_at_2d(x_min, y_min_local, x_max, y_max_local, radius) {
    translate([(x_min+x_max)/2, (y_min_local+y_max_local)/2])
        rounded_rectangle_2d(x_max-x_min, y_max_local-y_min_local, radius);
}

module body_outline_2d() {
    rounded_rectangle_2d(holder_body_width_x, holder_height_y, body_corner_radius);
}

module clamp_tabs_2d() {
    union() {
        rounded_box_at_2d(
            -clamp_tab_outer_span_x/2,
            tab_y_min,
            -holder_body_width_x/2 + clamp_tab_inboard_overlap_x,
            tab_y_max,
            clamp_tab_corner_radius
        );
        rounded_box_at_2d(
            holder_body_width_x/2 - clamp_tab_inboard_overlap_x,
            tab_y_min,
            clamp_tab_outer_span_x/2,
            tab_y_max,
            clamp_tab_corner_radius
        );
    }
}

module slide_shape_2d(length, width, add_notches=true) {
    union() {
        square([length, width], center=true);
        for (sx=[-1,1], sy=[-1,1])
            translate([sx*length/2, sy*width/2])
                circle(r=slide_corner_relief_radius);
        if (add_notches) {
            notch_r = finger_notch_diameter/2;
            notch_x = length/2 + notch_r - finger_notch_overlap;
            translate([-notch_x,0]) circle(r=notch_r);
            translate([ notch_x,0]) circle(r=notch_r);
        }
    }
}

module universal_pocket_2d() {
    union() {
        slide_shape_2d(universal_slide_length, universal_slide_width, true);
        circle(d=universal_dish_diameter);
    }
}

module universal_aperture_2d() {
    union() {
        square([
            universal_slide_length - 2*support_lip_width,
            universal_slide_width - 2*support_lip_width
        ], center=true);
        circle(d=universal_dish_diameter - 2*support_lip_width);
    }
}

module holder() {
    difference() {
        union() {
            linear_extrude(height=holder_body_height_z)
                body_outline_2d();

            translate([0,0,holder_body_height_z])
                linear_extrude(height=clamp_tab_thickness_z)
                    clamp_tabs_2d();
        }

        // Recess for either slide format or the 36 mm dish.
        translate([sample_offset_x,sample_offset_y,support_lip_thickness_z])
            linear_extrude(
                height=holder_body_height_z + clamp_tab_thickness_z
                       - support_lip_thickness_z + epsilon
            ) universal_pocket_2d();

        // Optical opening through the underside, leaving the support lip.
        translate([sample_offset_x,sample_offset_y,-epsilon])
            linear_extrude(
                height=holder_body_height_z + clamp_tab_thickness_z + 2*epsilon
            ) universal_aperture_2d();
    }
}

module fit_gauge() {
    gauge_border = 7.0;
    union() {
        linear_extrude(height=holder_body_height_z)
            difference() {
                body_outline_2d();
                rounded_rectangle_2d(
                    holder_body_width_x-2*gauge_border,
                    holder_height_y-2*gauge_border,
                    max(0.8, body_corner_radius-0.8)
                );
            }
        translate([0,0,holder_body_height_z])
            linear_extrude(height=clamp_tab_thickness_z)
                clamp_tabs_2d();
    }
}

if (part == "fit_gauge")
    fit_gauge();
else
    holder();
