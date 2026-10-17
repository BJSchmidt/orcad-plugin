// orcad wrapper for eclecticc/ParametricCase (BSD-2-Clause): pci_bracket.scad.
// A slot bracket with the standard PCIe screw hole and I/O cutout, as the case
// uses it to carry a GPU; upstream's own dims are restated so -D reaches them.
use <param-case-b5f1ee43/pci_bracket.scad>

pci_bracket_hole = 4.42;
pci_bracket_hole_offset = 5.08;
pci_bracket_width = 18.42;
pci_bracket_thickness = 0.86;

pci_bracket();
