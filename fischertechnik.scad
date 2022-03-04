use <MCAD/involute_gears.scad>
/*
// placeholder, if no gear library is used
module spur_gear(mod,teeth,thickness) {
        cylinder(d=mod*teeth, h=thickness, center=true);
}

// BOSL2 function API for the BOSL v1 involute_gears library
module spur_gear(mod,teeth,thickness,shaft_diam=0) {
        gear(mm_per_tooth=mod*PI, number_of_teeth=teeth, thickness=thickness,hole_diameter=shaft_diam);
}
*/
// BOSL2 function API for the MCAD involute_gears library
module spur_gear(mod,teeth,thickness,shaft_diam=0) {
        gear(circular_pitch=mod*180, number_of_teeth=teeth, gear_thickness=thickness,bore_diameter=shaft_diam,
    hub_diameter=0, rim_thickness=thickness, rim_width=0);
}

/*
include <BOSL/constants.scad>
use <BOSL/involute_gears.scad>
*/


// === globale Variablen ===========================

no_screwslots = false;  // Schraubenschlitze in den Rastnasen

$fn=30;


// === reale Bausteine =============================

/**
 * 1966:31003 Baustein 30 (graun)
 */
module Baustein30(color="Silver") {
    Grundbaustein(color=color);
}

/**
 * 1973:31004 Baustein 30 Vierkantbohrung (grau)
 */
module Baustein30viereckloch(color="Silver") {
    Grundbaustein(color=color, querloch=true,viereckloch=true);
}

/**
 * 1966:31004 Baustein 30 Rundbohrung (grau)
 */
module Baustein30rundloch(color="Silver") {
    Grundbaustein(color=color, querloch=true,viereckloch=false);
}

/**
 * 1966:31005 Baustein 15 (grau)
 */
module Baustein15(color="Silver") {
    Grundbaustein(len=15,color=color);
}

/**
 * 1966:31006 Baustein 15 2Z (grau)
 */
module Baustein15_2z(color="Silver") {
    Grundbaustein(len=15,rastnasen=2,color=color);
}

/**
 * 1966:31007 Baustein 15 2RZ (rot)
 */
module Baustein15_2rz(color="Silver") {
    Grundbaustein(len=15,rastnasen=2,rundnase=true,color=color);
}

/**
 * 1966:31059 Baustein 15 RZ (rot)
 */
module Baustein15rz(color="Silver") {
    Grundbaustein(len=15,rundnase=true,color=color);
}

/**
 * 1973:37237 Baustein 5 (rot)
 */
module Baustein5() {
    color("red") {
        difference () {
            translate ([-7.5,-7.5]) cube([15,15,5]);
            rotate ([-90,0,0]) flachnut();
        };
        translate ([0,0,5]) rastnase();
    };
}

/**
 * 1975:37468 Baustein 7.5 (rot)
 */
module Baustein7() {
    color("red") {
        difference () {
            translate ([-7.5,-7.5]) cube([15,15,7.5]);
            // die beiden Flachnuten oben und unten
            rotate ([-90,0,0]) flachnut();
            translate ([0,0,7.5]) rotate ([90,0,0]) flachnut();
            // die Rundnuten an den Seiten
            // links
            translate ([-7.5,0,7.5/2])
                rotate ([0,90,90])
                    nut();
            // rechts
            translate ([7.5,0,7.5/2])
                rotate ([0,90,270])
                    nut();

        };
    };
}

/**
 * 1975:37636 Rollenlager 15 (rot)
 *
 * Ausrichtung: Rastnasen unten, Innenraum offen entlang Y-Achse
 * FIXME: Materialstärke wild geschätzt. Nachmessen!
 */
module Rollenlager15() {
    color("red") {
        difference () {
            // Grundkörper
            translate ([-7.5,-7.5,0]) cube(15);
            // Aussparung Innenraum
            translate ([-3.75,-8,2]) cube([7.5,16,15]);
            // Nut hinten
//            translate ([0,7.5,0]) rotate ([0,0,0])  nut();
            // Nut vorne
//            translate ([0,-7.5,0]) rotate ([0,0,180])  nut();
            // Nut hinten
            translate ([0,7.5,7.5]) rotate ([0,90,0])  nut();
            // Nut hinten
            translate ([0,-7.5,7.5]) rotate ([180,90,0])  nut();
            // Nut oben
            translate ([0,0,15]) rotate ([90,0,90])  nut();
        };
        rotate ([180,0,0]) rastnase();
    };
}


/**
 * 1966:31010 Winkelstein 60° (rot)
 *
 * Referenzpunkt: mittig auf der Seite mit der Flachnut
 */
module Winkelstein60() {
    color("Red") {
        winkelstein(r=7.5,a=60);
        translate([7.5,0])
            rotate([0,60,0])
                translate([-7.5,0])
                    rastnase();
    };
}

/**
 * 1966:31011 Winkelstein 30° (rot)
 *
 * Referenzpunkt: mittig auf der Seite mit der Flachnut
 * Geometrie: 30° Segment eines Kreisbogens mit r=15mm
 * Die Rastnase und die Flachnut liegen genau auf diesem Radius.
 *
 *
 */
module Winkelstein30() {
    winkelstein(r=15,a=30);
}


/**
 * 1983:31981 Winkelstein 15° (rot)
 *
 * Referenzpunkt: mittig auf der Seite mit der Flachnut
 * Geometrie: 15° Segment eines Kreisbogens mit r=22.5mm
 * Die Rastnase und die Flachnut liegen genau auf diesem Radius.
 *
 *
 */
module Winkelstein15() {
    winkelstein(r=22.5,a=15);
}


/**
 * 1984:32071 Winkelstein 7.5° (rot)
 *
 * Referenzpunkt: mittig auf der Seite mit der Flachnut
 * Geometrie: 7.5° Segment eines Kreisbogens mit r=30mm
 * Die Rastnase und die Flachnut liegen genau auf diesem Radius.
 *
 * FIXME: Der Radius ist nur geraten, ich hatte keine Teile zum
 * Nachmessen!
 */
module Winkelstein7() {
    winkelstein(r=30,a=7.5);
}


/**
 * 1966:31013 Flachstein 30 (rot)
 *
 * Referenzpunkt: linke untere Ecke
 */
module Flachstein30(color="Red") {
    color(color) {
        difference() {
            union() {
                translate([30,15,0]) rotate([0,90,90]) flachnut();
                translate([0,15,0])  rotate([0,90,270]) flachnut();
                translate([0,0,-2]) cube ([30,30,4]);
            };
            translate([2,2,0]) cube ([26,26,2.01]);
        };
    }
}


/**
 * 1971:35795 Seilrolle 21x7 (rot)
 *
 * Referenzpunkt: Mittig auf der Drehachse
 */
module Seilrolle21x7() {
    color("Red")
    rotate_extrude(convexity = 10)
    polygon( points=[
        // top side profile:
        // d=4mm inner hole, d=7.5mm inner flange, d=15.5mm middle flange (3.5mm thick), d=23mm outer flange
        [2.05,3.5],[3.75,3.5],[3.75,1.75],[7.75,1.75],[7.75,3.5],[11.5,3.5],
        // outer side profile:
        //   1mm staight, 1mm -2mm,
        //   3mm staight,
        //   1mm +2mm, 1mm straight
        [11.5,2.5],[9.5,1.5],
        [9.5,-1.5],[11.5,-2.5],
        // bottom side (symmetrical to the top side)
    [11.5,-3.5],[7.75,-3.5],[7.75,-1.75],[3.75,-1.75],[3.75,-3.5],[2.05,-3.5],[2.05,3.5]
    ] );
    }


/**
  * 1966:31014 Nabe 25 komplett
  *
  * Referenzpunkt: mittig in der Radaufnahme
  * Größen:
  * - von Mitte bis Oberseite der Hauptscheibe: 3.3mm
  * - Von Mitte bis Unten: 10.55-1.1 = 9.45mm
  * - von Mitte bis Oben:   8.7 +1.1 = 9.8mm
  * - Gesamthöhe 19.25mm (FIXME: soll = 18mm)
  * 
  */
