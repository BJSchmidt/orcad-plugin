// orcad wrapper for mjseabright/lampshades (MIT): rotated star shade.
//
// Upstream's rotated_star.scad defines the shape as a module and then calls it with its own
// default arguments, so a -D value for the module's defaults never reaches the geometry.
// The wrapper restates the shape's parameters and calls the module itself.
use <mjseabright-lampshades-5c20d701/rotated_star/rotated_star.scad>

star_height = 100;        // total height of the shade (mm)
star_layer_height = 1.0;  // vertical distance between cross-sections (mm)
star_radius = 60;         // radius of the two stars before they twist (mm)

rotated_star(
    height = star_height,
    layer_height = star_layer_height,
    main_radius = star_radius
);
