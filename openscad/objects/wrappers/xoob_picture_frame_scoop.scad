// orcad wrapper for xoob/parametric-picture-frame (MIT): reverse-ogee "scoop" frame.
//
// Upstream generates the moulding from top-level settings and renders whichever `render_mode`
// the file itself selects. orcad calls frame_assembled() from this wrapper instead, so a -D
// parameter reaches the geometry, and it pins upstream's "reverse_ogee" profile because the
// other styles need settings this catalog does not offer: "ogee" engraves a scroll band cut
// from heightmap PNGs that are not vendored, and a small ogee moulding leaves the lip too thin
// over the rabbet. `use` skips upstream's top-level assert() statements, but cuts_for() still
// asserts that a leg is longer than the printer bed, so a default frame here stays well above
// the bed size; painting_thickness is kept at 12 mm so the lip clears the rabbet cavity.
use <xoob-parametric-picture-frame-84e8314b/parametric-picture-frame.scad>

painting_width = 330;          // width of the painting the frame is built around (mm)
painting_height = 330;         // height of the painting the frame is built around (mm)
painting_thickness = 12;       // thickness of the painting or stretcher in the rabbet (mm)
lip_overlap = 10;              // how far the front lip overlaps the painting (mm)
fit_clearance = 4;             // slack per side around the painting (mm)
profile_style = "reverse_ogee"; // moulding cross-section: only reverse_ogee or ripple render here
frame_scale = 1.0;             // moulding scale, proportional to the painting size
ornament_enable = true;        // draw the relief ornament on the bands
ornament_depth = 2.6;          // relief height of the ornament (mm)
ornament_period_target = 80;   // target repeat period of the ornament (mm)
printer = "A1 Mini";           // bed preset upstream segments the parts for
bed_margin = 20;               // keep-out margin per bed side (mm)
export_group = "all";          // material group to export

frame_assembled();