module Nabe() {
    translate([0,0,1.1]) Nabenoberteil();
    translate([0,0,-1.1]) Nabenunterteil();
//    translate([0,0,-4.75]) Nabenunterteil();
}

/**
  * 1966:31015 Flachnabe 25 komplett (rot)
  *
  * Referenzpunkt: mittig bei der Radaufnahme
  * Größen:
  * - von Mitte bis Oberseite der Hauptscheibe: 3.3mm
  * - Von Mitte bis Unten: 12.75-3.65 = 9.1mm
  * - von Mitte bis Oben:   8.7 +1.1  = 9.8mm
  * - Gesamthöhe
  * 
  */
module Flachnabe() {
    translate([0,0,1.1]) Nabenoberteil();
    translate([0,0,-3.65]) Flachnabenunterteil();
}

/**
 * 1966:31026 Handkurbel KR25 (rot)
 *
 * Simplified model with only aprox. measurements.
 * Some internal cut outs missing.
 *
 * Referenzpunkt: Achsenmitte am unteren Ende der Kurbel. Griff liegt dann 25mm weiter links (dx=25mm)
 * Zur richtigen Montage auf einer Nabe muss die Kurbel um dz=+3.3mm verschoben werden.
 */
module Handkurbel() {
    color("Red")
    difference() {
        union() {
            hull() {
                cylinder(d1=17,d2=14,h=8.5);
                translate ([25,0,20-13.5]) cylinder(d=4.5,h=3);        }
            // the axle holder top
            translate ([0,0,12-5]) cylinder(d1=7,d2=5,h=5);
            // handle
            translate ([25,0,20-13.5]) cylinder(d1=4.5,d2=4,h=13.5);
        }
        // cut out the part under the handle
        rotate_extrude() polygon(points=[[11.5,0],[11.5,4],[28,7],[28,0],[11.5,0]]);
        // empty the interior of the main part
        translate([0,0,-0.01]) cylinder(d1=17-3,d2=11.5,h=6);
        cube([25,2.5,11],center=true);
        // axle bore
        cylinder(d=4,h=25,center=true);
    }
}


/**
 * 1966:31023 Klemmbuchse 10
 *
 * Klemmbuchse entlang der Z-Achse.
 *
 * Referenzpunkt: mittig im Teil auf der Achse.
 */
module Klemmbuchse10(l=10) {
    color("Red")
    difference() {
        cylinder(d=7.7,h=l,center=true);
        cylinder(d=3.5,h=l+0.01,center=true);
        translate([0,-1.25,-l/2-0.01]) cube([4,2.5,l+0.02]);
        translate([-4,-0.5,l/2-1]) cube([4,1,1+0.01]);
    }
}


/**
 * 1975:37679 Klemmbuchse 5
 *
 * Klemmbuchse entlang der Z-Achse.
 *
 * Referenzpunkt: mittig im Teil auf der Achse.
 */
module Klemmbuchse5() {
    Klemmbuchse10(l=5);
}


/**
 * 1966:31024 Klemmkupplung 20
 *
 * Klemmkupplung entlang der Z-Achse.
 *
 * Referenzpunkt: mittig im Teil auf der Achse.
 */
module Klemmkupplung20() {
    l=20;
    color("Red")
    difference() {
        cylinder(d=7.7,h=l,center=true);
        cylinder(d=4,h=l+0.01,center=true);
        translate([-4,-0.25,l/2-1.5]) cube([8,0.5,2]);
        translate([-4,-0.25,-l/2-2+1.5]) cube([8,0.5,2]);
    }
}


/**
 * 1970:31081 Achshalter 30x60 (rot)
 *
 * Referenzpunkt: mittig in der Fläche, auf der Unterseite.
 * Größe: 32x60x6.
 * Ankerpunkte: Mittelpunkte der Achsen bei x=0, y=[-10;-5;0;5;10] und z=3 gegenüber dem Achshalter.
 * Quality: fair, but not an exact copy.
 */
module Achshalter30x60() {
    color("red") {
        difference() {
            // base plate
            linear_extrude(1.8)
                offset(r=1)
                    square(size=[60-2,32-2],center=true);
            // big holes in the base plate
            for (i=[-18.5,0,18.5])
                translate([i,0,0])
                    cube([13,24,5],center=true);
        }
        // add the axis holders
        for (x=[-13-5.5,0,13+5.5]) {
            for (y=[-12.5:5:12.5])
                translate([x,y,3]) 
                    cube([13.02,1,6],center=true);
            for (y=[-10:5:10]) {
                translate([x,y+2,5.5]) 
                    rotate([0,90,0]) cylinder(d=1,h=13.02,center=true);
                translate([x,y-2,5.5]) 
                    rotate([0,90,0]) cylinder(d=1,h=13.02,center=true);
            };
        }
    }
}


/**
 * Metallachsen
 *
1966:31034 Metallachse30
1966:31033 Metallachse50
1966:31032 Metallachse60
1975:37384 Metallachse80
1982:31040 Metallachse90
1966:31031 Metallachse110
1982:31036 Metallachse125
1982:31030 Metallachse150
1995:36975 Metallachse160
1971:35696 Metallachse170
1971:35697 Metallachse200
1968:31310 Metallachse235
2016:159590 Metallachse235
1985:31055 Metallachse240
2003:107436 Metallachse260
2003:107435 Metallachse275
1985:32355 Metallachse315
1969:31377 Metallachse360
1985:32356 Metallachse435
2016:160357 Metallachse450
 */
module Metallachse30() {color("Silver") achse(30);}
module Metallachse50() {color("Silver") achse(50);}
module Metallachse60() {color("Silver") achse(60);}
module Metallachse80() {color("Silver") achse(80);}
module Metallachse110() {color("Silver") achse(110);}
module Metallachse150() {color("Silver") achse(150);}


/**
 * 1966:31017 Reifen 30 (schwarz)
 *
 * Profil aussen: 1mm klein, 0.5mm groß, 3mm klein, 0.5groß, 1 klein
 * - Durchmesser groß 29, klein 28
 *   innen 26, 22(25.5, 21.5?)
 *   Anfasung innen 2.5, 45°, 0.75
 * Referenzpunkt: mittig im Reifen
 */
module Reifen30() {
    color("DimGray") {
        rotate_extrude()
            polygon(points=[[11,1],[13,2],[13,3],
            [14,3],[14,2],[14.5,2],[14.5,1.5],[14,1.5],
            [14,-1.5],[14.5,-1.5],[14.5,-2],[14,-2],[14,-3],
            [13,-3],[13,-2],[11,-1],
            [11,1]]
            );
        // add the inner teeth
        reifenzaehne();
        rotate([0,0,120]) reifenzaehne();
        rotate([0,0,240]) reifenzaehne();
    };
}

/**
 * 1966:31018 Reifen 45x12 (schwarz)
 *
 * Duchmesser aussen 45, innen 26 => D=35.5, r=17.75, d=9.5
 */
module Reifen45() {
    m = 45/2-6; // radius for the circle center
    color("DimGray") {
        rotate_extrude()
            translate([45/2-6,0]) {
                circle(d=12);
                translate([4.5,0]) square(3,center=true);
                translate([5.5,2.5/2]) square(1);
                translate([5.5,-2.5/2-1]) square(1);
            }
        for (a=[0:360/48:359]) {
            rotate([0,0,a])
                translate([m,-0.5,-6]) cube([6,1,12]);
        }

        // add a full ring of inner teeth
        reifenzaehne(360);
    }
}



/**
 * 1966:31020 Klemmring Z36 m0,5 für Seiltrommel (rot)
 *
 * Referenzpunkt: mittig im Teil, Teil liegt flach in X/Y Ebene
 * quality: 1 (outline only) FIXME
 *
 */
module KlemmringZ36()
{
    color("red")
    difference() {
//        cylinder(d=19,h=6.3,center=true);
        spur_gear(mod=0.5, teeth=36, thickness=6.3);
        // almost rectangular holes
        for (i=[0,180])
            rotate([0,0,i]) translate([0,5,0]) cube([4.5,4.5,10],center=true);
        // hole
        cylinder(d=4,h=7,center=true);
    }
}


