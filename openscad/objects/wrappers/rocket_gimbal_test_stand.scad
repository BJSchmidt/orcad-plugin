// orcad wrapper for CGrassin/rocketry (MIT): the gimbal test stand that holds a
// rocket motor mount for thrust-vector tests.
use <cg-rassin-rocketry-7b7783a3/3D_models/KeplerMK1_GimbalTestStand.scad>

rocket_diameter = 70;
stand_height = 55;
base_screw_holes = true;

rocket_test_stand(rocket_diameter, stand_height, base_screw_holes);
