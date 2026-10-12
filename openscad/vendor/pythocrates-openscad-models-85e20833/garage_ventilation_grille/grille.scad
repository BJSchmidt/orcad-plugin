// This is a replacement for a garage ventilation grille.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

PLATE_DIAMETER = 125;
PLATE_THICKNESS = 2.5;

TUBE_OUTER_DIAMETER = 95;
TUBE_THICKNESS = 2;
TUBE_INNER_DIAMETER = TUBE_OUTER_DIAMETER - 2 * TUBE_THICKNESS;
TUBE_LENGTH = 25;

FLAP_LENGTH = 25;
FLAP_THICKNESS = 2;
FLAP_WIDTH = 15;
FLAP_PRESSING_THICKNESS = 5;

GRILLE_THICKNESS = 1.5;


module garage_ventillation_grille() {
    difference() {
        zcyl(d=PLATE_DIAMETER, h=PLATE_THICKNESS, align=V_TOP, $fn=FN);
        zcyl(d=TUBE_INNER_DIAMETER, h=PLATE_THICKNESS, align=V_TOP, $fn=FN);
    }
    difference() {
        zcyl(d=TUBE_OUTER_DIAMETER, h=TUBE_LENGTH, align=V_TOP, $fn=FN);
        zcyl(d=TUBE_INNER_DIAMETER, h=TUBE_LENGTH, align=V_TOP, $fn=FN);
    }
    zrot_copies(n=6, r=TUBE_INNER_DIAMETER / 2 - 0.5, sa=90) zmove(TUBE_LENGTH) garage_ventillation_flap();
    _grille();
}

module garage_ventillation_flap() {
    cuboid([FLAP_WIDTH, FLAP_THICKNESS, FLAP_LENGTH - FLAP_WIDTH / 2], align=V_TOP + V_BACK);
    zmove(FLAP_LENGTH - FLAP_WIDTH / 2) {
        intersection() {
            ycyl(d=FLAP_WIDTH, h=FLAP_THICKNESS + FLAP_PRESSING_THICKNESS, align=V_BACK, $fn=FN);
            ymove(-1.1) sphere(d=16.2, $fn=FN);
        }
    }
}

module _grille() {
    intersection() {
        zcyl(d=TUBE_OUTER_DIAMETER, h=TUBE_LENGTH, align=V_TOP, $fn=FN);
        union() {
            xspread(spacing=2, l=TUBE_OUTER_DIAMETER) cuboid([0.5, TUBE_OUTER_DIAMETER, 1], align=V_TOP);
            zrot_copies(70 * [-1, 1]) xspread(spacing=12, l=TUBE_OUTER_DIAMETER) cuboid([2, TUBE_OUTER_DIAMETER, 3], align=V_TOP);
        }
    }
}


garage_ventillation_grille();
