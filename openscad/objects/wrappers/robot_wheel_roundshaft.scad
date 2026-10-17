// orcad wrapper for dnkorte/lib_robo_core (MIT): part_wheel_roundshaft().
// O-ring drive wheel for a plain round shaft: the same thin web wheel and
// o-ring groove, with a plain hub bore and the split that lets it grip the
// shaft. Upstream sets the shaft diameter, so the bore follows it.
include <lib-robo-core-2e0cc474/core_config_dimensions.scad>
include <lib-robo-core-2e0cc474/core_robo_functions.scad>
include <lib-robo-core-2e0cc474/torus.scad>
include <lib-robo-core-2e0cc474/core_parts_wheels.scad>

wheel_oring_id = 32;
wheel_oring_od = 38;
wheel_thickness = 6;
wheel_stretch = 2;
wheel_shaft = 3;          // round shaft diameter the hub grips

part_wheel_roundshaft(wheel_oring_id, wheel_oring_od, thick = wheel_thickness,
                      shaft_dia = wheel_shaft, stretch = wheel_stretch);
