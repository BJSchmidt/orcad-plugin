/*
     Halterung für Remote-Ding im 40er V-Slot-Profil  
     
     aufrecht stehend mit Support drucken 
*/

$fn = $preview ? 20 : 100;


laenge = 40.0;  // Slot-Breite
breite = 60.0;
dicke = 7.0;
stegbreite = 6.2;
steghoehe = 2.0;
stegluecke = 16.0;

seitenwandhoehe = 10.0;
seitendicke = 4.0;

// Steg
lochdurchmesser = 4.5;

// Schraube
schraubenkopfdurchmesser = 10.0;
schraubenkopfhoehe = 3.0;

// Straps
strapsdurchmesser = 3.0;


difference() {
    union() {
        // Basisplatte
        cube([laenge,breite,dicke]);

        // die beiden Stege fürs Aluprofil
        translate([10.0-stegbreite/2,0,-steghoehe]) 
        cube([stegbreite,breite,steghoehe+1.0]);
        
        translate([30.0-stegbreite/2,0,-steghoehe]) 
        cube([stegbreite,breite,steghoehe+1.0]);
        
        // die beiden Seitenwände
        translate([0.0,0.0,dicke-1.0]) 
        cube([seitendicke,breite,seitenwandhoehe+1.0]);
        
        translate([laenge-seitendicke,0.0,dicke-1.0]) 
        cube([seitendicke,breite,seitenwandhoehe+1.0]);        
    }
    
    union() {
        // die beiden Schraubenlöcher+Schraubenkopf
        translate([10.0,breite/2.0,-10.0]) 
        cylinder(h=20.0, d=lochdurchmesser);

        translate([10.0,breite/2.0,dicke-schraubenkopfhoehe]) 
        cylinder(h=schraubenkopfhoehe+1.0, d=schraubenkopfdurchmesser);

        translate([30.0,breite/2.0,-10.0]) 
        cylinder(h=20.0, d=lochdurchmesser);       
        
        translate([30.0,breite/2.0,dicke-schraubenkopfhoehe]) 
        cylinder(h=schraubenkopfhoehe+1.0, d=schraubenkopfdurchmesser);

        // die beiden Strapslöcher in den Seitenwänden
        translate([-10.0,10.0,seitenwandhoehe+dicke-strapsdurchmesser/2.0-3.0]) 
        rotate([0,90,0])
        cylinder(h=60.0,d=strapsdurchmesser);

        translate([-10.0,breite-10.0,seitenwandhoehe+dicke-strapsdurchmesser/2.0-3.0]) 
        rotate([0,90,0])
        cylinder(h=60.0,d=strapsdurchmesser);

        // Lücke im Steg
        translate([0,(breite-stegluecke)/2.0,-steghoehe]) 
        cube([laenge,stegluecke,steghoehe]);
    }    
}



