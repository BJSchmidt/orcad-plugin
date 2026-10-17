// orcad wrapper for szrudi/MatrixFlow (MIT): matrixflow_adapter.
// S-bend adapter that shifts a round duct sideways between two diameters.
use <matrixflow-2938da22/matrixflow.scad>

adapter_height = 100;
adapter_wall = 2.0;
duct_diameter = 120;
spigot_diameter = 30;
offset_x = 60;
offset_y = 60;

matrixflow_adapter(
    transition_height = adapter_height,
    wall_thickness = adapter_wall,
    straighten_path = 0.4,
    top_shape = "circle", top_width = duct_diameter, top_depth = duct_diameter,
    top_extension = 10,
    bottom_shape = "circle", bottom_width = spigot_diameter, bottom_depth = spigot_diameter,
    bottom_extension = 20,
    offset_x = offset_x, offset_y = offset_y,
    smoothness = 40, fn = 64
);
