// orcad wrapper for Pythocrates/openscad-models (CC0-1.0): curtain_rod_caps/curtain_rod_caps.scad.
// Push-on end cap that closes the open end of a curtain rod.
use <pythocrates-openscad-models-85e20833/curtain_rod_caps/curtain_rod_caps.scad>

cap_radial = 1.5;
cap_longitudinal = 1.5;
rod_diameter = 16.5;
cap_length = 15;

cap(radial_thickness = cap_radial, longitudinal_thickness = cap_longitudinal,
    inner_diameter = rod_diameter, inner_length = cap_length);
