// orcad wrapper for dnkorte/donkbot (MIT): plate_motors_TT().
// Robot chassis plate for two TT gearmotors: the motor sockets, the caster
// mounts, the line-sensor slot and the accessory bolt pattern, all sized from
// upstream's shared DonKbot dimensions. The core_*.scad libraries it includes
// live in the pinned lib_robo_core tree and are found through OPENSCADPATH.
use <donkbot-0cae5346/openscad_donkbot/plate_motors_tt.scad>

tt_plate_pillar = 35;
tt_plate_caster = 2;

plate_motors_TT(pillar_height = tt_plate_pillar, caster_post_height = tt_plate_caster);
