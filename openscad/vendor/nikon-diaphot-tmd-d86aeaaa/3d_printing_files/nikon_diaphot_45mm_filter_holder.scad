/*
  Nikon Diaphot 45 mm glass-filter holder
  8 mm thick, extended tapered handle, reduced handle recess
  -----------------------------------------------------------
  Units: millimetres

  Revision requested after successful printing of the original overhanging
  groove version:
    - retain the original horizontal, support-dependent glass groove
    - increase total Z thickness from 5.00 mm to 8.00 mm by adding 1.50 mm
      to each broad face; keep the glass groove centred in Z
    - extend the existing handle taper by 4.00 mm
    - retain the recessed handle, but inset the existing recess footprint by
      an additional 0.50 mm on every side

  The handle extension is measured along the originally measured left taper
  edge. The left edge therefore changes from 13.56 mm to 17.56 mm. Both side
  edges and the original tip-edge angle are continued, so the taper itself is
  unchanged; the resulting new tip width is calculated from those continued
  lines rather than being held at 7.00 mm.
*/

$fn = 240;

// ------------------------------ output mode -------------------------------
part = "holder";  // [holder,assembly_preview,fit_coupon]

// --------------------------- measured dimensions -------------------------
glass_diameter        = 45.00;
glass_thickness       = 1.28;
body_thickness        = 8.00;
inner_chord           = 42.70;
inner_rise            = 25.00;
ring_width_left       = 2.83;
ring_width_right      = 2.82;
ring_width            = (ring_width_left + ring_width_right) / 2;

handle_tip_width_original   = 7.00;
handle_base_width           = 11.45;
handle_left_length_original = 13.56;
handle_extension            = 4.00;

// -------------------------- printer-fit parameters ------------------------
// Preserved from the successfully printed original model.
slot_width            = 1.50;
radial_clearance      = 0.15;
slot_mouth_extra      = 0.18;
slot_mouth_depth      = 0.85;

// --------------------------- handle reconstruction ------------------------
handle_base_mid_angle = 112.5;
handle_overlap        = 0.65;
handle_left_angle     = 87.5;
handle_top_angle      = 17.0;

// Preserved recess depth from the prior recessed-handle STL.
handle_recess_depth        = 1.60;
handle_recess_border_base  = 1.15;
// Shrinks the already-defined recess itself, including its curved base edge.
handle_recess_extra_inset  = 0.50;

// ---------------------------- derived geometry ----------------------------
inner_radius = (inner_rise * inner_rise + pow(inner_chord / 2, 2)) /
               (2 * inner_rise);
centre_y = inner_rise - inner_radius;
outer_radius = inner_radius + ring_width;
calculated_outer_rise = centre_y + outer_radius;
groove_outer_radius = glass_diameter / 2 + radial_clearance;
slot_z0 = (body_thickness - slot_width) / 2;
slot_z1 = slot_z0 + slot_width;

base_half_angle = asin(handle_base_width / (2 * outer_radius));

function circle_point(r, a) = [r * cos(a), centre_y + r * sin(a)];
function vec(len, a) = [len * cos(a), len * sin(a)];
function add2(a, b) = [a[0] + b[0], a[1] + b[1]];
function sub2(a, b) = [a[0] - b[0], a[1] - b[1]];
function mul2(v, s) = [v[0] * s, v[1] * s];
function length2(v) = sqrt(v[0] * v[0] + v[1] * v[1]);
function unit2(v) = mul2(v, 1 / length2(v));
function cross2(a, b) = a[0] * b[1] - a[1] * b[0];

// Intersection of infinite 2D lines p + t*r and q + u*s.
function line_intersection(p, r, q, s) =
    add2(p, mul2(r, cross2(sub2(q, p), s) / cross2(r, s)));

base_left_on_arc = circle_point(outer_radius,
                                handle_base_mid_angle + base_half_angle);
base_right_on_arc = circle_point(outer_radius,
                                 handle_base_mid_angle - base_half_angle);
base_inward = vec(-handle_overlap, handle_base_mid_angle);
handle_bl = add2(base_left_on_arc, base_inward);
handle_br = add2(base_right_on_arc, base_inward);

// Original measured handle, retained as construction geometry.
handle_tl_original = add2(handle_bl,
                          vec(handle_left_length_original, handle_left_angle));
handle_tr_original = add2(handle_tl_original,
                          vec(handle_tip_width_original, handle_top_angle));

left_side_direction  = unit2(sub2(handle_tl_original, handle_bl));
right_side_direction = unit2(sub2(handle_tr_original, handle_br));
tip_edge_direction   = unit2(sub2(handle_tr_original, handle_tl_original));

// Continue the original taper. The new tip edge remains parallel to the old
// one, while both original side-edge lines remain unchanged.
handle_tl = add2(handle_tl_original,
                 mul2(left_side_direction, handle_extension));
handle_tr = line_intersection(handle_br,
                              right_side_direction,
                              handle_tl,
                              tip_edge_direction);

