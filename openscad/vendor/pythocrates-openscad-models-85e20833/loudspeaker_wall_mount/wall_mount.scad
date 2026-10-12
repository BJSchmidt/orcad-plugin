// Wall mount for satellite speaker.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 180;

ARM_DIAMETER = 30;
ARM_OFFSET = 0;
BASE_PLATE_THICKNESS = 5;
CONNECTOR_THICKNESS = 8;
EPSILON = 0.1;


module speaker_adapter() {
    ring_diameter = 23 + 0.75;
    ring_thickness = 3.0;

    torus(d=ring_diameter, d2=ring_thickness,$fn=FN);
    difference() {
        union() {
            intersection() {
                zcyl(d=ARM_DIAMETER, h=ARM_DIAMETER + ARM_OFFSET + BASE_PLATE_THICKNESS, align=V_UP, $fn=FN);
                zmove(ARM_DIAMETER / 2 + ARM_OFFSET + BASE_PLATE_THICKNESS) {
                    difference() {
                        union() {
                            sphere(d=ARM_DIAMETER, $fn=FN);
                            zcyl(d=ARM_DIAMETER, h=ARM_DIAMETER / 2 + ARM_OFFSET + BASE_PLATE_THICKNESS, align=V_DOWN, $fn=FN);
                        }
                        zmove(ARM_DIAMETER / 2) cuboid([CONNECTOR_THICKNESS + EPSILON * 2, ARM_DIAMETER, ARM_DIAMETER + ARM_OFFSET], align=V_DOWN);
                        xcyl(d=3.2, h=ARM_DIAMETER, $fn=FN);
                        xrot_copies(r=ARM_DIAMETER / 3, n=18) {
                            xcyl(d=2 + EPSILON * 2, h=ARM_DIAMETER, $fn=FN);
                        }
                    }
                }
            }

            cuboid([3, ring_diameter, 1.5], align=V_DOWN, $fn=FN);
            zcyl(d=10, h=4, align=V_DOWN, $fn=FN);
            zcyl(d=8, h=6.5, align=V_DOWN, $fn=FN);
        }
        zmove(BASE_PLATE_THICKNESS) zcyl(d=4.2, h=BASE_PLATE_THICKNESS + 6.5, align=V_DOWN, $fn=FN);
        zmove(BASE_PLATE_THICKNESS) zcyl(d=8, h=3, align=V_DOWN, $fn=FN);
    }
}


module wall_adapter() {
    difference() {
        intersection() {
            zmove(ARM_DIAMETER / 2 + ARM_OFFSET + BASE_PLATE_THICKNESS) {
                zcyl(d=ARM_DIAMETER, h=BASE_PLATE_THICKNESS, align=V_DOWN, $fn=FN);
                cuboid([CONNECTOR_THICKNESS - EPSILON * 2, ARM_DIAMETER, ARM_DIAMETER + ARM_OFFSET + BASE_PLATE_THICKNESS], align=V_DOWN);
            }
            union() {
                sphere(d=ARM_DIAMETER, $fn=FN);
                zcyl(d=ARM_DIAMETER, h=ARM_DIAMETER / 2 + ARM_OFFSET + BASE_PLATE_THICKNESS, align=V_UP, $fn=FN);
            }
        }
        xcyl(d=3.2, h=ARM_DIAMETER, $fn=FN);
        xrot_copies(r=ARM_DIAMETER / 3, n=20) {
            xcyl(d=2 + EPSILON * 2, h=ARM_DIAMETER, $fn=FN);
        }
    }
    zmove(ARM_DIAMETER / 2 + ARM_OFFSET + BASE_PLATE_THICKNESS) zcyl(d=ARM_DIAMETER + 2 * 2 - EPSILON * 2, h=2, align=V_UP, $fn=FN);
}


CUBE_SIZE = [60, 60, 60];
WALL_PLATE_SIZE = [CUBE_SIZE.x - 2 * 4, 2, sqrt(CUBE_SIZE.y ^ 2 + CUBE_SIZE.z ^ 2) - 2 * 4];

module wall_plate_base(extrusion=0) {
    connector_size = [4, 10, WALL_PLATE_SIZE.z - 2 * 4];

    cuboid(WALL_PLATE_SIZE + [2, 1, 2] * extrusion, align=V_FRONT, fillet=5, edges=EDGES_Y_ALL, $fn=FN);
    xspread(WALL_PLATE_SIZE.x - 2 * 12) zspread(WALL_PLATE_SIZE.z - 2 * 7) ycyl(d=9 + 2 * extrusion, h=4 + WALL_PLATE_SIZE.y + extrusion, align=V_FRONT, $fn=FN);
    difference() {
        xspread(WALL_PLATE_SIZE.x - connector_size.x) {
            cuboid(connector_size + [0, WALL_PLATE_SIZE.y, 0] + extrusion * [2, 1, 2], fillet=1, edges=EDGES_Z_FR, align=V_FRONT, $fn=FN);
        }
        zflip_copy() {
            zmove(connector_size.z / 2) xrot(45) cuboid([60, connector_size.y * sqrt(2) + WALL_PLATE_SIZE.y, connector_size.y * sqrt(2)], align=V_FRONT + V_UP);
        }
    }
}

module wall_plate_connecting_rods() {
    ymove(-(WALL_PLATE_SIZE.y + 4)) zspread(WALL_PLATE_SIZE.z - 2 * 13) xcyl(d=2 + 2 * EPSILON, h=CUBE_SIZE.x, $fn=FN);
}

module wall_mount() {
    difference() {
        xrot(45) difference() {
            xrot(-45) cuboid(CUBE_SIZE, fillet=5, edges=EDGES_Y_ALL + EDGES_Z_ALL + EDGE_BOT_FR, $fn=FN);
            cuboid(CUBE_SIZE * sqrt(2), align=V_BACK);
            wall_plate_base(extrusion=EPSILON);
            wall_plate_connecting_rods();
        }
        ymove(-4.25) zmove(-CUBE_SIZE.z / 2) {
            zcyl(d=ARM_DIAMETER + EPSILON * 2 * 2, h=CUBE_SIZE.z, align=V_UP, $fn=FN);
            zmove(BASE_PLATE_THICKNESS) zcyl(d=ARM_DIAMETER + 2 * 2 + EPSILON * 2 * 2, h=CUBE_SIZE.z, align=V_UP, $fn=FN);
        }
    }
}

module wall_plate() {
    difference() {
        wall_plate_base(extrusion=-EPSILON);
        wall_plate_connecting_rods();
        xspread(WALL_PLATE_SIZE.x - 2 * 12) zspread(WALL_PLATE_SIZE.z - 2 * 7) {
            ycyl(d=3.5 + 2 * EPSILON, h=4 + WALL_PLATE_SIZE.y + EPSILON, align=V_FRONT, $fn=FN);
            ymove(-2) ycyl(d1=8, d2=0, h=4, align=V_FRONT, $fn=FN);
        }
    }
}


//move([0, 2, ARM_DIAMETER / 2 + ARM_OFFSET])
    color("white") xrot(0) wall_mount();
/*
zmove(55 / 2) xrot(45) move([0, -0, 0])
    wall_plate();
*/

//wall_plate();

//xrot(0) wall_adapter();
//xrot(0) zmove(-(ARM_DIAMETER / 2 + ARM_OFFSET + BASE_PLATE_THICKNESS)) speaker_adapter();