/**
 * 1966:31016 Seiltrommel 15 (rot)
 *
 * Geometrie: Länge 15mm, Durchmesser innen knapp 8mm, aussen 15mm
 * Referenzpunkt: Trommel steht senkrecht entlang der Z-Achse, Referenzpunkt ist mittig am unteren Ende
 * quality: 5 (good, but some details missing)
 */
module Seiltrommel15() {
    color("red")
    difference() {
        union () {
            cylinder(d=8,h=15);
            cylinder(d=15,h=1.5);
            translate([0,0,15-1.5]) cylinder(d=15,h=1.5);
            rotate([90,0,0]) flachnut(l=14);
            translate([0,0,15]) rotate([-90,0,0]) flachnut(l=14);
        };
        // axle hole
        cylinder(d=4,h=31,center=true);
        // the gap in the middle of the flat connector
        translate([-3,-3,15]) cube(6);
        translate([-3,-3,-6]) cube(6);
        // the small slot
        translate([0,0,-0.1]) cube([10,0.5,16]);
    };
}

/**
 * 1966:31025 Seilhaken 30 (rot)
 *
 * Surprisingly, this might be the most complex part of all.
 *
 * Referenzpunkt: Rastnase
 * Ausrichtung: Liegend in X/Y-Ebene um Z=0, Rastnase bei Y=0, Haken in Y-Richtung, offen nach links
 * Quality: fair, but not all details are exactly right.
 *
 * Geometrie des Hakens:
 * - am Ende 2x3mm, r=ca. 1 => zwei Hälften in 1mm Abstand vereinigt
 * - rechte Seite: 4x3mm
 * - Innenkreis: d=6.5, Mittelpunkt in der Hauptachse
 * - Aussenkreis: d=12.8mm, Mittelpunkt rechts der Hauptachse.
 * - rechter Rand: steht ca. 3.5mm über
 * - linker Rand: steht ca. 2mm über (könnten auch 1.5 sein?)
 * - Gesamtlänge des Hakens ca. 28.3mm (nur Hakenteil 13.3mm)
 *
 * Vermutete Konstruktion:
 * - Profil d=2mm
 * - Innenkreis d=7.5, Aussenkreis d=11.5
 * - Mittelpunkt Aussenkreis 2mm nach rechts verschoben.
 * - Mittelpunkt Aussenkreis bei Y=28.3-12.5/2= ca. 22mm
 */
module Seilhaken30() {
    color("red") {
        translate([0,23,0])
        {
            hook(start=0,total=240);

            // hook base
            hull()
            {
                // rounded cube for the base part
                translate([0,-7,0])
                rotate([0,90,0])
                linear_extrude(7.5,center=true)
                    rounded_square([1,1],r=1,center=true);

                // end slice of the hook
                //FIXME: hier stimmt etwas nicht!
                hook(start=220,total=40,rounded_tip=false);
            }
        };

        // the main body with the bore and the attachment
        translate([0,7.5,0]) {
            difference() {
                cube([7.5,15,7.5],center=true);
                translate([0,-4,0])
                    cylinder(d=4,h=16,center=true);
            }
            translate([0,-7.5,0])
                rotate([90,0,0])
                    rastnase();

            // add the logo, this defines the top side of the hook
            translate([0,3.5,7.5/2-0.5])
                rotate([0,0,90])
                    logo(2);

        }
    }
}


/**
 * The hook tip
 *
 * This might be the most complex part of all.
 *
 * The hook tip results from the combination of two
 * torus-like structures of different diameters and with
 * their middle points shifted to each outer.
 *
 *
 * Alternative way to define the profile to be rotated:
            hull() {
                translate([10.5/2,-0.5]) circle(d=2);
                translate([10.5/2,0.5]) circle(d=2);
                translate([10.5/2-3,-1.5]) square(3);
            };
 * or as an explecit intersection:
        intersection() {
            rotate([0,0,start])
            rotate_extrude(angle=total)
                translate([8.5/2,-0.5])
                    offset(r=1)
                        square([3,1]);
            // outer ring
            translate([-1,0,0])
            rotate([0,0,start])
            rotate_extrude(angle=total)
                translate([10.5/2-3,-0.5])
                    offset(r=1)
                        square([3,1]);
        };
 */
module hook(start=-15, total=270, rounded_tip=true) {
    // We want the hook to be open to the left side, but
    // rotate_extrude always starts on the right side
    rotate([0,180,0]) {

        // Intersecting the inner and outer ring
        intersection_for(i=[-1,0]) {
            // inner (i=0) and outer (i=-1) ring
            translate([i,0,0])
            rotate([0,0,start])
            rotate_extrude(angle=total)
                translate([8.5/2+2*i,-0.5])
                    rounded_square([3,1],r=1);
        };

        // add the rounded tip is needed
        if (rounded_tip) {
            rotate([0,0,start])
                hull() {
                    translate([8.5/2,0,-0.5]) sphere(1);
                    translate([8.5/2,0,0.5]) sphere(1);
                };
        };
    };
}

module rounded_square(size=[1,3], r=1, center=false) {
    offset(r=r) square(size,center=center);
}

module rounded_cube(size=[1,1,1], r=1, center=false) {
    linear_extrude(size[3],center=center)
        rounded_square(size, r, center);
}


/**
 * 1970:36334 S-Riegelscheibe Z20 m0,5 (rot)
 *
 * Referenzpunkt: Mittig in der Scheibe auf der Achse
 */
module Riegelscheibe() {
    color("red") difference() {
        // using BOSL2:
        spur_gear(mod=0.5, teeth=20, thickness=2);
        // BOSLv1:
        //gear(mm_per_tooth=0.5*PI, number_of_teeth=20, thickness=2);
        statikloch();
    }
}

/**
 * 1975: 31060 Verbinder 15 (1975) (rot)
 *
 * flattend on one side
 *
 * orientation:
 * - length along the z-axis
 * - the round side on the negative x-side (left)
 * - the flattend side on the positive x-side (right)
 *
 * reference point: the part stands upright along the z-axis on the
 * reference point, centered on the middle of the central core part.
 *
 */
module Verbinder15() {
    color("red") verbinder(15,1);
}


/**
 * 1969: 31061 Verbinder 30 (1969) (rot)
 *
 * fully rounded on both sides
 *
 * orientation:
 * - length along the z-axis
 * - the round sides on the negative and positive x-side (left and right)
 *
 * reference point: the part stands upright along the z-axis on the
 * reference point, centered on the middle of the central core part.
 *
 */
module Verbinder30round() {
    color("red") verbinder(30,0);
}

/**
 * 1979: 31061 Verbinder 30 (1979) (rot)
 *
 * flattend on one side
 *
 * orientation:
 * - length along the z-axis
 * - the round side on the negative x-side (left)
 * - the flattend side on the positive x-side (right)
 *
 * reference point: the part stands upright along the z-axis on the
 * reference point, centered on the middle of the central core part.
 *
 */
module Verbinder30() {
    color("red") verbinder(30,1);
}

/**
 * 1968: 31330 Verbinder 45 (1968) (rot)
 *
 * fully rounded on both sides
 *
 * orientation:
 * - length along the z-axis
 * - the round sides on the negative and positive x-side (left and right)
 *
 * reference point: the part stands upright along the z-axis on the
 * reference point, centered on the middle of the central core part.
 *
 */
module Verbinder45round() {
    color("red") verbinder(45,0);
}

/**
 * 1979: 31330 Verbinder 45 (1979) (rot)
 *
 * flattend on one side
 *
 * orientation:
 * - length along the z-axis
 * - the round side on the negative x-side (left)
 * - the flattend side on the positive x-side (right)
 *
 * reference point: the part stands upright along the z-axis on the
 * reference point, centered on the middle of the central core part.
 *
 */
module Verbinder45() {
    color("red") verbinder(45,1);
}

/**
 * 1978: 35262 V-Stein-Verbinder 15 30 (gelb)
 *
 */
module Verbinder1530() {
    color("yellow") {
    }
}


