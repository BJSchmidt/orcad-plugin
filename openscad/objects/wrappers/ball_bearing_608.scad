// orcad wrapper for cblomart/ball-bearing (MIT): ballbearing().
// Parametric deep-groove ball bearing: both races are turned from the inner and
// outer diameters, the groove between them is cut with a torus and the ring of
// balls is placed on the pitch circle.
use <ball-bearing-684fb2fb/ball-bearing.scad>

bearing_inner = 8;      // 608 bore
bearing_outer = 22;
bearing_thick = 7;      // race height, and the diameter of the balls
bearing_gap = 0.2;      // groove clearance

ballbearing(bearing_inner, bearing_outer, bearing_thick, gap = bearing_gap);
