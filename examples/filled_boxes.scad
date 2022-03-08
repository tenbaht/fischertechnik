use <../fischertechnik.scad>

/* === filled boxes =========================================== */

/*
 * 1967: 30050 Grundkasten 50 (1967)
 * 1975: 30120 Grundkasten 50
 *
 * The classic Grundkasten 50 in the small box, version 1975.
 *
 * The parts list is identical with the 1967 version, only the
 * packaging is improved.
 * Please note that the content of this box is fundamentally
 * different from the later 1977 version in the big box.
 *
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
    translate([189/2,131/2,1.49]) linear_extrude(0.5)
        text("50",8,halign="center",valign="center");

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


eps=0.01;    // used for overlapping parts


/**
 * 1975: 30140 Grundkasten 50-1
 *
 * The classic Grundkasten 50/1 in the small box, version 1975.
 *
 * Often sold together with Grundkasten 50 in a double set as
 * Grundkasten 100.
 */
module Box250_50_1() {
    Box250();
    translate([189/2,131/2,1.5-eps]) linear_extrude(0.5)
        text("50/1",8,halign="center",valign="center");

    translate([2.75,2.75,1.5-eps]) {
        // now the zero point is in the lower left corner of the inner
        // space of the box.
        // available space: 183.5x125.5x38.5

        // the upper row of compartements
        // available space inside: 183.5x30.5
        h1=31;
        translate([0,125.5-h1,0]) {
            // two block30: 15.5x31
            translate([0,0,0]) {
                compartment(15.5,h1,open=[1,0,0,1]);
                for (y=[8,23])
                    translate([7.75, y,30])
                        rotate([180,0,0])
                            Baustein30();
            }
            // four block15: 30.5x31
            translate([15.5+1,0,0]) {
                compartment(30.5,h1,open=[1]);
                for (x=[7.6,22.7], y=[8,23])
                    translate([x,y,15])
                        rotate([180,0,0])
                            Baustein15();
            }
            // Seilrolle: 22x7.5
            translate([15.5+1+30.5+1,0,0]) {
                compartment(24,7.5);
                translate([24/2,7/2,10.5])
                    rotate([90,0,0])
                        Seilrolle21x7();
            }
            // 4xFlachstein30: 36x17
            translate([48+2.5,h1-17,0]) {
                compartment(36,17,open=[1]);
                for (y=[2.2:4.2:16])
                     translate([3,y,0])
                        rotate([90,0,0])
                            Flachstein30();
            }

            // starting on the right side now at x=183.5
//        w=[60.5,15.5,15.5];
//        for (i=w
            // box for small pieces: 60.5x31, height 33mm
            // oversize to box by 0.3mm to the top and right to ensure
            // a proper overlap with the box side walls even at the top
            translate([183.5-60.5,0,0]) {
                compartment(60.5+0.3,31+0.3,h=33,open=[1,1]);
            }
            // two block30 with holes: 15.5x31
            translate([183.5-60.5-1-15.5,0,0]) {
                compartment(15.5,h1,open=[1]);
                for (y=[8,23])
                    translate([7.75, y,30])
                        rotate([180,0,0])
                            Baustein30viereckloch();
            }
            // two block15 2z: 15.5x31 with supports
            // supports: height=3mm, width=1mm, distance=8mm
            translate([183.5-60.5-1-15.5-1-15.5,0,0]) {
                compartment(15.5,h1,open=[1]);        // box
                translate([(15.5-8)/2,0,0])             // supports
                    compartment(8,h1,h=3,open=[1,0,1]);
                for (y=[8,23])
                    translate([7.75, y,15+3])
                        rotate([180,0,0])
                            Baustein15_2z();
            }
        }

        // Grundplatte90x180:
        // remaining vertical space: 125.5mm-h1-1mm = 93.5mm
        // horizontal space: 183.5mm
        // => total of 3.5mm space to the sides,
        // 1.75mm on each of the four sides.
        sx = (183.5-180)/2;     // space in x-direction on each side
        sy = (125.5-h1-1-90)/2; // space in y-direction on each side
        translate([sx,sy,0]) {
            // Grundplatte90x180 mit Haltern
            translate([0,0,6+eps]) Grundplatte90x180();
            linear_extrude(6+eps) {
                // the supports are 1x8mm, but a square 1x9mm
                // is used to ensure a proper overlap into the
                // side walls. To offset for this oversize, the
                // position is shifted by 0.5mm in y direction.
                for (x=[15,165],y=[8/2-sy-0.5,90-8/2+sy+0.5])
                    translate([x,y])
                        square([1,9],center=true);
            }
            // stacking support and holder for the Metallachse 170
            // width 1.5mm
            // height: axis support 17.5mm, front 21.5mm, stacking 33mm
            for (x=[22.5-1.5/2,180-22.5-1.5/2]) {
                // base: axis support 1.5x10, height=17.5
                translate([x,-sy,0]) cube([1.5,10,17.5]);
                // axis holder: 1.5x5, height=21.5
                translate([x,5-sy,0]) cube([1.5,5,21.5]);
                // stacking support: 1.5x1+1.3
                translate([x,-1.3-sy,0]) cube([1.5,1+1.3,33]);
            }
            // put the metal axis into the holder
            translate([90,3-sy,19.5])
                rotate([0,90,0])
                    Metallachse170();

            // Drehscheibe with Flachnabe in the middle
            translate([90,45,6+5.5+6/2]) {
                Flachnabe();
                Drehscheibe60();
            }
            // Reifen60 with Flachnabe to the left
            translate([30,45,6+5.5+21/2]) {
                Flachnabe();
                Reifen60();
            }
            // Reifen60 with Flachnabe to the left
            translate([150,45,6+5.5+21/2]) {
                Nabe();
                Reifen60();
            }
        }
    }
}


/* === helper functions =========================================== */

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
    color("Silver") {
        // top
        if (!open[0]) translate([-d,dy,0]) cube([dx+2*d,d,h]);
        // right
        if (!open[1]) translate([dx,-d,0]) cube([d,dy+2*d,h]);
        // bottom
        if (!open[2]) translate([-d,-d,0]) cube([dx+2*d,d,h]);
        // left
        if (!open[3]) translate([-d,-d,0]) cube([d,dy+2*d,h]);
    }
}


/* === show off the examples ====================================== */

Box250_50();
translate ([0,150,0]) Box250_50_1();
