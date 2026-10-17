// Testing hinge designs.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 60;


module hinged_plate(size, tolerance) {
    difference() {
        cuboid(size, align=V_RIGHT);
    }
}

module hinge_cylinder(r, h, tolerance=0) {
    ycyl(r=r + tolerance, h=h + 2 * tolerance, $fn=FN);
}

module hinge(r, h, length, thickness, width, tolerance=0) {
    ycyl(r=thickness / 2, h=width + tolerance, $fn=FN);
    ycyl(r=thickness / 2 + tolerance * 2, h=width + tolerance, $fn=FN);
    hinge_cylinder(r=r, h=h, tolerance=tolerance);

    xmove(length) {
        hinge_cylinder(r=r, h=h, tolerance=tolerance);
        ycyl(r=thickness / 2, h=width + tolerance, $fn=FN);
    }

    cuboid([length, width + tolerance, thickness], align=V_RIGHT);
    cuboid([length, width + tolerance, thickness + tolerance], align=V_RIGHT);
}

module assembly(size, tolerance) {
    cutout = [6, 4, size.z];
    hinge_length = 4;
    hinge_radius = size.z / 2 * 0.5;

    //zrot_copies(n=2, r=hinge_length / 2 - size.z / 2)
    zrot_copies(n=2, r=hinge_length / 2 - 1.5)
        difference() {
            hinged_plate(size, tolerance=0.1);
            //xmove(size.z / 2)
            xmove(1.5)
                yrot_copies([90, 180, 270])
                    hinge(r=hinge_radius, h=cutout.y + 2, tolerance=tolerance, thickness=size.z, width=cutout.y, length=hinge_length);
        }

    xmove(-hinge_length / 2)
        hinge(r=hinge_radius, h=cutout.y + 2, tolerance=-tolerance, thickness=size.z, width=cutout.y, length=hinge_length);
}


assembly(size=[10, 10, 4], tolerance=0.2);
