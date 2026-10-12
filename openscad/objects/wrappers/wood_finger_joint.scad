// orcad wrapper for HopefulLlama/JointSCAD (MIT): the fingerJointA/B pair
// printed side by side as a router-table setup block.
use <jointscad-44788806/dist/FingerJoint.scad>

joint_length = 100;
joint_width = 20;
joint_height = 10;
finger_count = 5;

fingerJointA([joint_length, joint_width, joint_height], finger_count);
translate([joint_length + 10, 0, 0])
    fingerJointB([joint_length, joint_width, joint_height], finger_count);
