// orcad wrapper for MomsFriendlyRobotCompany/omni-wheel-hub (MIT): wheelhub().
// Hub that bolts a 60 mm omni wheel onto the servo horn side: a 28 mm disc with
// the lightening cut, the 21 mm bolt circle and the square socket. Upstream
// draws one fixed size, so the wrapper scales it, flips it for printing and can
// open the socket into a round bore.
use <omni-wheel-hub-3a5e25de/servo-hub.scad>

hub_scale = 1;
hub_bore = 0;            // 0 keeps upstream's square servo-horn socket
hub_flip = false;

scale([hub_scale, hub_scale, hub_scale]) {
    difference() {
        if (hub_flip) mirror([0, 0, 1]) wheelhub();
        else wheelhub();
        if (hub_bore > 0) cylinder(d = hub_bore, h = 200, center = true);
    }
}
