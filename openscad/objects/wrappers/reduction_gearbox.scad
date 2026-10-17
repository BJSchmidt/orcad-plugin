// orcad wrapper for AuroraRoboticsLab/AuroraSCAD (Unlicense): gearbox_draw_all().
// Two-stage reduction gearbox with a ring-gear output: a small motor pinion
// drives a lightened reduction gear, which drives the internal-toothed output
// ring. Upstream lays the stages out from their tooth counts and pitches, and
// builds the frame that carries every axle.
include <aurorascad-172751a1/AuroraSCAD/gearbox.scad>

gearbox_pitch_out = 1.75;     // output stage pitch, mm of diameter per tooth
gearbox_ring_teeth = -42;     // negative tooth count = internal ring gear
gearbox_pinion_out = 9;
gearbox_pitch_in = 0.8;       // motor input stage pitch
gearbox_gear_teeth = 58;
gearbox_pinion_in = 14;
gearbox_stage_angle = 90;     // how far the input stage is swung off the output axis
gearbox_axle_out = 8;
gearbox_axle_in = 3;
gearbox_height = 10;          // tooth height
gearbox_with_frame = true;

gearbox = gearbox_create(
    [geartype_create(gearbox_pitch_out, gearbox_height), geartype_create(gearbox_pitch_in, gearbox_height)],
    [[gearbox_ring_teeth, gearbox_pinion_out], [gearbox_gear_teeth, gearbox_pinion_in]],
    [0, gearbox_stage_angle],
    [gearbox_axle_out, gearbox_axle_in],
    [gearbox_axle_out + 1.5, gearbox_axle_in + 1.5],
    [0.1, 1, -1]);

gearbox_draw_all(gearbox, gearbox_with_frame);
