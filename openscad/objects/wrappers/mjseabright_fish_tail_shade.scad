// orcad wrapper for mjseabright/lampshades (MIT): fish tail shade.
//
// Upstream's fish_tail.scad defines the shape as a module and then calls it with its own
// default arguments, so a -D value for the module's defaults never reaches the geometry.
// The wrapper restates the shape's parameters and calls the module itself.
use <mjseabright-lampshades-5c20d701/fish_tail/fish_tail.scad>

fish_tail_height = 100;         // total height of the shade (mm)
fish_tail_layer_height = 1.0;   // vertical distance between cross-sections (mm)
fish_tail_diameter = 90;        // diameter of the ring the scales ride on (mm)
fish_tail_divs = 24;            // how many scale pairs run around the shade
fish_tail_scale_diameter = 42;  // size of each scale polygon (mm)
fish_tail_swell = 18;           // how far the belly bulges past the ring (mm)

fish_tail(
    height = fish_tail_height,
    layer_height = fish_tail_layer_height,
    main_diameter = fish_tail_diameter,
    divs_per_circle = fish_tail_divs,
    circle_diameter = fish_tail_scale_diameter,
    swell = fish_tail_swell
);
