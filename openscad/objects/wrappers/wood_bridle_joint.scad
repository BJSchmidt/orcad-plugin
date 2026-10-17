// orcad wrapper for HopefulLlama/JointSCAD (MIT): the bridleJointA/B pair from
// upstream, printed side by side as a matching open mortise.
use <jointscad-44788806/dist/BridleJoint.scad>

joint_length = 60;
joint_width = 30;
joint_height = 20;

bridleJointA([joint_length, joint_width, joint_height]);
translate([joint_length + 10, 0, 0]) bridleJointB([joint_length, joint_width, joint_height]);
