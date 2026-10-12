// orcad wrapper for HopefulLlama/JointSCAD (MIT): the dovetailJointA/B pair
// from upstream, laid out as a matching slide pair.
use <jointscad-44788806/dist/DovetailJoint.scad>

joint_length = 100;
joint_width = 20;
joint_height = 10;
dovetail_count = 3;

dovetailJointA([joint_length, joint_width, joint_height], dovetail_count);
translate([joint_length + 10, 0, 0])
    dovetailJointB([joint_length, joint_width, joint_height], dovetail_count);
