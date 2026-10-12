// orcad wrapper for HopefulLlama/JointSCAD (MIT): the tenon and mortise halves
// of upstream's mortise-and-tenon joint, printed side by side.
use <jointscad-44788806/dist/MortiseAndTenonJoint.scad>

joint_length = 60;
joint_width = 40;
joint_height = 20;
tenon_ratio = 0.4;

tenon([joint_length, joint_width, joint_height], [tenon_ratio, tenon_ratio, tenon_ratio]);
translate([joint_length + 10, 0, 0])
    mortise([joint_length, joint_width, joint_height], [tenon_ratio, tenon_ratio, tenon_ratio]);
