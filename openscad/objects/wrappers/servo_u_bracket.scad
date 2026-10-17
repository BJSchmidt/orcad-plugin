// orcad wrapper for SaxonRah/OpenSCAD_Robot_Parts (MIT): Robot_U_Bracket_ServoType.scad.
// U-bracket that carries a standard hobby servo between its cheeks and a bearing
// on the opposite axle. Upstream renders the bracket at top level, so the wrapper
// includes it and restates the plate and hole dimensions it exposes.
include <saxonrah-robot-parts-d9ff23cf/Robot_U_Bracket_ServoType.scad>

bracket_hub_length = 12.5;   // how far the servo axle sits above the base
bracket_height = 25;
bracket_width = 55.8;        // distance between the two cheeks
bracket_thickness = 2.15;
bearing_hole = 8.15;         // the bearing seat on the opposite cheek
mounting_hole = 3;           // the base mounting holes
