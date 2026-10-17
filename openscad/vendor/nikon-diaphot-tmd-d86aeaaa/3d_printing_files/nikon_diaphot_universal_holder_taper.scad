// Nikon Diaphot TMD universal slide / 36 mm dish holder
// Revision 6 — no-clamp holder with taper along the 63 mm depth
// Units: millimetres
//
// Coordinate convention when installed:
//   X = left/right between the two black specimen-frame arms
//   Y = lower/front to upper/rear across the 63 mm holder depth
//   Z = upward
//
// Corrected wedge geometry:
//   - there is NO taper through the 3.50 mm Z height
//   - the top and bottom faces have the same plan footprint
//   - lower/front nominal width = 143.95 mm
//   - upper/rear nominal width = 141.45 mm
//   - each side changes by 1.25 mm along Y
//   - rotate the printed holder 180 degrees in the stage to reverse the wedge direction

$fn = 128;
epsilon = 0.03;

// ---------- Measured specimen-frame geometry ----------
frame_inner_span_x = 141.85;
holder_depth_y = 63.00;

// ---------- End widths and taper direction ----------
inner_fit_clearance_each_side_x = 0.20;
narrow_end_width_x = frame_inner_span_x
                     - 2*inner_fit_clearance_each_side_x; // 141.45 mm
wedge_addition_each_side_x = 1.25;
wide_end_width_x = narrow_end_width_x
                   + 2*wedge_addition_each_side_x;       // 143.95 mm

// true: lower/front end is wide; false: upper/rear end is wide.
wide_end_at_lower_front = true;

// ---------- Holder body ----------
holder_body_height_z = 3.50;
body_corner_radius = 2.00;
rounded_corner_segments_per_quadrant = 32;
sample_offset_x = 0.00;
sample_offset_y = 0.00;

// ---------- Supported specimens ----------
slide_1_length = 75.25;
slide_1_width  = 25.25;
slide_2_length = 76.00;
slide_2_width  = 25.00;
slide_clearance_each_side = 0.20;
slide_corner_relief_radius = 0.60;

dish_diameter = 36.00;
dish_clearance_each_side = 0.25;

// ---------- Specimen support lip ----------
support_lip_width = 2.00;
support_lip_thickness_z = 1.00;

finger_notch_diameter = 8.00;
finger_notch_overlap = 2.00;

universal_slide_length = max(slide_1_length, slide_2_length)
                         + 2*slide_clearance_each_side;
universal_slide_width = max(slide_1_width, slide_2_width)
                        + 2*slide_clearance_each_side;
universal_dish_diameter = dish_diameter + 2*dish_clearance_each_side;

front_tangent_y = -holder_depth_y/2 + body_corner_radius;
rear_tangent_y  =  holder_depth_y/2 - body_corner_radius;

function clamp_value(value, low, high) = min(max(value, low), high);
function side_sign(x) = x < 0 ? -1 : (x > 0 ? 1 : 0);

// The rounded end corners retain their 2 mm radius. The long side walls taper
// linearly between the front and rear corner tangencies.
function wide_fraction_at_y(y) =
    wide_end_at_lower_front
    ? clamp_value((rear_tangent_y-y)/(rear_tangent_y-front_tangent_y), 0, 1)
    : clamp_value((y-front_tangent_y)/(rear_tangent_y-front_tangent_y), 0, 1);

function corner_arc(cx, cy, radius, start_angle, end_angle, segments) =
    [for (i = [0:segments])
        [
            cx + radius*cos(start_angle
                            + (end_angle-start_angle)*i/segments),
            cy + radius*sin(start_angle
                            + (end_angle-start_angle)*i/segments)
        ]
    ];

// Base outline is the 141.45 mm narrow rounded rectangle.
function narrow_rounded_rectangle_points(width, depth, radius, segments) =
    concat(
        corner_arc( width/2-radius,  depth/2-radius,
                    radius,   0,  90, segments),
        corner_arc(-width/2+radius,  depth/2-radius,
                    radius,  90, 180, segments),
        corner_arc(-width/2+radius, -depth/2+radius,
                    radius, 180, 270, segments),
        corner_arc( width/2-radius, -depth/2+radius,
                    radius, 270, 360, segments)
    );

function depth_tapered_outline_points() =
    [for (p = narrow_rounded_rectangle_points(
            narrow_end_width_x,
            holder_depth_y,
            body_corner_radius,
            rounded_corner_segments_per_quadrant))
        [
            p[0] + side_sign(p[0])
                   * wedge_addition_each_side_x
                   * wide_fraction_at_y(p[1]),
            p[1]
        ]
    ];

module body_outline_2d() {
    polygon(points=depth_tapered_outline_points());
}

module slide_pocket_2d(length, width, add_notches=true) {
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
        slide_pocket_2d(universal_slide_length, universal_slide_width, true);
        circle(d=universal_dish_diameter);
    }
}

module universal_aperture_2d() {
    union() {
        square([
            universal_slide_length - 2*support_lip_width,
            universal_slide_width  - 2*support_lip_width
        ], center=true);

        circle(d=universal_dish_diameter - 2*support_lip_width);
    }
}

module universal_holder_without_clamp_tabs_depth_wedge() {
    difference() {
        // Constant 2D footprint extruded through Z: top and bottom always match.
        linear_extrude(height=holder_body_height_z)
            body_outline_2d();

        // Specimen recess remains unchanged and begins above the 1.00 mm lip.
        translate([sample_offset_x, sample_offset_y, support_lip_thickness_z])
            linear_extrude(
                height=holder_body_height_z-support_lip_thickness_z+epsilon
            ) universal_pocket_2d();

        // Optical opening remains unchanged.
        translate([sample_offset_x, sample_offset_y, -epsilon])
            linear_extrude(height=holder_body_height_z+2*epsilon)
                universal_aperture_2d();
    }
}

universal_holder_without_clamp_tabs_depth_wedge();
