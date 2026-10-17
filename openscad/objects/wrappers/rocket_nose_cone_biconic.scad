// orcad wrapper for CGrassin/rocketry (MIT): a biconic nose cone, a main cone
// tipped with a narrower cone.
use <cg-rassin-rocketry-7b7783a3/3D_models/KeplerMK1_NoseCone.scad>

cone_diameter = 73;
nose_diameter = 30;
length_upper = 20;
length_lower = 60;
resolution = 200;

cone_biconic(R = cone_diameter / 2, R_nose = nose_diameter / 2,
             L1 = length_upper, L2 = length_lower, s = resolution);
