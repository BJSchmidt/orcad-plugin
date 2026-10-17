/*
    
    Filament Guide für Ender 3 V3 KE
    für seitliche Rolleninstallation
    
    Version 2: mit Rolle
    
    Mein OpenSCAD-Code ist hier unteroptimal.
    
*/

$fn = $preview ? 20 : 300;


winkelh = 50.0;
winkell = 40.0;
winkelb = 40.0;
winkeldl = 10.0;
winkeldo = 7.0;

kantrund = 2.0;

beflochdm = 5.0;     // Befestigungsloch Rahmen (oben)
beflochkdm = 10.0;     // Befestigungslochkopf Rahmen (oben)
beflochabs = 20.0;   // Abstand der Befestigungslöcher
belochkh = 3.0; // Kopfhöhe der Schraube

kupplungaussen = 25.0;
kupplungh = 18.0;

sensorzdm = 8.2; // der Zapfen an der Unterseite
sensorl = 40.0;
sensorb = 32.0;
sensorh = 20.0;

// Rollrad
rollrdm = 24.0;
rollrnutr = 1.0;
rollrschrdm = 3.5;
rollrb = 3.0;

/**/
difference() {
    halter();
    rotate([-5,0,0]) translate([-21,1,40]) rotate([0,90,0]) sensor();
}    
/**/
// rotate([-5,0,0]) translate([-21,1,40]) rotate([0,90,0]) sensor();

//translate([0,-50,0]) halterungsdemo();

//rollrad();


//************************************************************************
module halter() {
    difference() {
        union() {
            translate([0,0,20]) cube([winkelb,winkell,winkelh-20]);
            translate([0,19,20]) rotate([0,90,0]) cylinder(d=20,h=10);
        }
        union() {
            // Winkel
            translate([winkeldl,0,0]) cube([winkelb-winkeldl,winkell,winkelh-winkeldo]);
            
            // Rundungskante
            translate([0,0,winkelh-kantrund/2]) cube([kantrund/2,winkell,kantrund/2]);

            // Befestigungslöcher
            translate([winkeldl+(winkelb-winkeldl)/2.0,(winkell-beflochabs)/2.0,winkelh-winkeldo]) cylinder(d=beflochdm,h=winkeldo);
            translate([winkeldl+(winkelb-winkeldl)/2.0,(winkell+beflochabs)/2.0,winkelh-winkeldo]) cylinder(d=beflochdm,h=winkeldo);

            translate([winkeldl+(winkelb-winkeldl)/2.0,(winkell-beflochabs)/2.0,winkelh-belochkh]) cylinder(d=beflochkdm,h=winkeldo);
            translate([winkeldl+(winkelb-winkeldl)/2.0,(winkell+beflochabs)/2.0,winkelh-belochkh]) cylinder(d=beflochkdm,h=winkeldo);
        }
    }
    translate([kantrund/2,0,winkelh-kantrund/2]) rotate([-90,0,0]) cylinder(d=kantrund,h=winkell);
    
    kfl = 13.0;
    kfh = 17.0;
    kdr = 8.0;
    translate([-kupplungaussen,winkell-kupplungh-kfl,winkelh-kupplungh-kantrund+kfh]) 
    rotate([-15,0,0]) 
    union() {
        difference() {
            color("green")  union() {
                cube([kupplungaussen,kupplungaussen,kupplungh]);
                translate([kupplungaussen,0,kdr-3]) 
                rotate([-90,0,0]) cylinder(d=kdr,h=kupplungaussen);
                
            }
            translate([kupplungaussen/2.0,kupplungaussen/2.0,0]) kupplung();
        }
/**/
        translate([12,20,12]) 
        rotate([0,90,0]) rollrad();
/**/
    }
}

//************************************************************************
module rollrad() {
    color("blue") difference() {
        union() {
            translate([0,0,-1.5]) cylinder(d=rollrdm,h = rollrb);
        }
        union() {
            rotate_extrude(convexity = 10) translate([rollrdm/2.0, 0, 0]) circle(r = rollrnutr);
            translate([0,0,-rollrb/2.0-1]) cylinder(d=rollrschrdm,h = rollrb+2);
        }
    }    
}

//************************************************************************
// Negativ-Element der Schlauchkupplung
module kupplung() {
    offs = -0.5;
    
    bb = rollrb+2;
    
    // Slot für das Rollrad
    translate([-bb/2.0+offs,-6.2,-10]) cube([bb,30,35]);
    translate([-15,7,13]) rotate([0,90,0]) cylinder(d=rollrschrdm,h=30);
    
/*    
    cylinder(d=10.0+offs, h=6.6);
    translate([0,0,6]) cylinder(d=11.8+offs,h=20.0,$fn=6);
*/    
}

//************************************************************************
// der Filament-Ende-Sensor
module sensor() {
    color("gray") {
        cube([sensorl,sensorb,sensorh]);
        translate([sensorl/2.0,sensorb/2.0,sensorh]) cylinder(d=sensorzdm,h=12.5);
        
        translate([-10,sensorb/2.0,7.9]) rotate([0,90,0]) cylinder(d=2.0,h=60);
    }
}

/*
sensorzdm = 7.2; // der Zapfen an der Unterseite
sensorl = 40.0;
sensorb = 32.0;
sensorh = 20.0;
*/










