// orcad wrapper for nemon-/openscad-dice-models (CC0-1.0): even-sided antiprism die.
use <nemon-openscad-dice-models-be03f70f/dice2n.scad>
dice_size = 10;
dice_sides_per_ring = 5;
dice_2n(n = dice_sides_per_ring, w = dice_size);
