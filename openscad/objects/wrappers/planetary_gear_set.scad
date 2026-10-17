// orcad wrapper for AuroraRoboticsLab/AuroraSCAD (Unlicense): gearplane_2D().
// Print-in-place planetary gear set: a sun gear, its planets and the surrounding
// ring gear drawn as one 2D gear plane and extruded to the gear height. The 2D
// plane is built here from upstream's own gearplane_* accessors so the rim width
// is a catalog parameter as well.
include <aurorascad-172751a1/AuroraSCAD/gear.scad>

planet_pitch = 1.5;         // mm of pitch diameter per tooth
planet_sun_teeth = 12;
planet_planet_teeth = 9;    // ring teeth are sun + 2 planets
planet_count = 3;
planet_rim = 4;             // material outside the ring gear
planet_height = 8;          // extrusion height

planetary = [geartype_create(planet_pitch, planet_height), planet_sun_teeth, planet_planet_teeth, planet_count];

linear_extrude(height = planet_height, convexity = 8) {
    gearplane_sun(planetary)
        gear_2D(gearplane_Sgear(planetary));
    gearplane_planets(planetary)
        gear_2D(gearplane_Pgear(planetary));
    gearplane_ring_2D(planetary, rim_thick = planet_rim);
}
