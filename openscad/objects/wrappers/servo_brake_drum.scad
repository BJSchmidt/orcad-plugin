// orcad wrapper for AssaadMH/servo-brake-actuator (MIT): drum().
// Servo brake-cable drum: a V-sheave drum that captures the stock four-arm servo
// horn in a pocket underneath and pulls two cables over part of the servo
// rotation, one on each side. The cable centreline radius follows the stroke and
// sweep you ask for, so the drum stays the same size for the same pull.
use <servo-brake-actuator-a61c9b8b/design/servo_brake_drum.scad>

HORN_TIP = 40;             // tip-to-tip width of the servo horn
HORN_ARM_W = 7;            // width of one horn arm
HORN_T = 4;                // horn arm thickness
HORN_BOSS = 14;            // horn centre boss diameter
STROKE = 70;               // cable travel wanted
SWEEP = 180;               // servo rotation used for that travel
CABLE_D = 1.6;             // brake inner wire diameter
V_DEPTH = 2.2;             // sheave groove depth
POCKET_CLR = 0.4;          // clearance on the captured horn
SHOW_SLOTS = true;         // radial retaining slots on top

drum();
