// orcad wrapper for aaron-siegel/puzzlecad (MIT): burr puzzle stick.
burr_stick = 975;
burr_scale = 11.15;
burr_inset = 0.07;
include <aaron-siegel-puzzlecad-2ba064c5/puzzlecad.scad>
$burr_scale = burr_scale;
$burr_inset = burr_inset;
burr_piece(burr_stick);
