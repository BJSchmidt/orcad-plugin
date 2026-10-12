// orcad wrapper for eclecticc/ParametricCase (BSD-2-Clause): mini-itx.scad.
// cable_wrap_holder() is the loop the case glues inside its panels so a cable
// wrap can be tied down; it is sized from the case wall thickness.
use <param-case-b5f1ee43/mini-itx.scad>

wall = 2.5;
extra = 1.0;

cable_wrap_holder();
