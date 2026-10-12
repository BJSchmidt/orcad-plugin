// orcad wrapper for szrudi/MatrixFlow (MIT): matrixflow_adapter.
// Round-to-rectangle adapter for a bathroom extractor vent.
use <matrixflow-2938da22/matrixflow.scad>

duct_height = 160;
duct_wall = 3.0;
pipe_diameter = 100;
vent_width = 90;
vent_depth = 80;
vent_radius = 10;

matrixflow_adapter(
    transition_height = duct_height,
    wall_thickness = duct_wall,
    straighten_path = 0.5, smart_easing = true,
    top_shape = "rectangle", top_width = vent_width, top_depth = vent_depth,
    top_corner_radius = vent_radius, top_extension = 30,
    bottom_shape = "circle", bottom_width = pipe_diameter, bottom_depth = pipe_diameter,
    bottom_extension = 30, bottom_fit = "slip_over",
    offset_x = 20, offset_y = 60, angle_y = 30, angle_x = 10,
    smoothness = 30, fn = 64
);
