// orcad wrapper for gchristopher/3dprinting (Apache-2.0): rostock-effector/dual_tool_holder.scad.
// Effector platform with a wider centre opening that holds two E3D V6 hot ends
// and the upper fan-shroud section. Upstream renders tool_platform() at top
// level, so the wrapper includes it and restates the hot-end dimensions.
include <gchristopher-3dprinting-8fdb722c/rostock-effector/dual_tool_holder.scad>

// Höhe des Hotends
hotend_height = 27.3;
// Abstand der Hotends von der Mitte
offset = 13;
// Drehung des Lüfterschlitzes
fan_rot = 170;
