// orcad wrapper for AuroraRoboticsLab/AuroraSCAD (Unlicense): barbie_gearbox().
// Coupling block for the cross-shaped output boss of a Peg Perego / Power Wheels
// ride-on gearbox, with the two 7/8 inch axle-bearing seats behind it. Upstream
// only provides the negative shape, so the wrapper cuts it out of a round hub.
include <aurorascad-172751a1/AuroraSCAD/perego_gearbox.scad>

coupler_height = 30;        // how deep the gearbox horn is socketed
coupler_diameter = 60;
coupler_thickness = 34;     // must cover coupler_height
coupler_clearance = 0.3;    // fit around the horn and the bearings

difference() {
    translate([0, 0, -coupler_thickness])
        cylinder(d = coupler_diameter, h = coupler_thickness);
    barbie_gearbox(coupler_height, coupler_clearance);
}
