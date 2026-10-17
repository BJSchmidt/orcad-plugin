// orcad wrapper for mjseabright/lampshades (MIT): pineapple shade.
//
// Upstream's pineapple.scad defines the shape as a module and then calls it with its own
// default arguments, so a -D value for the module's defaults never reaches the geometry.
// The wrapper restates the shape's parameters and calls the module itself, which keeps the
// shade printable in vase mode and lets the catalog choose a desk-sized default.
use <mjseabright-lampshades-5c20d701/pineapple/pineapple.scad>

pineapple_height = 100;        // total height of the shade (mm)
pineapple_layer_height = 1.0;  // vertical distance between cross-sections (mm)
pineapple_diameter = 120;      // diameter of the shade before the petals bulge (mm)
pineapple_divs = 36;           // how many petal columns run around the shade

pineapple(
    height = pineapple_height,
    layer_height = pineapple_layer_height,
    main_diameter = pineapple_diameter,
    num_angle_divs = pineapple_divs
);
