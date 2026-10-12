// orcad wrapper for CGrassin/rocketry (MIT): a Haack-series nose cone on a
// cylindrical shoulder. A c_factor of 0 gives the von Karman (LD-Haack) profile.
use <cg-rassin-rocketry-7b7783a3/3D_models/KeplerMK1_NoseCone.scad>

cone_diameter = 73;
cone_length = 100;
base_length = 8;
c_factor = 0;
resolution = 200;

cylinder(base_length, d = cone_diameter, $fn = resolution);
translate([0, 0, base_length])
    cone_haack(C = c_factor, R = cone_diameter / 2, L = cone_length - base_length, s = resolution);
