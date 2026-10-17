// orcad wrapper for doofdoofsf/3DModels (MIT): fancy_joint/coaster.scad.
//
// Upstream's fancy coaster is drawn flat: left_half_with_joint() and right_half_with_joint()
// are 2D outlines with the dovetail-shaped arrow joint, so a straight render exports no solid
// at all. The wrapper extrudes both halves to a coaster thickness and lays them out side by
// side; upstream's own coaster_size drives both the shape and the spacing.
use <doofdoofsf-3dmodels-a5786829/fancy_joint/coaster.scad>

coaster_size = 120;      // diameter of the finished round coaster (mm)
coaster_thickness = 3;   // printed thickness of each half (mm)
coaster_gap = 10;        // clearance between the two halves on the bed (mm)

linear_extrude(height = coaster_thickness)
    left_half_with_joint();

translate([coaster_size + coaster_gap, 0, 0])
    linear_extrude(height = coaster_thickness)
        right_half_with_joint();
