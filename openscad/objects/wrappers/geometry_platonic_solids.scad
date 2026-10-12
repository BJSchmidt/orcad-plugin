// orcad wrapper for whosawhatsis/Geometry (CC-BY-4.0): the five Platonic solids
// laid out on one bed around a common radius.
use <whosawhatsis-geometry-0aaf3e49/Polygons+Polyhedrons/platonicSolids.scad>

size = 35;
spacing = 1.2;

rotate(72 * 1) translate([size * spacing, 0, 0]) tetrahedron(size);
rotate(72 * 2) translate([size * spacing, 0, 0]) cube(size, center = true);
rotate(72 * 3) translate([size * spacing, 0, 0]) octahedron(size);
rotate(72 * 4) translate([size * spacing, 0, 0]) dodecahedron(size);
rotate(72 * 5) translate([size * spacing, 0, 0]) icosahedron(size);
