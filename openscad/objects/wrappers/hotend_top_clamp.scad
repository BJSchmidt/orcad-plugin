// orcad wrapper for gchristopher/3dprinting (Apache-2.0): rostock-effector/dual_tool_clamp.scad.
// top_clamp() is the top clamp that traps the two hot ends in the effector
// platform. Upstream renders it at top level, so the wrapper includes it and
// restates the clamp and hot-end dimensions.
include <gchristopher-3dprinting-8fdb722c/rostock-effector/dual_tool_clamp.scad>

// Außenradius der Klemme
top_clamp_outer_r = 12;
// Innenradius der Klemme
top_clamp_inner_r = 6;
// Abstand der Klemmschrauben
top_clamp_screw_offset = 23;
// Höhe des Hotends
hotend_height = 27.3;