/**
 * Grundplatte, noch nicht so ganz universell
 *
 * Quality: Fair, but not all details absolutely correct.
 *
 * bekannte Fehler/Schwächen:
 * - Slotlöcher am Anfang und Ende sind weniger tief
 * - Vertiefungen rund um die Mittellöcher fehlen
 */
module Grundplatte90x90(l=90,b=90) {
    color("Red")
    difference() {
        cube([l,b,6]);
        // slots on both sides
        for (i=[7.5:15:l]) {
            translate([i,0,3]) rotate([270,0,0]) slot();
            translate([i,b,3]) rotate([90,0,0]) slot();
        };
        // row of holes in the middle
        // a) corner hole left
        translate([0,b/2,0])
            rotate([0,0,90])
                nut();
        // b) corner hole right
        translate([l,b/2,0])
            rotate([0,0,270])
                nut();
        // c) row of holes in the middle
        for (i=[15:15:l-1]) {
            translate([i,b/2,-0.01]) cylinder(d=4,h=7);
        };
        // holes an the side flanks
        // left
        translate([-0.1,b/2-7.5,3]) rotate([0,90,0]) cylinder(d=4,h=20.1);
        translate([-0.1,b/2+7.5,3]) rotate([0,90,0]) cylinder(d=4,h=20.1);
        translate([l+0.1,b/2-7.5,3]) rotate([0,270,0]) cylinder(d=4,h=20.1);
        translate([l+0.1,b/2+7.5,3]) rotate([0,270,0]) cylinder(d=4,h=20.1);
    }

    // eye candy: emboss the logo
    translate([13,b-32,5.5]) logo();
}


/**
 * 1966: 31019 Drehscheibe 60x5,5 (rot)
 *
 * Durchmesser
 * - inner: 25.8mm
 * - slot: 38.8
 * - round slot: width ~4.2mm, diameter 45mm
        (measured: inner diameter 41mm. outer diameter ~49.5)
 * - outer: 61.8mm
 * - Vertiefung im Rand: 2.5mm tief
 * Dicke: 5.5mm, je 2mm Aussenränder, 1.5mm innenfläche
 * Sechskantlöcher/hexagonal holes:
 * - Schlüsselweite/width across flats 4mm (fits M2 nuts)
 * - Abstand 17mm, Lochkreisdurchmesser 34mm
 * - distance 17mm, bolt cycle diameter 34mm
 *   (measured: Diameter outside 37.5mm, inside 29.5mm)
 *   (=> Lochkreisdurchmesser ca. 33.5mm)
 *
 * Innerer Ring an den Zähnen:
 * - trapezförmiger Querschnitt
 * - aussen d=26mm, innen d=22mm => Höhe 2mm
 * - Breite aussen: 1.25mm von der Außenseite => 3mm breit
 * - Breite innen: geschätzt 2mm
 * Referenzpunkt: mittig in der Scheibe
 */
module Drehscheibe60() {
    t2 = 5.5/2;	// (half) thickness
    color("red") {
        difference(){
            rotate_extrude()
                polygon(points=[
//                    [11.4,1],
                    [13,t2],[31,t2],	// upper side
    	            [31,t2-1.5],[28.5,0.75],	// outside of the wheel
                    [28.5,-0.75],[31,-t2+1.5],
                    [31,-t2],[13,-t2],
//                    [11.4,-1],
//                    [11.4,1],
                    [13,t2]
                ]);
            
            for (a=[0:60:300]) rotate([0,0,a]) {
                // cut the slots perpendicular to the z axis
                translate([0,31,0])
                    rotate([90,0,0])
                        slot2(h3=15,h2=11.5,h1=1);

                // cut the round slots perpendicular to the disc surface
                linear_extrude(6,center=true) {
                    polygon(arc(22.5-4.5/2,22.5+4.5/2,-15,15,$fn=72));
                    for (a=[-15,15])
                        rotate([0,0,a])
                            translate([45/2,0,0])
                                circle(d=4.5);
                };
                // calculation of the radius for constructing a hexagon
                // with a given width across flats (Schlüsselweite SW):
                // r = SW / sqrt(3)
                rotate([0,0,a+30])
                    translate([0,33.5/2,0])
                        cylinder(6,r=4/sqrt(3),center=true,$fn=6);
            }; // for a
	    }; // difference

        // add the inner ring to connect the disc with the inner teeth
/*
 * Innerer Ring an den Zähnen:
 * - trapezförmiger Querschnitt
 * - aussen d=26mm, innen d=22mm => Höhe 2mm
 * - Breite aussen: 1.25mm von der Außenseite => 3mm breit
 * - Breite innen: geschätzt 2mm
*/
        difference(){
            rotate_extrude()
                polygon(points=[
                    [11,1],[13.01,1.5], // tiny overlap
                    [13.01,-1.5],[11,-1],
                    [11,1]
                ]);
            // cut the four slots/gaps in the inner ring
            for (a=[0,90]) rotate([0,0,a])
                cube([3,30,6],center=true);
        };

        // add the inner teeth
        for (a=[15:90:285])
            rotate([0,0,a])
                reifenzaehne(60);

    }; // color
}





/* === leere Kästen ======================================= */

/**
Box 262x189x40 hobbywelt (grau)
Box 189x131x40 u-tS neutral (grau)
1975:37386 Box 189x131x40 50 (grau)
1975:37387 Box 189x131x40 50-1 (grau)
1975:37378 Box 189x131x40 50-2 (grau)
 */

/**
 * Box 250
 *
 * size outside: 189x131x40
 * size inside:  183.5x125.5x38.5
 * useable inside height 33mm, otherwise it won't stack anymore.
 * coordinate of the lower left inside corner: [2.75,2.75,1.5]
 * internal divider walls should stick out for 1.25mm (up to 1.4mm) to safely connect into the box walls
 *
 * Nutzbare Innenhöhe 33mm, wenn der Deckelbereich freigehalten
 * werden soll.
 *
 * Außenmaß unten 128.5, oben 130.5 => stapelbar
 * Wandstärke 1.5mm
 * Deckelaussparung 5.5mm hoch, Wandstärke hier 1mm
 * Eckenradius außen 2mm
 * Eckverstärkungen (Eckpfosten) 1.5x1.5mm
 * Wandstärke der Fachteiler 1mm
 */
module Box250() {
    stapelbox(topx=189,topy=131,h=40);
}

/**
 * Box 500
 *
 * size outside: 262x189x40
 * size inside:  256.5x183.5x38.5
 * useable inside height 33mm, otherwise it won't stack anymore.
 * coordinate of the lower left inside corner: [2.75,2.75,1.5]
 * internal divider walls should stick out for 1.25mm (up to 1.4mm) to safely connect into the box walls
 */
module Box500() {
    stapelbox(topx=262,topy=189,h=40);
}


/* === gefüllte Kästen ==================================== */

/*
 * Berechnung der Positionen:
 * Außenmaß 189x131, 1.5mm Wandstärke => Innenmaß 186x128
 * Es gibt aber noch die Stapelschräge von 1.25mm pro Seite,
 * deshalb ist der Innenraum am Boden nur 183.5x125.5.
 *
 * Die Fachteiler müssen entlang der Außenseiten offen bleiben
 * um nicht mit ihren senkrechten Außenwänden durch die
 * Grundschale durchzustechen.
 * Trotzdem bleibt noch das Problem mit den senkrecht
 * auftreffenden Wänden.
 *
 * Damit sie nicht in Bodennähe durchstechen wird an den
 * Außenwänden noch ein Rand von jeweils 1mm vorgesehen,
 * es ergibt sich das kalkulatorische Innenmaß von 184x126 bei
 * einer kalkulatorischen Wandstärke von 2.5mm.
 *
 */
module Box250_50() {
    // Koordinaten der einzelnen Teilfächer.
    // Orientierung des Kastens: Räder links

    // Horizontal:
    dx1=43;//189-2*1.5-dx3-dx4-2*1;  // Breite linker Rand
    dx2=46;         // Breite mittlere Fachreihe
    dx3=76;         // Breite Fach Baustein30
    dx4=63;         // Breite Kleinkramfach

