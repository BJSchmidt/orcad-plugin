// orcad wrapper for AuroraRoboticsLab/AuroraSCAD (Unlicense): motor_3D().
// A solid model of a small electric motor, for clearance and bolt-pattern checks
// around a mount. Upstream keeps one parameter array per motor type, so the
// wrapper maps an option index onto the motors it ships and renders the one
// that was picked.
include <aurorascad-172751a1/AuroraSCAD/motor.scad>

motor_select = 0;       // 0 = NEMA 17 stepper, 1 = RS-550 brushed, 2 = 750 brushed
motor_extra_od = 0;     // extra radius around the body and boss, for a printed cradle
motor_with_shaft = true;
motor_with_boss = true;
motor_with_vents = true;

motors = [motortype_NEMA17, motortype_550, motortype_750];

motor_3D(motors[motor_select],
         extra_OD = motor_extra_od,
         with_shaft = motor_with_shaft,
         with_boss = motor_with_boss,
         with_vents = motor_with_vents);
