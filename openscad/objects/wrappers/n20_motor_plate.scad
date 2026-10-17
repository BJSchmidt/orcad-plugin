// orcad wrapper for dnkorte/donkbot (MIT): plate_motors_n20_enc_tofp_qtpy().
// Robot chassis plate for N20 gearmotors with encoders and a time-of-flight
// sensor: motor sockets, encoder pockets, the sensor tower and the board
// mounts, all sized from upstream's shared DonKbot dimensions. The core_*.scad
// libraries it includes live in the pinned lib_robo_core tree.
use <donkbot-0cae5346/openscad_donkbot/plate_motors_n20.scad>

n20_plate_pillar = 30;
n20_plate_caster = 2;

plate_motors_n20_enc_tofp_qtpy(pillar_height = n20_plate_pillar, caster_post_height = n20_plate_caster);