    x1=1.5+1;       // linker Rand Innenraum oben, 1mm padding für Schräge
    x2=x1+dx1+1;    // Beginn mittlere Fachreihe
    x3=x2+dx2+1;    // Beginn Grundplatte
    x4=x2+dx3+1;    // Beginn Kleinkramfach
    x5=x4+dx4;      // kalk. rechter Rand Innenraum

    // Vertikal:
    dy1=31.5;       // Innenmaß Kleinkramfach/Baustein30
    dy2=31.5;       // Innenmaß Baustein15
    dy3=16;         // Innenmaß Winkelstein30
    dy4=16;         // Innenmaß Winkelstein60
    dy5=18.5;       // Innenmaß Seiltrommel
    dy6=7.5;        // Innenmaß Seilrolle

    y1=1.5+1;       // unterer Rand Innenraum, 1mm padding für Schräge
    y2=y1+dy1+1;    // Beginn Baustein15/Grundplatte
    y3=y2+dy2+1;    // Beginn Winkelstein30
    y4=y3+dy3+1;    // Beginn Winkelstein60
    y5=y4+dy4+1;    // Beginn Seiltrommel
    y6=y5+dy5+1;    // Beginn Seilrolle
    y7=y6+dy6;      // kalk. oberer Rand Innenraum

    Box250();
    // Kleinkramfach
    translate([x4,y1,1.4])
        compartment(dx=dx4,dy=dy1,d=1,h=33+0.1,open=[0,1,1,0]);

    // Grundbausteine 30
    translate([x2,y1,1.4]) {
        compartment(dx=dx3,dy=dy1,d=1,h=10+0.1);
        translate([7.5,   8,30])
            rotate([180,0,0]) Baustein30viereckloch();
        translate([7.5,23.5,30])
            rotate([180,0,0])Baustein30viereckloch();
        for (i=[1:4]) {
            translate([7.5+15.1*i,   8,30])
                rotate([180,0,0]) Baustein30();
            translate([7.5+15.1*i,23.5,30])
                rotate([180,0,0]) Baustein30();
        };
    };

    // Grundbausteine 15
    translate([x2,y2,1.4]) {
        compartment(dx2,dy=dy2,d=1,h=10+0.1);
        translate([7.5, 8,15+2.8])
            rotate([180,0,0])
                Baustein15_2rz();
        translate([7.5,23.5,15+2.8])
            rotate([180,0,0])
                Baustein15_2z();
        for (i=[1:2]) {
            translate([7.5+15.1*i, 8,15])
                rotate([180,0,0])
                    Baustein15();
            translate([7.5+15.1*i,23.5,15])
                rotate([180,0,0])
                    Baustein15();
        };
    };

    // Winkelstein 30
    translate([x2,y3,1.4]) {
        compartment(dx2,dy=dy3,d=1,h=8+0.1);
        for (i=[0:3]) {
            translate([11.2*i,dy3/2,0])
                // rotate the angular block upright
                rotate([0,105,0]) translate([-7.5,0])
                Winkelstein30();
        };
    };

    // Winkelstein 60, Rollenlager
    translate([x2,y4,1.4]) {
        compartment(31.5,dy=dy4,d=1,h=8+0.1);
        for (i=[0:1]) {
            translate([8+15.5*i,dy4/2,0]) Winkelstein60();
        };

        // Rollenlager
        // Die Stützen sind 3mm hoch, 1mm breit 
        // und 3 bzw. 5mm lang.
        // Abstand vom Rand auch genau 3mm.
        translate([31.5+1+3,0,0])        cube([1,3,3]);
        translate([31.5+1+3,dy4-3,0])    cube([1,3,3]);
        translate([dx2+1-5,dy4/2-0.5,0]) cube([5,1,3]);
        translate([dx2-6,dy4/2,3]) rotate([0,0,90])
            Rollenlager15();
    };

    // Klemmringe und Seiltrommel
    translate([x2,y5,1.4]) {
        // overall box
        compartment(dx2,dy=dy5,d=1,h=8+0.1);

        // two rolls on left and right:
        for (i=[0,dx2-7])
            translate([i,0,0]) {
                compartment(7,dy=dy5,d=1,h=12+0.1);
                translate ([3.5,9.25,9.5])
                    rotate([0,90,0]) KlemmringZ36();
            };
                
        // Seiltrommel 15
        // Halterungen 11b/10h, Freiraum 5mm oben/unten, Abstand ca. 9mm
        translate([dx2/2, dy5/2, 1.4]) {
            for (i=[-4.5,4.5])
                translate([0,i,5])
                    cube([11,1,10],center=true);

            translate([7.5,0,7.5])
                rotate([0,-90,0])
                    Seiltrommel15();
        }
    }

    // 2xSeilrolle 21x7
    translate([x2,y6,1.4]) {
        compartment(dx2,dy=dy6,d=1,h=12+0.1,open=[1]);
        for (i=[1,3]) {
            translate([i*dx2/4,dy6/2,10.6]) rotate([90,0,0]) Seilrolle21x7();
        };
    };

    // Grundplatte + Reifen45
    translate([x3,y2,1.4]) {
        points=[
            [15,-0.1,0],
            [189-2.5-x3-15,-0.1,0],
            [15,131-2.5-y2-7.5,0],
            [189-2.5-x3-16,131-2.5-y2-7.5,0]
        ];
        for (p=points) translate(p) cube([1,7.5+0.1,6+0.1]);

        translate([2,2,6]) {
            Grundplatte90x90();
            for (p=[[22.5,22.5],[22.5,67.5],[67.5,22.5],[67.5,67.5]])
                translate([p[0],p[1],12]) Reifen45();
        }
    };

    // 4xNabe und Rad
    for (i=[0:3]) translate([30,1.5+16+32*i,1.4]) {
        // ring to hold the tire
        difference() {
            cylinder(d=19.5,h=5+0.1);
            cylinder(d=17.5,h=6);
        }
        cylinder(d=4.5,h=5+0.1);
        cylinder(d=3.5,h=15+0.1);
        translate([0,0,3]) Reifen30();
        translate([0,0,14.8]) Nabe();
    }

    // Halter Flachstein30
    // 9mm von links. Innenraum 37x4, Höhe 17
    // U-Profil: 7x7x1, aber Innenbreite eher 4.5?
    // FIXME: Abstände eher geschätzt
    translate([9.5,y1,1.4]) {
        compartment(5,5,d=1,h=17+0.1,open=[1,0,1]);
        translate([0,32,0]) compartment(5,5,d=1,h=17+0.1,open=[0,0,1]);
        translate([2.5,3.5,0.1])
            rotate([90,0,90]) Flachstein30();
    };
    translate([9.5,y7-37,1.4]) {
        compartment(5,5,d=1,h=17+0.1,open=[1]);
        translate([0,32,0]) compartment(5,5,d=1,h=17+0.1,open=[1,0,1]);
        translate([2.5,3.5,0.1])
            rotate([90,0,90]) Flachstein30();
    };

    // Achshalter mit den langen Metallachsen
    translate([2.7,131/2,1.5+16]) rotate([90,0,90]) {
        Achshalter30x60();
        translate([0,10,3.8]) rotate([0,90,0]) Metallachse110();
        translate([0, 5,3.8]) rotate([0,90,0]) Metallachse110();
        translate([0, 0,3.8]) rotate([0,90,0]) Metallachse80();
        translate([0,-5,3.8]) rotate([0,90,0]) Metallachse60();
        translate([-26,-10,3.8]) rotate([0,90,0]) Metallachse50();
        translate([ 26,-10,3.8]) rotate([0,90,0]) Metallachse50();
    }

}




/*
 * Fachunterteilung
 *
 * Größe des Innenraums wird angegeben, die Wände stehen
 * ausserhalb dieses Bereichs.
 *
 * Referenzpunkt: unten links im Innenraum
 *
 * Parameter:
 * - dx: Größe des Innenraums in X-Richtung (Breite)
 * - dy: Größe des Innenraums in Y-Richtung (Tiefe)
 * - d: Wandstärke
 * - h: Höhe
 * - open: vector[4] mit Flags, welche Seiten offen bleiben sollen. Reihenfolge CW: top,right,bottom,left
 */

