// orcad wrapper for nohkumado/ball_joint (CC0-1.0): balljoint_ball().
// The ball half of a universal ball joint: a rounded base and the sphere that
// snaps into the threaded seat. Upstream scales the whole profile from the ball
// diameter, so the base follows the ball.
use <ball-joint-85720f53/balljoint.scad>

balljoint_ball_dia = 17.5;
balljoint_ball_base_dia = 19;
balljoint_ball_base_height = 12;

balljoint_ball();
