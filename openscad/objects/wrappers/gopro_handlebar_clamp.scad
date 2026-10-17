// orcad wrapper for ridercz/GoProScad (MIT): gopro_mount_f() on a handlebar clamp.
// Upstream only ships the connector and its samples, so the C-shaped bar clamp
// around the quick-release mount is written here around the upstream call.
use <ridercz-gopro-98c0161e/GoPro.scad>

bar_diameter = 31.8;
bar_clearance = 0.3;
clamp_wall = 4;
clamp_width = 16;
opening_angle = 80;
mount_height = 8;
base_height = 3;
base_width = 20;

$fn = 64;

module bar_clamp() {
    difference() {
        cylinder(d = bar_diameter + 2 * clamp_wall, h = clamp_width, center = true);
        cylinder(d = bar_diameter + 2 * bar_clearance, h = clamp_width + 2, center = true);
        // Wedge that opens the clamp so it can be pushed over the bar.
        translate([0, 0, -clamp_width / 2 - 1])
            linear_extrude(clamp_width + 2)
                polygon([[0, 0],
                         [-bar_diameter * tan(opening_angle / 2), bar_diameter],
                         [bar_diameter * tan(opening_angle / 2), bar_diameter]]);
    }
}

union() {
    bar_clamp();
    translate([0, 0, clamp_width / 2])
        cylinder(d = base_width, h = mount_height);
    translate([0, 0, clamp_width / 2 + mount_height])
        gopro_mount_f(base_height = base_height, base_width = base_width, center = true);
}
