// orcad wrapper for HopefulLlama/JointSCAD (MIT): the two shoulder halves of
// upstream's scarf joint, printed side by side as a splice jig.
use <jointscad-44788806/dist/ScarfJoint.scad>

joint_length = 80;
joint_width = 30;
joint_height = 20;

scarfJointA([joint_length, joint_width, joint_height]);
translate([joint_length + 10, 0, 0]) scarfJointB([joint_length, joint_width, joint_height]);
