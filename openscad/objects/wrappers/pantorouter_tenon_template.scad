// orcad wrapper for FozzTexx/pantorouter_tenon_template (CC0-1.0): upstream's
// tenon() template rebuilt around the wrapper's own layout so every catalog
// value reaches the module. Upstream's top-level layout is deliberately not
// executed (use, not include), which keeps -D overrides live.
use <pantorouter-tenon-eccd4577/Tenons.scad>

INCH_TO_MM = 25.4;

tenon_width = 25.4;
tenon_length = 50.8;
tenon_radius = 3.175;
inner_bit = 12.7;
inner_bearing = 10;
outer_bit = 12.7;
outer_bearing = 10;
template_taper = 12;
template_depth = 12;
base_depth = 3.5;
center_diameter = 6;
screw_diameter = 4;
screw_taper = 90;
inner_margin = 2;
center_mark_size = 1.5;
shrink_comp = 51.8 / 49.68;
rows = 2;
columns = 1;
row_gap = 25.4;
column_gap = 25.4;

on_center_spacing = [(tenon_width + column_gap) * 2, (tenon_length + row_gap) * 2];
total_center = [on_center_spacing[0] * (columns - 1), on_center_spacing[1] * (rows - 1)];

difference() {
    outer_width = (tenon_width + outer_bit) * 2 - outer_bearing;
    outer_length = (tenon_length + outer_bit) * 2 - outer_bearing;
    spacing = [(tenon_width + column_gap) * 2 - outer_width,
               (tenon_length + row_gap) * 2 - outer_length];
    base_size = [(outer_width + spacing[0]) * columns - spacing[0],
                 (outer_length + spacing[1]) * rows - spacing[1], base_depth];
    union() {
        translate([-total_center[0] / 2, -total_center[1] / 2, 0])
            for (row = [0 : rows - 1], column = [0 : columns - 1])
                translate([column * on_center_spacing[0], row * on_center_spacing[1], 0]) tenon();
        if (rows > 1 || columns > 1)
            translate([0, 0, -base_size[2] / 2])
                rounded_rect(base_size[0], base_size[1],
                             ((tenon_radius * 2 + outer_bit) * 2 - outer_bearing) / 2, base_size[2]);
    }
    cylinder(template_depth * 3, d = center_diameter, center = true);
    for (idx = [-rows : rows]) {
        if (idx) {
            z_pos = columns % 2 ? base_depth : 0;
            y_pos = idx * base_size[1] / (rows * 2 + 2);
            translate([0, y_pos, z_pos]) screw_hole(screw_diameter, screw_taper);
        }
    }
}
