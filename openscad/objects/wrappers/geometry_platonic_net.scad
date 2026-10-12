// orcad wrapper for whosawhatsis/Geometry (CC-BY-4.0): a folding net for any of
// the five Platonic solids. Upstream assigns faces and edge several times while
// choosing the solid, so the catalog values are restated here; -D overrides win
// over those assignments.
include <whosawhatsis-geometry-0aaf3e49/Nets/platonic_net.scad>

faces = 20;
edge = 30;
printheight = 50;
hinge = 0.6;
