/*
    
    Filament-Halter-Haken für Lundia-Regal V3  
    
    Infill: cubic, 70% Füllung
    
*/

$fn = $preview ? 20 : 200;

// Stützenabmessung Breite/Höhe
lundiax=28.5+1.7;   // mehr Platz
lundiay=42;
lundiayofs = -10;

rundscheibeaussendm = 2*(28+23/2);
rundscheibeh = 8.0;                                  // Dicke des Arms

armlaenge = 120.0;
oberarmdicke = 20.0;
armenddm = 5.0;

kugellagerdi=8.0-0.1;                  // DM der Bohrung
kugellageras = 16.0;                   // DM des Anschlags
kugellagerb = 7.0+2.0;               // Breite
kugelofs = 14.0;                         // Offset vonne Wand

halterseite = 1;   // 0: links, 1: rechts, 2: beide
rundungsdm = 1.2;                        // Rundung im Regalinnnen

ausschnittb = 12;
ausschnitth = 12;
ausschnittbofs = 2;


// Spulenroller
arml = 65;
armda = 25;
armdi = 20;
armhs = 5;
armhsofs = 10;
arminnenb = 2;

sizedelta = 0.2;
halted = 5;
halteb = 20;
haltel = 20;

seite = 0;   // 0, 1

haltearm();
if (seite==0) {
    translate([0,0,rundscheibeh]) rotate([0,180,0]) kippschutz();
    translate([122.6,34,rundscheibeh]) rotate([180,180,0]) spulenroller();
} else {    
    kippschutz();
    translate([123,34,0]) rotate([180,0,0]) spulenroller();
}

//===================================================
module kippschutz() {
    p = [[0,0],[60,0],[0,28]];
    d = 5;

    color("green") translate([-d/2,-lundiayofs+1,0]) rotate([0,90,0]) linear_extrude(height = d) polygon(p);
}

//===================================================
module spulenroller() {
    // der Arm
    color("blue") {
        difference() {
            union() {
                cylinder(d=armda,h=arml+armhs);
                translate([-armda/2.0,0,0]) cube([armda,armda/2.0,arml+armhs]);

                // Halterand
                translate([0,-armhsofs,arml]) cylinder(d=armda,h=armhs);
            }
            union() {
                translate([0,0,10]) cylinder(d=armdi,h=arml);
            }
        }
        translate([-arminnenb/2,-armda/2+1,0]) cube([arminnenb,armda-1,arml+armhs]);
    }
}

//===================================================
module haltearm() {
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
                        rotate([0,0,22.02]) // ermittelt durch genaues Hingucken...
                        cube([armlaenge+lundiax/2-4,oberarmdicke,rundscheibeh]);
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