module compartment(dx=10,dy=10,d=1,h=10,open=[0,0,0,0]) {
    // top
    if (!open[0]) translate([-d,dy,0]) cube([dx+2*d,d,h]);
    // right
    if (!open[1]) translate([dx,-d,0]) cube([d,dy+2*d,h]);
    // bottom
    if (!open[2]) translate([-d,-d,0]) cube([dx+2*d,d,h]);
    // left
    if (!open[3]) translate([-d,-d,0]) cube([d,dy+2*d,h]);
}




// === interne Designelemente ======================

/**
 * Subtraktionskörper für eine Rundnut
 *
 * Ausrichtung: entlang der Z-Achse
 * Referenzpunkt: an der Oberfläche in der Mitte der geplanten Nut
 */
module nut(l=30.1,d=4) {
    cube([3,2,l],center=true);
    translate ([0,-2.1,0]) cylinder(h=l,d=d,center=true);
}

/**
 * Subtraktionskörper für eine Flachnut
 *
 * Ausrichtung: entlang der X-Achse
 * Referenzpunkt: an der Oberfläche in der Mitte der geplanten Nut
 */
module flachnut(l=30.1,d=4) {
    intersection() {
        nut(l=l,d=d);
        cube([5,2.8*2,l],center=true);
    }
}

/**
 * Subtraktionskörper für ein Statik-Loch
 *
 * Der Körper ist parallel zur Z-Achse, symmetrisch um den
 * Ursprung.
 *
 * Parameter:
 * - h: Gesamthöhe des Subtraktionskörpers (von Z=-h/2 bis Z=h/2), Default: 10
 * - b: Breite des Schlitzes. Default 6mm.
 */
module statikloch (h=10, b=6) {
    intersection(){
        cylinder(h=h,d=b,center=true);
        union() {
            cube([b,2.5,h+0.01],center=true);
            cylinder(h=h+0.01,d=4,center=true);
        }
    }
}


/**
 * Subtraktionskörper für den seitlichen Profilschlitz der Grundplatte
 *
 * Bemaßung:
 * - Aufweitung auf volle 4mm: die ersten 5mm (z=0..5)
 * - Innenbohrung d=4mm, l=33mm (z=5..33)
 * - Aufweitung auf volle 3mm: z=5..24.5
 * - Aufweitung des Innenprofils auf 4x5mm: z=24.5..25
 *
 * Ausrichtung: Schlitz entland der Z-Achse
 * Referenzpunkt: mittig an der Aussenseite des Schlitzes
 */
module slot() {
    translate([0,0,-0.1]) { // ensure an overlap of 0.1mm
        cylinder(d=4,h=33.1);
        translate([-2,-3.05,0]) cube([4,6.1,5.1]);
        translate([-1.5,-3.05,0]) cube([3,6.1,25.1-0.5]);
        translate([-2,-2.5,0]) cube([4,5,25.1]);
        // eye candy: tiny depressions along the slot
        translate([-3,-3.05,0]) cube([6,0.1,26.1]);
        translate([-3,2.95,0]) cube([6,0.1,26.1]);
    }
}

/*
 * - h3: Tiefe Innenbohrung 4mm
 * - h2: Tiefe Aufweitung auf 3mm
 * - h1: Tiefe Aufweitung auf 4mm
 */
module slot2(h3=33,h2=24.5,h1=5) {
    translate([0,0,-0.1]) { // ensure an overlap of 0.1mm
        cylinder(d=4,h=h3+0.1);
        translate([-2,-3.05,0]) cube([4,6.1,h1+0.1]);
        translate([-1.5,-3.05,0]) cube([3,6.1,h2+0.1]);
//        translate([-2,-2.5,0]) cube([4,5,h2+0.5+0.1]);
        // eye candy: tiny depressions along the slot
        translate([-3,-3.05,0]) cube([6,0.1,h2+1.6]);
        translate([-3,2.95,0]) cube([6,0.1,h2+1.6]);
    }
}


/**
 * Return a closed path of an arc
 *
 * A list of coordinates is returned that can be used with polygon
 * and linear_extrude:
 *
 * linear_extrude() polygon(points=arc(r1=10,r2=15,start=90,end=270))
 *
 * This is used to cut the curved slot for Drehscheibe60.
 *
 * @parameters:
 * - r1: inner radius of the arc
 * - r2: outer radius of the arc
 * - start: start angle, 0=right (default: 0)
 * - end: end angle (default 360)
 * - $fn: is used to define the number of segments. This is slightly
 *        different from the usual definition of $fn, where it defines
 *        the number of segments for a full circle. For an arc of
 *        less than 360 degrees this results in a higher segment
 *        density.
 *
 * FIXME: problems ahead if start>end
 */
function arc(r1, r2, start=0, end=360) =
    concat(
        [for(a = [start:360/$fn:end]) [r1 * cos(a), r1 * sin(a)]],
        [for(a = [end:-360/$fn:start]) [r2 * cos(a), r2 * sin(a)]],
        [[r1 * cos(start), r1 * sin(start)]]
    );




// Additionselemente
/**
 * triagular post for use as a corner post in the boxes
 *
 * Orientation: along the Z-axis, the triange extents into the first quadrant (pos. X and Y)
 * Reference point: the rectengular corner at the bottom end
 * Parameters:
 *   - w: width of the two equal sides of the triange
 *   - h: height of the post
 *   - center: false: post extents from z=0 to z=h
 *             true: post extents from z=-h/2 to z=h/2
 */
module cornerpost(w=1.5,h=1,center=false)
{
    linear_extrude(height=h,center)
        polygon (points=[[0,0],[0,w],[w,0],[0,0]]);
}

/**
 * Rastnase
 *
 * Ausrichtung: an akt. X/Y Position in pos. Z-Richtung
 * Farbe: immer Dunkelgrau
 */
module rastnase(screwslot=false) {
    color ("DimGray")
    {
        difference () {
        union () {
            translate ([-1,-1,0]) cube(2);

            translate ([0,0,2.1])
            intersection () {
                rotate ([0,90,0]) cylinder(h=4,d=4,center=true);
                rotate ([90,0,0]) cylinder(h=4,d=4,center=true);
                translate ([0,0,-1]) cylinder(h=2,d=10,center=true);
            };
        };

        // den "Schrauben"-Schlitz subtrahieren
        if (screwslot && no_screwslots==false)
        translate ([0,0,2]) rotate ([0,0,45]) cube ([0.5,8,1],center=true);
    };

    };
}

/**
 * Rundnase
 *
 * Ausrichtung: an akt. X/Y Position in pos. Z-Richtung
 * Farbe: immer dunkles Orange
 */
module rundnase() {
    color ("OrangeRed") {
    translate ([-1,-1,0]) cube(2);
    intersection () {
        translate ([0,0,2.1]) sphere(d=4);
        cube (2*2,center=true);
    };
    };
}


// Universeller Grundbaustein
// Referenzpunkt ist die Rastnase, die Bausteinlänge geht entlang der Z-Achse.
// Die Nut (und ggf. das Querloch) entlang Y-Achse
// Parameter:
// color: Default "Silver", sinnvolle Alternativen: "Red", "OrangeRed", "Yellow"
// len: Länge. Default 30.
// rastnasen: Anzahl Rast/Rundnasen. Default 1, möglich: 2
// rundnase: Ob die Nase(n) Rundnasen sein sollen (Default=false)
// querloch: Ob mittig ein Querloch entlang der Y-Achse gebohrt werden soll. Default false.
// viereckloch: Ob das Querloch ein Viereckloch sein soll (Default: true). Ansonsten Old-School Rundloch.
module Grundbaustein(color="Silver",len=30,rastnasen=1,rundnase=false,querloch=false,viereckloch=true) {
    color (color) difference() {
        // der Grundkörper
        translate ([-7.5,-7.5]) cube([15,15,len]);
        // die vier Längsnuten
        for (a=[0:90:270]) {
            rotate ([0,0,a]) {
                translate ([0,7.5,len/2])
                    nut();
                // chamfer the corners
                // a) sides
                translate([-7.6,-7.6,-0.1])
                    cornerpost(w=0.5,h=len+0.2);
                // b) bottom
                translate([7.6,-7.6,-0.1])
                    rotate([0,270,0])
                        cornerpost(w=0.5,h=15.2,center=true);
                // c) top
                translate([-7.6,-7.6,len+0.1])
                    rotate([0,90,0])
                        cornerpost(w=0.5,h=15.2,center=true);
            }
        }
        // ggf. das Querloch
        if (querloch) {
            translate ([0,0,len/2]) rotate ([90,0,0])cylinder(h=16,d=4,center=true);
            if (viereckloch) {
                translate ([0,5.5,len/2]) cube(4.01,center=true);
                translate ([0,-5.5,len/2]) cube(4.01,center=true);
            }
        };
        // ggf. die Quernut mit Vierecklöchern am anderen Ende
        if (rastnasen==1) {
            // Quernut am anderen Ende
            translate ([0,0,len]) rotate ([90,0,0]) nut();
            // die beiden Vierecklöcher am Ende
            translate ([0,5.5,len-2]) cube (4.01,center=true);
            translate ([0,-5.5,len-2]) cube (4.01,center=true);
        }
    }

