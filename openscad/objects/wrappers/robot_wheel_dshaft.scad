// orcad wrapper for dnkorte/lib_robo_core (MIT): part_wheel_dshaft().
// O-ring drive wheel for a motor with a D-flat shaft: a thin web wheel with the
// o-ring groove, the split hub that clamps the flat shaft and the centre screw
// hole. Upstream sets the shaft diameter, so the hub follows it.
include <lib-robo-core-2e0cc474/core_config_dimensions.scad>
include <lib-robo-core-2e0cc474/core_robo_functions.scad>
include <lib-robo-core-2e0cc474/torus.scad>
include <lib-robo-core-2e0cc474/core_parts_wheels.scad>

wheel_oring_id = 32;
wheel_oring_od = 38;
wheel_thickness = 6;
wheel_stretch = 2;
wheel_shaft = 3;          // D-shaft diameter the hub clamps

part_wheel_dshaft(wheel_oring_id, wheel_oring_od, thick = wheel_thickness,
                  dshaft_dia = wheel_shaft, stretch = wheel_stretch);
