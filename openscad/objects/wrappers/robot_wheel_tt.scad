// orcad wrapper for dnkorte/lib_robo_core (MIT): part_wheel_tt().
// O-ring drive wheel for a yellow-gearbox TT motor: a thin web wheel that traps
// the o-ring in a torus groove, with the flattened-shaft socket and the screw
// hole that locks it onto the motor. Upstream names the tapping screw as a
// string, which -D cannot set, so the wrapper maps an option index onto it.
include <lib-robo-core-2e0cc474/core_config_dimensions.scad>
include <lib-robo-core-2e0cc474/core_robo_functions.scad>
include <lib-robo-core-2e0cc474/torus.scad>
include <lib-robo-core-2e0cc474/core_parts_wheels.scad>

wheel_oring_id = 32;      // o-ring inner diameter
wheel_oring_od = 38;      // o-ring outer diameter
wheel_thickness = 6;
wheel_stretch = 2;        // how much the groove stretches the o-ring
wheel_screw = 0;          // 0 = M2.5 self-tapping screw, 1 = M3

wheel_screws = ["M25", "M3"];

part_wheel_tt(wheel_oring_id, wheel_oring_od, thick = wheel_thickness,
              screw = wheel_screws[wheel_screw], stretch = wheel_stretch);
