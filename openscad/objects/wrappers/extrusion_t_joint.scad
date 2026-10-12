// orcad wrapper for adgaudio/OpenSCAD_connectors (MIT): the tjoint() module
// that pulls two aluminium extrusions together at an angle.
use <openscad-connectors-643a09d7/tjoint.scad>

joint_holes_a = 4;
joint_holes_b = 3;
joint_angle = 90;

tjoint([joint_holes_a, 0], [joint_holes_b, 0], angle = joint_angle);
