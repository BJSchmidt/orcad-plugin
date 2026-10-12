// orcad wrapper for mmalecki/composable-organizer (MIT): compartment.scad.
// Upstream takes a [x, y, z] size vector, which a single -D value cannot set,
// so the wrapper builds the vector from three separate unit counts.
use <composable-organizer-f01bb2fb/compartment.scad>

compartment_x = 2;
compartment_y = 3;
compartment_z = 2;
compartment_hinge = true;

compartment([compartment_x, compartment_y, compartment_z], lid_hinge = compartment_hinge);
