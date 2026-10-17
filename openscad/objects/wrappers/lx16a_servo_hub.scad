// orcad wrapper for MomsFriendlyRobotCompany/omni-wheel-hub (MIT): wheelgroup().
// Hub that adapts an LX-16A serial-bus servo to a wheel: the servo face plate
// with the 17 mm and 14 mm hole pairs, a spacer boss and the output stem. The
// omni wheel and its cap come from the same assembly, so they can be switched
// on when the whole unit is wanted. The STL-imported servo body stays off
// because upstream's own copy of it is not vendored.
use <omni-wheel-hub-3a5e25de/servo-hub.scad>

hub_scale = 1;
hub_with_wheel = true;
hub_with_cap = false;

scale([hub_scale, hub_scale, hub_scale])
    wheelgroup(s = false, w = hub_with_wheel, h = true, c = hub_with_cap);
