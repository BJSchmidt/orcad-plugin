// orcad wrapper for cyber-murmel/cycoidal-gear (MIT): cycloidal_gear().
// Cycloidal disc: the lobed rotor of a cycloidal drive. The epitrochoid outline
// is offset by the pin radius, and the eccentric bearing bore and the ring of
// spoke pin holes are cut out of it.
use <cycoidal-gear-0295817c/cycloidal-gear.scad>

disc_ring_radius = 31.8;    // radius of the pin circle
disc_pins = 8;              // ring pins; the disc has one lobe fewer
disc_eccentricity = 2;
disc_pin_diameter = 5;
disc_bearing_od = 16;       // eccentric bearing bore
disc_spoke_diameter = 3;
disc_spoke_radius = 21;     // radius of the spoke pin circle
disc_spokes = 7;
disc_steps = 180;           // outline resolution
disc_thickness = 8;

linear_extrude(height = disc_thickness, convexity = 8)
    cycloidal_gear(r = disc_ring_radius, n_p = disc_pins, ecc = disc_eccentricity,
                   d_p = disc_pin_diameter, d_bo = disc_bearing_od, d_s = disc_spoke_diameter,
                   r_s = disc_spoke_radius, n_s = disc_spokes, steps = disc_steps);
