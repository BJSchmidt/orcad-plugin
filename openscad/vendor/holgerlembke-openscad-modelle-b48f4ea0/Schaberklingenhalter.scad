/*
    Schaberklingenhalter
         
*/

$fn = $preview ? 20 : 200;



griffbreite = 25.0;
grifflaenge = 120.0;
griffhoehe = 5.0;
griffdia = 10.0;
griffrundung = 11;
griffsteifdm = 3.0;

dreimabs = (10.0+3.0)/2.0;
dreimdm = 3.1;

holderdm = 7.0-0.5;
holderh = 2.0;

klingenofs = -3.0; // gemeinsamer offset Gnubbel+Löcher
klingenofsholder = 4.0+holderdm/2.0;

klingend1 = 33.0;
klingend2 = 62.0;
klingenh = 18.8;
klingendelta = 3.0;

klingenz = 2.0;
klingenhh = griffhoehe+klingenz;
klingeno = [ 
    [-klingend1/2.0-klingendelta,0],
    [-klingend2/2.0-klingendelta,-klingenh-klingendelta],
    [+klingend2/2.0+klingendelta,-klingenh-klingendelta],
    [+klingend1/2.0+klingendelta,0]
    ];
klingeni = [ 
    [-klingend1/2.0,0],
    [-klingend2/2.0,-klingenh],
    [+klingend2/2.0,-klingenh],
    [+klingend1/2.0,0]
    ];
klingenpkt = [[0,1,2,3]];

/*

6.1+13.1
7
*/

intersection() {
    translate([-100,-15,0]) cube([200,200,200]);
    union() {
        color("red") {
            translate([0,klingenofs-klingenofsholder,griffhoehe]) cylinder(h=holderh,d=holderdm);
        }  
        difference() {
            union() {
                translate([-griffbreite/2.0,0,0]) 
                    cube([griffbreite,grifflaenge-griffdia/2.0,griffhoehe]);
                
                color("blue")
                translate([-(griffbreite-griffdia)/2.0,grifflaenge-griffdia,0]) 
                    cube([griffbreite-griffdia,griffdia,griffhoehe]);
                    
                color("green") {
                    translate([-(griffbreite-griffdia)/2.0,grifflaenge-griffdia/2.0,0]) 
                        cylinder(h=griffhoehe,d=griffdia);
                    translate([+(griffbreite-griffdia)/2.0,grifflaenge-griffdia/2.0,0]) 
                        cylinder(h=griffhoehe,d=griffdia);
                }
                
                color("blue")
                translate([0,0,klingenhh/2.0])
                    linear_extrude(height=klingenhh, center = true, convexity = 10, twist = 0)
                        polygon(klingeno,klingenpkt);
                        
                translate([-(griffbreite+griffrundung)/2.0,0,0])
                cube([griffbreite+griffrundung,griffrundung/2.0,griffhoehe]);
                
                color("pink") {
                translate([10,grifflaenge-griffrundung,griffhoehe])
                rotate([90,0,0]) cylinder(d=griffsteifdm,h=grifflaenge-griffrundung-2);
                translate([-10,grifflaenge-griffrundung,griffhoehe])
                rotate([90,0,0]) cylinder(d=griffsteifdm,h=grifflaenge-griffrundung-2);
                }
            }
            union() {
                translate([0,klingenofs,0]) {
                    translate([dreimabs/2.0,0,-5]) cylinder(h=10,d=dreimdm);
                    translate([-dreimabs/2.0,0,-5]) cylinder(h=10,d=dreimdm);
                }
                color("blue")
                translate([0,0,klingenz/2.0+griffhoehe])
                    linear_extrude(height=klingenz, center = true, convexity = 10, twist = 0)
                        polygon(klingeni,klingenpkt);      

                translate([griffbreite/2.0+griffrundung/2.0,griffrundung/2.0,0])
                cylinder(h=griffhoehe+1,d=griffrundung);
                translate([-griffbreite/2.0-griffrundung/2.0,griffrundung/2.0,0])
                cylinder(h=griffhoehe+1,d=griffrundung);
            }
        }
    }
}

