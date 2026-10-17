// orcad wrapper for szrudi/MatrixFlow (MIT): matrixflow_adapter.
// Straight adapter that steps one round duct diameter down to another.
use <matrixflow-2938da22/matrixflow.scad>

reducer_height = 20;
reducer_wall = 2.0;
top_diameter = 110;
bottom_diameter = 120;

matrixflow_adapter(
    transition_height = reducer_height,
    wall_thickness = reducer_wall,
    top_shape = "circle", top_width = top_diameter, top_depth = top_diameter,
    top_extension = 20, top_fit = "standard",
    bottom_shape = "circle", bottom_width = bottom_diameter, bottom_depth = bottom_diameter,
    bottom_extension = 20, bottom_fit = "standard",
    smoothness = 40, fn = 64
);
