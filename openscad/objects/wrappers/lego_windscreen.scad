// orcad wrapper for qubolino/brick_lib (CC0-1.0): curved windscreen.
include <qubolino-brick-lib-95a3c865/windscreen.scad>
windscreen_length = 4;
windscreen_height_plates = 4;
windscreen_height = windscreen_height_plates / 3;
windscreen_beam_width = 6;
windscreen_beam_thickness = 2;
windscreen(windscreen_beam_thickness, windscreen_beam_width, windscreen_height, windscreen_length);
