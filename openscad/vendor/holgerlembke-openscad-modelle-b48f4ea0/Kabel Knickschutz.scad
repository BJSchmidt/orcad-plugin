/*
      Kabel Knickschutz
      
      Wenn man den Ringabstand unter 0.8 setzt, wird das Support nicht
      mitgedrucht (?).
      
*/

$fn = $preview ? 20 : 120; // hier ändern für schnelleres Rendern

ringda = 12.0;       // Aussendurchmesser, nimmt um ringdmdelta je Stufe ab
ringdi = 6.0;       // Innenkanaldurchmesser
ringh = 0.8;

ringanzahl = 12;
ringabstand = 0.8;
ringdmdelta = 0.1;    // Die "Pyramidigkeit" nach oben

stegbreite = 3.0;

// Fußring
basisringda = 20.0;     // Aussendurchmesser des Innenandockflansches
basisringab = 2.0;      // Abstand zum Flanschende
basisringh = 3.0;       // Flanschhöhe

for (n = [0 : 1 : ringanzahl-1]) {
    dd = n*ringdmdelta;
    dh = n*(ringh+ringabstand);

    translate([0,0,dh])
    difference() {
        cylinder(d=ringda-dd,h=ringh);
        cylinder(d=ringdi,h=ringh);
    }
    
    // Der Flanschring
    translate([0,0,-basisringab-basisringh])
    difference() {
        union() {
            cylinder(d=basisringda,h=basisringh);
            translate([0,0,basisringh])
            cylinder(d=ringda,h=basisringab);
        }
        cylinder(d=ringdi,h=basisringh+basisringab);
    }

    if (n<ringanzahl-1) {
        translate([0,0,dh+ringh])
        difference() {
            cylinder(d=ringda-dd,h=ringabstand);
            
            union() {
                cylinder(d=ringdi,h=ringabstand);
                
                turn=n%2<0.9?0:1;
                rotate([0,0,90*turn]) {
                    translate([stegbreite/2.0,-ringda/2.0,0])
                    cube([ringda,ringda,ringabstand]);
                    
                    translate([-ringda-stegbreite/2.0,-ringda/2.0,0])
                    cube([ringda,ringda,ringabstand]);
                }
            }
        }
    }
}    