    // Rast/Rundnase(n) vorne und hinten
    rotate ([180,0,0]) if (rundnase) 
        rundnase();
    else
        rastnase(screwslot=true);
    
    if (rastnasen==2) {
        translate ([0,0,len]) if (rundnase)
            rundnase();
        else
            rastnase(screwslot=true);
    }
    
}


module Bauplatte(color="red",x=2,y=1)
{
    color(color) {
        translate([-7.5,-7.5,0]) {
            cube([x*15,y*15,1]);
        };
        for (j=[0:y-1]) {
           for (i=[0:x-1]) {
                translate([i*15,j*15,0])
                rotate([0,180,0])
                rastnase();
            };
        };
    };
}


/**
  * Referenzpunkt: Mittelpunkt, Oberfläche der Innen/Flachseite
  *
  * FIXME: Griff müsste abgerundet sein
  * FIXME: Unterseite ist nicht modelliert
  *
  * Größen:
  *   - Höhe 8.7mm
  *   - Durchmesser 25.5mm
  *   - Dicke der unteren Scheibe: 2.2mm
  * Referenzpunkt: Mittelpunkt, Oberfläche der Innen/Flachseite
  */
module Nabenoberteil(d1=6.6) {
    color("Red") union() {
    rotate_extrude(convexity = 10)
    polygon( points=[
        // top side profile:
        // 8.7mm thick, 
        // d=6.6mm inner hole,
        // flange: d=11mm top side, d=14mm low side
        // lower flange: d=25.5mm outer diameter, 2.2mm thick
        [d1/2,8.7],[5.5,8.7],[7,2.2],[12.75,2.2],
        // outer side profile:
        // bottom side profile:
        [12.75,0],[d1/2,0],[d1/2,8.7]
    ] );
    translate ([5.5,-1,0]) cube([7,2,8.6]);
    translate ([-12.5,-1,0]) cube([7,2,8.6]);
    }
}

/*
 * Größen: Höhe=8.7-2.2+12.75=18.25mm
 * Referenzpunkt: Mittelpunkt, Oberfläche der Innen/Flachseite die am Reifen anliegen wird.
 */
module Nabenunterteil() {
    translate([0,0,-2.2]) Flachnabenunterteil();
    rotate([180,0,0]) Nabenoberteil(d1=4);
}


/**
 *
 * Größen: d=25.5mm, Höhe 12.75mm
 * Referenzpunkt: Mitte Unterseite
 */
module Flachnabenunterteil() {
    color("Red")
    difference() {
        union() {
            cylinder(d=25.5,h=2.21);
            translate([0,0,2.2]) cylinder(d=20,h=2.56);
            translate([0,0,4.75]) cylinder(d=9.5,h=3.01);
            translate([0,0,7.75]) cylinder(d1=8,d2=6.5,h=5);
        }
        // cut the slots
        translate([-5,-0.25,4.75]) cube([10,0.5,10]);
        translate([-0.5,-3,4.75]) cube([1,6,10]);
        // cut the center bore
        cylinder(d=4,h=30,center=true);
    }
}


/*
 * facettierte Achse
 *
 * - entlang der Z-Achse
 * - Facetten an den Enden 45°, je 0.5mm
 * - keine vorgegebene Farbe
 *
 * Referenzpunkt: mittig in der Achse
 */
module achse(l=30) {
    // main part
    cylinder(d=4,h=l-1,center=true);
    // top facet
    translate([0,0,(l-1)/2-0.01]) cylinder(d1=4,d2=3,h=0.5);
    // bottom facet
    translate([0,0,-(l-1)/2-0.5+0.01]) cylinder(d1=3,d2=4,h=0.5);
}


/**
 * inner teeth used to hold the tires or gears on the hub part
 *
 * Default ist eine Gruppe von 6 Zähnen über 90°.
 * Für einen vollständigen Reifen 30 werden drei Gruppen mit
 * je 120° Versatz gebraucht:
 *
        // add the inner teeth
        reifenzaehne();
        rotate([0,0,120]) reifenzaehne();
        rotate([0,0,240]) reifenzaehne();
 *
 * Ein voller Zahnkreis: reifenzaehne(360);
 *
 * Parameter:
 * - angle: Winkel, der mit Zähnen gefüllt werden soll. Default 90. Sollte immer ein vielfaches von 15° sein.
 */
module reifenzaehne(angle=90) {
    difference() {
        rotate_extrude(angle=angle) polygon(points=[[10,0.75],[11.5,0.75],[11.5,-0.75],[10,-0.75],[10,0.75]]);
        for (a=[0:15:angle]) {
            rotate([0,0,a]) translate([10,0,0]) cylinder(d=2,h=1.6,center=true);
        }
    };
}


/**
 * universeller Winkelstein
 *
 * Referenzpunkt: mittig auf der Seite mit der Flachnut
 *
 * Geometrie: Segment eines Kreisbogens mit Radius r.
 * Typische Werte: Winkelstein30: r=15, Winkelstein15: r=22.5
 *
 * Die Rastnase und die Flachnut liegen genau auf diesem Radius.
 *
 * Parameter:
 *   - r: Radius des Kreisbogens entlang der Rastnase.
 *   - a: Winkel
 */
module winkelstein(r,a) {
    color("red") {
        difference() {
            translate([-r,0]) {
                rotate([90,0,0]) rotate_extrude(angle=a,$fn=2)
                    translate ([r,0]) square(15,center=true);
                rotate([0,-a,0]) translate([r,0]) rastnase();
            }
            rotate([-90,0,0]) flachnut();
        }
    };
}


/**
 * universal building block for Verbinder parts
 *
 * The part can be fully round on both sides or flattend on the right side
 *
 * @parameters:
 * - len: length in mm, default 15
 * - cut: 0=fully round on both sides (total width=7.8mm)
 *        1=cut on the right side to 2.6mm (total width 6.5mm)
 *
 * orientation:
 * - length along the z-axis
 * - the round side on the negative x-side (left)
 * - the flattend side on the positive x-side (right)
 *
 * reference point: the part stands upright along the z-axis on the
 * reference point, centered on the middle of the central core part.
 *
 */

module verbinder(len=15,cut=1) {
    linear_extrude(len){
        difference(){
            // the main body: Two circles d=4, distance 4mm
            // plus the center piece, 3mm wide
            union(){
                translate([-2,0]) circle(r=2);
                translate([ 2,0]) circle(r=2);
                square(3,center=true);
            }
            // the two small slots
            translate([-3,0]) square([4,1],center=true);
            translate([ 3,0]) square([4,1],center=true);
            // shorten one side
            if (cut) translate([ 2.6,-2]) square(4);
        }
    }
}




/**
 * The embossed company logo (for eye candy)
 *
 * The logo raises 1mm above the reference plane.
 *
 * Reference point: X/Y center of the logo, on the back side.
 * Parameters:
 * h: logo height (default: 3mm)
 */
module logo(h=3) {
    linear_extrude(1)
        text("MM",size=h,halign="center",valign="center");
}


