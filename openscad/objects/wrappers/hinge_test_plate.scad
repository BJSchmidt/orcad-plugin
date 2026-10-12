// orcad wrapper for Pythocrates/openscad-models (CC0-1.0): tolerances/hinges.scad.
// Print-in-place hinge sample plate for dialling in the joint clearance.
use <pythocrates-openscad-models-85e20833/tolerances/hinges.scad>

hinge_length = 10;
hinge_thickness = 4;
hinge_tolerance = 0.2;

assembly([hinge_length, hinge_length, hinge_thickness], tolerance = hinge_tolerance);
