// orcad wrapper for dnkorte/donkbot (MIT): plate_motors_sparkfun_stepper().
// Robot chassis plate for two SparkFun stepper motors: the motor sockets, the
// driver-board standoffs and the caster posts, all sized from upstream's shared
// DonKbot dimensions. The core_*.scad libraries it includes live in the pinned
// lib_robo_core tree and are found through OPENSCADPATH.
use <donkbot-0cae5346/openscad_donkbot/plate_motors_step_sparkfun.scad>

stepper_plate_pillar = 36;
stepper_plate_caster = 0;

plate_motors_sparkfun_stepper(pillar_height = stepper_plate_pillar, caster_post_height = stepper_plate_caster);