/**
 * universelle Stapelbox
 *
 * topx, topy, h: außen oben 189x130x40 (sollte eigentlich 131 sein?)
 * dw: außen unten 2.5mm weniger: 186.5x127.5
 * innen unten 2x1.5mm weniger: 183.5x124.5x38.5 (nutzbar 33mm)
 *
 * Nutzbare Innenhöhe 33mm, wenn der Deckelbereich freigehalten
 * werden soll.
 *
 * Außenmaß unten 128.5, oben 130.5 => stapelbar
 * rim: Deckelaussparung 5.5mm hoch
 * d: Wandstärke 1.5mm
 * d1: Wandstärke im Bereich der Deckelaussparung 1mm
 * r: Eckenradius außen 2mm
 * c: Eckverstärkungen (Eckpfosten) 1.5x1.5mm
 *
 * Wandstärke der Fachteiler 1mm
 */
module stapelbox(topx=189,topy=131,h=40) {
//    topx=189;       // outer width at the top
//    topy=131;       // outer depth at the top
//    h=40;           // total height
    r=2.0;          // outer corner radius
    d=1.5;          // wall thickness
    d1=1.0;         // wall thickness for the upper part
    rim=5.5;        // height of the thinner upper part
    dw=1.25;        // inward distance on each side at the bottom
    r1=r-(d-d1);    // inner corner radius for the upper part
    c=1.5;          // chamfer size for the inner corners
                    // (distance on each side of the corner)

    // Array with the coordinates of the bottom corners
            // rounded corners at the bottom
            // in order to be stapelable, the botton needs to be
            // smaller than the top by the top wall thickness d1
    bottom_points = [
            [         dw,         dw,0],
            [topx-2*r-dw,         dw,0],
            [topx-2*r-dw,topy-2*r-dw,0],
            [         dw,topy-2*r-dw,0]
    ];

    // Array with the coordinates of the top corners
            // rounded corners at the top
            // The top 1mm is straight. This could be changed.
    top_points = [
            [       0,       0,h-r-rim],
            [topx-2*r,       0,h-r-rim],
            [topx-2*r,topy-2*r,h-r-rim],
            [       0,topy-2*r,h-r-rim]
    ];

    // size difference from [topx,topy] and height for
    // defining the inner volume
    // The top plane is smaller only by the wall thickness and
    // the chamfer size (because the offset() command is used),
    // the bottom plane is even smaller by the amount of dw on
    // every side.
    inner_volume = [
            [d+2*c,   d+2*c,    h],     // top plane
            [d+dw+2*c,d+dw+2*c, d]      // bottom plane
    ];

    color("Silver")
    difference() {
        // the main box body with round corners
        translate([r,r,r]) hull() {
            // rounded corners at the bottom
            for (p=bottom_points) translate(p) sphere(r);
            // rounded corners at the top
            // The rim part is straight. This could be changed
            // by using sphere() instead of cylinder.
            for (p=top_points) translate(p) cylinder(r=r,h=rim);
        };
        // now cut off the top half of the top rounding
//        translate([0,0,h]) cube([topx,topy,r+1]);

        // subtract the inner volume
        hull() {
            // v2: use the values from an array
            // two planes define the volume, offset() is used
            // to chamfer the corners. Make sure to handle the
            // resulting increased size.
            for (p=inner_volume)
                translate(p)
                    linear_extrude(1)
                        offset(delta=2*c,chamfer=true)
                            square(size=[topx,topy]-2*p);
        };

        // remove even more for the step at the top of the box
        // rounded inner corners with constant wall thickness
        translate([topx/2,topy/2,h-5.5])
            linear_extrude(6)
                offset(r=r1)
                    square(size=[
                        topx-2*d1-2*r1,
                        topy-2*d1-2*r1],center=true
                    );
    };
}


// === Testdarstellung ==============================

// div. Designelemente
// Subtraktionskörper für Nuten
nut();
translate ([6,0,0]) flachnut();
translate ([12,0,0]) statikloch();

// Rast- und Rundnase
translate ([0,-6,0]) rastnase();
translate ([6,-6,0]) rundnase();


// 30er Grundbaustein
translate ([0,-20,0]) Baustein30();
translate ([20,-20,0]) Baustein30rundloch();
translate ([40,-20,0]) Baustein30viereckloch();

// 15er mit Rastnase
translate ([0,-40,0]) Baustein15();
translate ([20,-40,0]) Baustein15_2z();

// 15er mit Rundnase
translate ([0,-60,0]) Baustein15rz();
translate ([20,-60,0]) Baustein15_2rz();

// Bauplatten
translate ([0,-80,0]) Bauplatte(color="red",x=2,y=1);
translate ([0,-100,0]) Bauplatte(color="red",x=3,y=1);
translate ([0,-140,0]) Bauplatte(color="red",x=4,y=2);

translate ([0,-160,0]) Baustein5();
translate ([20,-160,0]) Baustein7();
translate ([40,-160,0]) Rollenlager15();
translate ([60,-160,0]) Winkelstein60();
translate ([80,-160,0]) Winkelstein30();
translate ([100,-160,0]) Winkelstein15();
translate ([120,-160,0]) Winkelstein7();

translate ([0,-200,0]) Flachstein30();
translate ([40,-200,0]) Seilhaken30();

translate ([0,-220,0]) Seilrolle21x7();
translate ([30,-220,0]) Nabenoberteil();
translate ([60,-220,0]) Nabenunterteil();
translate ([90,-220,0]) Flachnabenunterteil();

translate ([0,-250,0]) Nabe();
translate ([30,-250,0]) Flachnabe();
translate ([60,-250,0]) Reifen30();
translate ([90,-250,0]) {Nabe(); Reifen30();}
translate ([130,-250,0]) Reifen45();

translate ([0,-280,0]) Handkurbel();
translate ([40,-280,0]) {
    Nabe();
    translate([0,0,3.3]) Handkurbel();
}

translate ([0,-310,0]) Klemmbuchse10();
translate ([10,-310,0]) Klemmbuchse5();
translate ([20,-310,0]) Klemmkupplung20();

translate ([0,-320,0]) Metallachse30();
translate ([10,-320,0]) Metallachse50();
translate ([20,-320,0]) Metallachse60();
translate ([30,-320,0]) Metallachse80();
translate ([40,-320,0]) Metallachse110();
translate ([80,-310,0]) Achshalter30x60();

translate ([0,-420,0]) Grundplatte90x90();

translate ([0,-440,0]) KlemmringZ36();
translate ([20,-440,0]) Seiltrommel15();
translate ([40,-440,0]) Riegelscheibe();

translate ([0,-460,0]) Verbinder15();
translate ([10,-460,0]) Verbinder30();
translate ([20,-460,0]) Verbinder30round();
translate ([30,-460,0]) Verbinder45();
translate ([40,-460,0]) Verbinder45round();
translate ([50,-460,0]) Verbinder1530();

translate ([0,20,0]) {
//    spur_gear(modul=1.5,tooth_number=20, width=6, bore=20);
//    spur_gear(modul=0.5,tooth_number=20, width=2, bore=4);
    linear_extrude(6) gear(number_of_teeth=20,diametral_pitch=1/1.5,verbose=true);
}

translate ([0,-500,0]) Drehscheibe60();
*union(){   // activate this with '!' for plotting a dxf file
    projection(cut=true) Drehscheibe60();
    translate([70, 0]) projection(cut=false) Drehscheibe60();
    translate([ 0,40]) projection(cut=true) rotate([90,0,0]) Drehscheibe60();
}

// -------
translate ([-250,0,0]) Box250();
*union(){   // activate this with '!' for plotting a dxf file
    // bottom of the inside space of the box
    projection(cut=true) translate([0,0,-1.5]) Box250();
    // y-z plane: cut across the short side of the box
    projection(cut=true)
        translate([200,0,50]) rotate([0,90,0]) Box250();
    // cut across the long side of the box
    projection(cut=true)
        translate([0,150,50]) rotate([-90,0,0]) Box250();
}

translate ([-250,-150,0]) Box250_50();

translate ([-280,-150,0]) rotate([0,0,90]) Box500();