handle_left_length_final = length2(sub2(handle_tl, handle_bl));
handle_tip_width_final = length2(sub2(handle_tr, handle_tl));

assert(slot_width > glass_thickness,
       "slot_width must exceed measured glass_thickness");
assert(slot_width < body_thickness,
       "slot_width must be less than body_thickness");
assert(groove_outer_radius < outer_radius,
       "groove leaves no outside wall; reduce radial_clearance");
assert(handle_base_width < 2 * outer_radius,
       "handle base chord is too wide for the ring");
assert(abs(cross2(right_side_direction, tip_edge_direction)) > 0.001,
       "handle side and tip lines are nearly parallel");
assert(handle_tip_width_final > 0,
       "handle extension makes the continued taper close completely");
assert(handle_recess_depth > 0 && handle_recess_depth < body_thickness,
       "invalid handle recess depth");

// ------------------------------- 2D shapes --------------------------------
module upper_half_plane(extra_below = 0) {
    translate([-60, -extra_below]) square([120, 70 + extra_below]);
}

module ring_2d() {
    intersection() {
        difference() {
            translate([0, centre_y]) circle(r = outer_radius);
            translate([0, centre_y]) circle(r = inner_radius);
        }
        upper_half_plane(0.02);
    }
}

module handle_2d() {
    polygon(points = [handle_bl, handle_tl, handle_tr, handle_br]);
}

module body_outline_2d() {
    union() {
        ring_2d();
        handle_2d();
    }
}

module groove_band_2d() {
    intersection() {
        difference() {
            translate([0, centre_y]) circle(r = groove_outer_radius);
            // Extend slightly into the already-empty aperture for a clean cut.
            translate([0, centre_y]) circle(r = inner_radius - 0.35);
        }
        upper_half_plane(0.25);
    }
}

module slot_mouth_band_2d() {
    intersection() {
        groove_band_2d();
        translate([-60, -0.15]) square([120, slot_mouth_depth + 0.15]);
    }
}

// Exact prior recess footprint before the requested additional 0.50 mm inset.
module handle_recess_original_2d() {
    difference() {
        offset(delta = -handle_recess_border_base) handle_2d();
        translate([0, centre_y]) circle(r = outer_radius - 0.35);
    }
}

// Morphologically inset the completed prior recess shape so every boundary,
// including the curved boundary next to the ring, moves inward by 0.50 mm.
module handle_recess_2d() {
    offset(delta = -handle_recess_extra_inset)
        handle_recess_original_2d();
}

// ------------------------------- 3D parts ---------------------------------
module holder() {
    difference() {
        linear_extrude(height = body_thickness, convexity = 10)
            body_outline_2d();

        // Original centred horizontal groove. Supports are expected if needed
        // by the selected material, layer height, and slicer.
        translate([0, 0, slot_z0])
            linear_extrude(height = slot_width, convexity = 10)
                groove_band_2d();

        // Small vertical lead-in at both open ends.
        if (slot_mouth_extra > 0)
            translate([0, 0, slot_z0 - slot_mouth_extra])
                linear_extrude(height = slot_width + 2 * slot_mouth_extra,
                               convexity = 10)
                    slot_mouth_band_2d();

        // One-sided recessed handle, as in the prior recessed version.
        translate([0, 0, body_thickness - handle_recess_depth])
            linear_extrude(height = handle_recess_depth + 0.02,
                           convexity = 10)
                handle_recess_2d();
    }
}

module glass_preview() {
    color([0.65, 0.85, 1.0, 0.35])
        translate([0, centre_y, (body_thickness - glass_thickness) / 2])
            cylinder(d = glass_diameter, h = glass_thickness);
}

module fit_coupon() {
    coupon_length = 18;
    coupon_depth = 6;
    difference() {
        cube([coupon_length, coupon_depth, body_thickness]);
        translate([-0.01,
                   coupon_depth - (groove_outer_radius - inner_radius),
                   slot_z0])
            cube([coupon_length + 0.02,
                  groove_outer_radius - inner_radius + 0.02,
                  slot_width]);
    }
}

// ------------------------------- diagnostics ------------------------------
echo(inner_radius = inner_radius);
echo(centre_y_above_chord = centre_y);
echo(outer_radius = outer_radius);
echo(calculated_outer_rise = calculated_outer_rise);
echo(groove_depth = groove_outer_radius - inner_radius);
echo(body_thickness = body_thickness);
echo(slot_z0 = slot_z0, slot_z1 = slot_z1);
echo(handle_left_length_final = handle_left_length_final);
echo(handle_tip_width_final = handle_tip_width_final);
echo(handle_bl = handle_bl, handle_tl = handle_tl,
     handle_tr = handle_tr, handle_br = handle_br);

if (part == "holder") {
    holder();
} else if (part == "assembly_preview") {
    color("black") holder();
    glass_preview();
} else if (part == "fit_coupon") {
    fit_coupon();
} else {
    assert(false, str("Unknown part mode: ", part));
}
