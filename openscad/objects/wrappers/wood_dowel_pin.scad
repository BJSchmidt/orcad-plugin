// orcad wrapper for HopefulLlama/JointSCAD (MIT): the dowel() primitive from
// the joint library, printed as a fluted dowel pin.
use <jointscad-44788806/dist/DowelJoint.scad>

dowel_sides = 12;
dowel_radius = 5;
dowel_length = 40;

dowel(dowel_sides, dowel_radius, dowel_length);
