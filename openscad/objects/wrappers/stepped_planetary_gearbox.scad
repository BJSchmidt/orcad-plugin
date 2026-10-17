// orcad wrapper for AuroraRoboticsLab/AuroraSCAD (Unlicense): stepped_planets().
// The planets of a two-stage stepped planetary geartrain printed as one piece:
// the lower set meshes the input ring, the upper set is a different tooth count
// on the same orbit radius and drives the output ring.
include <aurorascad-172751a1/AuroraSCAD/gear.scad>

step_planets = 3;
step_height = 8;          // height of one planet row
step_pitch = 1.5;
step_planet_teeth = 7;
step_sun_teeth = 12;
step_sun_step = 3;        // extra input-sun teeth per planet, which offsets the output
step_axle_hole = 6;
step_raise = 3;           // how far the lower planet row rises above its own height

gp_low = [geartype_create(step_pitch, step_height), step_sun_teeth, step_planet_teeth, step_planets];
gp_high = gearplane_stepped(gp_low, step_sun_step);

stepped_planets(gp_low, gp_high, raise_lower = step_raise, axle_hole = step_axle_hole);
