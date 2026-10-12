// orcad wrapper for mikeydotio/opengrid-scad (CC-BY-4.0): the peg() module
// from the openGrid wall system, a shelf pin for the org grid.
use <opengrid-scad-894a731f/opengrid-peg.scad>

peg_body_diameter = 8;
peg_body_length = 25;
peg_cap_length = 4;
peg_cap_diameter = 12;

peg(body_length = peg_body_length, body_diameter = peg_body_diameter,
    cap_length = peg_cap_length, cap_diameter = peg_cap_diameter);
