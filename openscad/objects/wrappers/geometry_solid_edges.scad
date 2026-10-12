// orcad wrapper for whosawhatsis/Geometry (CC-BY-4.0): one Platonic solid sized
// by its edge length. The upstream dodecahedron() is derived from the module
// variable phi, which `use` does not import, so phi is restated here.
use <whosawhatsis-geometry-0aaf3e49/Polygons+Polyhedrons/edge_platonic_solids.scad>

edge = 35;
solid = 1;
phi = (1 + sqrt(5)) / 2;

if (solid == 0) tetrahedron(edge, true);
else if (solid == 1) octahedron(edge, true);
else if (solid == 2) dodecahedron(edge, true);
else icosahedron(edge, true);
