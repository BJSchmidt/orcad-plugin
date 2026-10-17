// orcad wrapper for mjseabright/lampshades (MIT): golfball shade.
//
// Upstream's golfball.scad defines the shape as a module and then calls it with its own
// default arguments, so a -D value for the module's defaults never reaches the geometry.
// The wrapper restates the shape's parameters and calls the module itself, with a default
// size and a deliberately coarse cross-section spacing: every dimple is a subtraction, so a
// fine spacing makes the render crawl.
use <mjseabright-lampshades-5c20d701/golfball/golfball.scad>

golfball_height = 60;          // total height of the shade (mm)
golfball_layer_height = 2.0;   // vertical distance between cross-sections (mm)
golfball_diameter = 100;       // diameter at the waist of the shade (mm)
golfball_swell = 30;           // how far the belly bulges past the waist (mm)
golfball_dimple_spacing = 12;  // vertical distance between dimple rows (mm)
golfball_dimples = 24;         // dimples around each row

golfball(
    height = golfball_height,
    swell = golfball_swell,
    layer_height = golfball_layer_height,
    main_diameter = golfball_diameter,
    dimple_v_spacing = golfball_dimple_spacing,
    num_dimple_per_rot = golfball_dimples
);
