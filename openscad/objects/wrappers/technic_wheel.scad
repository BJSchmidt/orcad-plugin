// orcad wrapper for cfinke/Technic.scad (MIT): Technic wheel.
include <cfinke-technic-scad-41f17a46/Technic.scad>
wheel_diameter = 9.9;
wheel_width = 14;
wheel_pin_hole = false;
wheel_spokes = 6;
wheel_center_groove = true;
wheel_hole_type = wheel_pin_hole ? "pin" : "axle";
technic_wheel(diameter = wheel_diameter, width = wheel_width, center_groove = wheel_center_groove,
              hole_type = wheel_hole_type, spoke_count = wheel_spokes);
