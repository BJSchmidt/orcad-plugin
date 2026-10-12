// orcad wrapper for szrudi/MatrixFlow (MIT): matrixflow_adapter.
// Funnel that opens a narrow duct throat out to a wide round mouth.
use <matrixflow-2938da22/matrixflow.scad>

funnel_height = 60;
funnel_wall = 2.0;
funnel_mouth = 120;
funnel_throat = 20;

matrixflow_adapter(
    transition_height = funnel_height,
    wall_thickness = funnel_wall,
    straighten_path = 0.5, smart_easing = true,
    top_shape = "circle", top_width = funnel_mouth, top_depth = funnel_mouth,
    top_extension = 10,
    bottom_shape = "circle", bottom_width = funnel_throat, bottom_depth = funnel_throat,
    bottom_extension = 40,
    smoothness = 40, fn = 64
);
