// orcad wrapper for adgaudio/OpenSCAD_connectors (MIT): the endcap() module
// that plugs the end of an aluminium extrusion.
use <openscad-connectors-643a09d7/endcap.scad>

cap_x = 20;
cap_y = 40;
cap_insert = 8;
cap_thickness = 2;
cap_bolt_hole = 5.1;

endcap(cap_x, cap_y, h = cap_insert, th = cap_thickness, bolt_hole = cap_bolt_hole);
