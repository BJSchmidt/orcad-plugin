// orcad wrapper for xoob/parametric-picture-frame (MIT): stepped, engraved frame.
//
// Same generator as xoob_picture_frame_scoop.scad, with upstream's stepped "ripple" moulding
// and its denser meander engraving. See that wrapper for why the wrapper calls frame_assembled()
// itself and why the ogee styles are not offered.
use <xoob-parametric-picture-frame-84e8314b/parametric-picture-frame.scad>

painting_width = 330;          // width of the painting the frame is built around (mm)
painting_height = 330;         // height of the painting the frame is built around (mm)
painting_thickness = 20;       // thickness of the painting or stretcher in the rabbet (mm)
lip_overlap = 10;              // how far the front lip overlaps the painting (mm)
fit_clearance = 4;             // slack per side around the painting (mm)
profile_style = "ripple";      // moulding cross-section: only ripple or reverse_ogee render here
frame_scale = 1.0;             // moulding scale, proportional to the painting size
ornament_enable = true;        // draw the engraved ornament on the bands
ornament_depth = 2.6;          // relief height of the ornament (mm)
ornament_period_target = 42;   // target repeat period of the ornament (mm)
printer = "A1 Mini";           // bed preset upstream segments the parts for
bed_margin = 20;               // keep-out margin per bed side (mm)
export_group = "all";          // material group to export

frame_assembled();
