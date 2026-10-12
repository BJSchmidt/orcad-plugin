// orcad wrapper for hirthwork/dice-tower.scad (BSD-2-Clause): spiral dice tower.
// Upstream's staircase calls BOSL v1's extrude_2dpath_along_spiral(). BOSL v1's paths.scad
// is not vendored, so this wrapper restates that BSD-2-Clause function (copied from
// revarbat/BOSL, credited in NOTICE) on top of the vendored BOSL math and transform helpers.
include <bosl-4ce427a8/BOSL/constants.scad>
include <bosl-4ce427a8/BOSL/math.scad>
include <bosl-4ce427a8/BOSL/transforms.scad>

module extrude_2dpath_along_spiral(polyline, h, r, twist = 360, center = undef, orient = ORIENT_Z, align = V_CENTER) {
    pline_count = len(polyline);
    steps = ceil(segs(r) * (twist / 360));
    poly_points = [
        for (p = [0:steps]) let (
            a = twist * (p / steps),
            dx = r * cos(a),
            dy = r * sin(a),
            dz = h * (p / steps),
            pts = matrix4_apply(polyline, [matrix4_xrot(90), matrix4_zrot(a), matrix4_translate([dx, dy, dz])])
        ) for (pt = pts) pt
    ];
    poly_faces = concat(
        [[for (b = [0:pline_count - 1]) b]],
        [
            for (p = [0:steps - 1], b = [0:pline_count - 1], i = [0:1]) let (
                b2 = (b == pline_count - 1) ? 0 : b + 1,
                p0 = p * pline_count + b,
                p1 = p * pline_count + b2,
                p2 = (p + 1) * pline_count + b2,
                p3 = (p + 1) * pline_count + b,
                pt = (i == 0) ? [p0, p2, p1] : [p0, p3, p2]
            ) pt
        ],
        [[for (b = [pline_count - 1:-1:0]) b + steps * pline_count]]
    );
    orient_and_align([r, r, h], orient, align, center) {
        polyhedron(points = poly_points, faces = poly_faces, convexity = 10);
    }
}

tower_radius = 50;
wall_thickness = 4;
arc_height = 40;
// Upstream defaults details_multiplier to 6, which needs over 240 s to render here;
// the catalog default is 1 (about 45 000 triangles) and the detail is a parameter.
details_multiplier = 1;
include <hirthwork-dice-tower-c130e05a/tower.scad>
