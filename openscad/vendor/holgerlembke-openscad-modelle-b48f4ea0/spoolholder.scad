/*
    
    Filament-Halter-Haken für Lundia-Regal
    
    Infill: cubic, 70% Füllung
    
    Wenn zwei oder mehr Rollen gehalten werden sollen:
       zwei Paar Arme mit "rundscheibeh"
       restlichen Paare mit "rundscheibeh/2.0" und zusammenkleben
   
    Zapfen ist ausgelegt für ein Kugellager 608 ZZ, innen 8 mm, aussen 22 mm,
    Breite 7 mm, eines der Standardlager für 3d-Drucker.
    Lager wird aufgeklebt. Ggf. funktioniert auch plastisch einpassen, d. h.
    Zapfen erwärmen, Lager aufstecken, Zapfenrest plastisch verformen als
    Deckel.
    
    Erster Ausdruck mit 14 mmm "rundscheibeh" ergibt einen ziemlich massiven
    Arm. GGf. sind 10 mm ausreichend?
*/

$fn = $preview ? 20 : 200;

// Stützenabmessung Breite/Höhe
lundiax=28.5+0.7;
lundiay=42;
lundiayofs = -10;

rundscheibeaussendm = 2*(28+23/2);
rundscheibeh = 14.0;                                  // Dicke des Arms

armlaenge = 120.0;
oberarmdicke = 20.0;
armenddm = 5.0;

kugellagerdi=8.0-0.1;                  // DM der Bohrung
kugellageras = 16.0;                   // DM des Anschlags
kugellagerb = 7.0+2.0;               // Breite
kugelofs = 10.0;                         // Offset vonne Wand

halterseite = 1;   // 0: links, 1: rechts, 2: beide
rundungsdm = 1.2;                        // Rundung im Regalinnnen

// ein Paar, Printer ready
/**/
haltearm(0);
translate([0,85,rundscheibeh]) rotate([180,0,0]) haltearm(1);
/**/

//===================================================
module haltearm(hs) {
    difference() {
        union() {
            difference() {
                union() {
                    cylinder(h=rundscheibeh,d=rundscheibeaussendm);

                    // oberer Arm
                    translate([0,rundscheibeaussendm/2.0-oberarmdicke,0])
                        cube([armlaenge+lundiax/2-armenddm/2,oberarmdicke,rundscheibeh]);
                    
                    // Rundung am Ende
                    translate([armlaenge+lundiax/2-armenddm/2,rundscheibeaussendm/2.0-oberarmdicke/2.0,0]) {
                        translate([0,(oberarmdicke-armenddm)/2.0,0])
                            cylinder(d=armenddm,h=rundscheibeh);
                        translate([0,(-oberarmdicke+armenddm)/2.0,0])
                            cylinder(d=armenddm,h=rundscheibeh);
                        translate([0,(-oberarmdicke+armenddm)/2.0,0])
                            cube([armenddm/2.0,oberarmdicke-armenddm,rundscheibeh]);
                    }

                    // unterer Arm
                    translate([12,-rundscheibeaussendm/2.0+10,0])
                        rotate([0,0,22.12]) // ermittelt durch genaues Hingucken...
                        cube([armlaenge+lundiax/2-4,oberarmdicke,rundscheibeh]);

                    if ((hs==0) || (hs==2)) {
                        color("red")
                        translate([armlaenge,rundscheibeaussendm/2.0-oberarmdicke/2,rundscheibeh]) {
                            cylinder(h=kugelofs,d=kugellageras);
                            translate([0,0,kugelofs]) {
                                cylinder(h=kugellagerb,d=kugellagerdi);
                                // Kleiner Deckel
                                translate([0,0,kugellagerb])
                                    scale([1,1,0.5]) sphere(d=kugellagerdi);
                            }
                        }
                    } 
                    if ((hs==1) || (hs==2)) {
                        color("blue")
                        translate([armlaenge,rundscheibeaussendm/2.0-oberarmdicke/2,-kugelofs]) {
                            cylinder(h=kugelofs,d=kugellageras);
                            translate([0,0,-kugellagerb]) {
                                cylinder(h=kugellagerb,d=kugellagerdi);
                                // Kleiner Deckel
                                translate([0,0,0])
                                    scale([1,1,0.5]) sphere(d=kugellagerdi);
                            }
                        }
                    }
                        
                }
                union() {
                    translate([0,lundiayofs,0])
                        color("gray") cube([lundiax,lundiay,300],center=true);

                    translate([0,-30,0])
                        color("gray") cube([lundiax,lundiay,300],center=true);
                }
            }

            translate([-(lundiax)/2.0,(lundiay-rundungsdm)/2.0+lundiayofs,0])
            cube([rundungsdm/2.0,rundungsdm/2.0,rundscheibeh]);

            translate([(lundiax-rundungsdm)/2.0,(lundiay-rundungsdm)/2.0+lundiayofs,0])
            cube([rundungsdm/2.0,rundungsdm/2.0,rundscheibeh]);
        }
        union() {
            translate([-(lundiax-rundungsdm)/2.0,(lundiay-rundungsdm)/2.0+lundiayofs,0])
            cylinder(d=rundungsdm,h=rundscheibeh);

            translate([(lundiax-rundungsdm)/2.0,(lundiay-rundungsdm)/2.0+lundiayofs,0])
            cylinder(d=rundungsdm,h=rundscheibeh);
        }
    }
}        



