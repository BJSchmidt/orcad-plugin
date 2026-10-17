// orcad wrapper for Pythocrates/openscad-models (CC0-1.0): lock_plate/lock_plate.iscad.
// Rectangular door lock plate with a recessed cavity and a keyway slot, built on
// upstream's full_plate() module.
use <pythocrates-openscad-models-85e20833/lock_plate/lock_plate.iscad>

plate_length = 150;
plate_height = 18;
plate_thickness = 6;
cavity_length = 48;
cavity_height = 15;
cavity_depth = 5;
keyway_height = 10;
offset = 16;

difference() {
    full_plate([plate_length, plate_height, plate_thickness],
               offset = offset,
               cavity = [cavity_length, cavity_height, cavity_depth],
               thickenings = [1, 1]);
    translate([offset, -keyway_height / 4, 1])
        cube([cavity_length, keyway_height, cavity_depth]);
}
