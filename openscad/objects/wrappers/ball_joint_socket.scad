// orcad wrapper for nohkumado/ball_joint (CC0-1.0): balljoint_seat().
// The socket half of a universal ball joint: a threaded cup with the retaining
// lips and the split that lets it grip the ball. The thread is generated with
// the helix_extrude.scad module shipped beside the library.
use <ball-joint-85720f53/balljoint.scad>

balljoint_ball_dia = 17.5;
balljoint_seat_walls = 1.4;
balljoint_thread_tooth_height = 1.71;
balljoint_thread_tooth_width = 0.4;
balljoint_thread_tooth_base_width = 2.35;

balljoint_seat();
