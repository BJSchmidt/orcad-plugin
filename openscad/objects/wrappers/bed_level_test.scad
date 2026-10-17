// orcad wrapper for holgerlembke/OpenSCAD-Modelle (MIT): Bed_Levelling.scad.
// Nine small squares spread over the printable area; printing one set in each
// corner and the middle shows whether the bed is level and adhering evenly.
// Upstream places them at top level, so the wrapper includes it and restates
// the plate and square dimensions it exposes.
include <holgerlembke-openscad-modelle-b48f4ea0/Bed_Levelling.scad>

// Druckbereich in X
X_MAX_LENGTH = 230;
// Druckbereich in Y
Y_MAX_LENGTH = 230;
// Kantenlänge eines Quadrats
SIZE = 20;
// Abstand vom Rand
OFFSET = 25;
// Dicke der Quadrate
THICKNESS = 1.0;
