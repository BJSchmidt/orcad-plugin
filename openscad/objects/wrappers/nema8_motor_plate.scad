// orcad wrapper for dnkorte/donkbot (MIT): plate_motors_nema8_stepper().
// Robot chassis plate for two NEMA 8 stepper motors: the square motor sockets,
// the caster posts and the accessory pattern, all sized from upstream's shared
// DonKbot dimensions. The core_*.scad libraries it includes live in the pinned
// lib_robo_core tree and are found through OPENSCADPATH.
use <donkbot-0cae5346/openscad_donkbot/plate_motors_step_nema8.scad>

nema8_plate_pillar = 29;
nema8_plate_caster = 0;

plate_motors_nema8_stepper(pillar_height = nema8_plate_pillar, caster_post_height = nema8_plate_caster);
