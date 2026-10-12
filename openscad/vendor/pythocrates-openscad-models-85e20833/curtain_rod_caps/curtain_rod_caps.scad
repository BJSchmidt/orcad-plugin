// This is a cap for some simple curtain rods.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;


module cap(radial_thickness=1.5, longitudinal_thickness=1.5, inner_diameter=15.5, inner_length=15) {
    difference() {
        cyl(d=inner_diameter + 2 * radial_thickness, h=inner_length + longitudinal_thickness, align=V_UP, fillet2=1,  $fn=FN);
        cyl(d=inner_diameter, h=inner_length, align=V_UP, $fn=FN);
    }
}


cap(radial_thickness=1.5, longitudinal_thickness=1.5, inner_diameter=16.5, inner_length=15);
