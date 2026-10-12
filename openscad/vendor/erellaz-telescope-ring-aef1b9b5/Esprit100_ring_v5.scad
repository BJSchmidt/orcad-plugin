// Esprit 100 Ring
// 03/04/2023

scale=25.4;    // Inch to mm
tol=1;

//Main disk
hh=25;
sun_screen_diam=146; //External diamater of lens cell in mm
width=15;
outside_ring_diam=sun_screen_diam+width*2;
dove_tail=100;

//Resolution for STL export only. That is for display in Openscad and 3D printing only. 
//Please do comment this before going to Freecad, or you will end up with inefficient facets.
// and will not play well with export to .step files
$fn=350;
//___________________________________________________________________________________________
//___________________________________________________________________________________________
module main_body(){
difference(){
    union(){
    cylinder(h=hh, d=outside_ring_diam, center=true);
    translate([-90,-50,-hh/2])cube([18,100,hh]);
    }
    cylinder(h=hh+10, d=sun_screen_diam, center=true);
    translate([0,-100,-100])cube([200,200,200]);
    translate([-200-1*(sun_screen_diam/2+8),-100,-100])cube([200,200,200]);
}
}

module ear(w){
    //translate([0,(sun_screen_diam+width)/2,-hh/4])cylinder(h=hh/2, d=w, center=true);
    translate([0,-1*(sun_screen_diam+width)/2,-hh/4])cylinder(h=hh/2, d=w, center=true);
}

module vertical_hole(){
//translate([-((sun_screen_diam+width)/2),0,0])rotate([0,90,0])cylinder(h=16, d=8, center=true);
translate([-((sun_screen_diam+width)/2),25,0])rotate([0,90,0])cylinder(h=20, d=8, center=true);
translate([-((sun_screen_diam+width)/2),40,0])rotate([0,90,0])cylinder(h=20, d=8, center=true);
translate([-((sun_screen_diam+width)/2),-25,0])rotate([0,90,0])cylinder(h=20, d=8, center=true);
translate([-((sun_screen_diam+width)/2),-40,0])rotate([0,90,0])cylinder(h=20, d=8, center=true);
}

module axial_hole(){
    translate([0,-((sun_screen_diam+width)/2),0])cylinder(h=50, d=6.4, center=true);
    //translate([0,((sun_screen_diam+width)/2),0])cylinder(h=50, d=3.5, center=true);
}

module make_tab(){
difference(){
translate([-6,sun_screen_diam/2,-hh/2])cube([6,2*width,hh]);
translate([0,1.4*width+sun_screen_diam/2,0])rotate([0,90,0]) cylinder(h=40, d=7, center=true);
}}

module allow_rotation(){
    translate([-0.5,-1*(sun_screen_diam/2+width),hh/2])cube([width,width,hh],center=true);
}

//___________________________________________________________________________________________
//___________________________________________________________________________________________
// main body
if(1){
    difference(){
    difference(){
        difference(){
        union(){
        main_body(); 
        ear(width);  
        make_tab();
            }
        translate([0,0,hh/2])ear(width+1);
        }
    vertical_hole();
    axial_hole();
    }
    translate([-1,sun_screen_diam/2-5,-hh/2])cube([1,2*width+45,hh+15]);
    allow_rotation();
}
}

if(0){
translate([-200,-100,-100])cube([200,200,200]);     
}

if(0){
//vertical_hole();  
translate([-1,sun_screen_diam/2,-hh/2])cube([1,2*width+45,hh+15]); 
}

if(0){
    allow_rotation();
}