$fn=30;

// Subtraktionskörper für eine Rundnut
// entlang der Z-Achse
// Referenzpunkt ist an der Oberfläche in der Mitte der geplanten Nut
module nut(l=30.1,d=4) {
    cube([3,2,l],center=true);
    translate ([0,-2.1,0]) cylinder(h=l,d=d,center=true);
}

// Subtraktionskörper für eine Flachnut
// entlang der X-Achse
// Referenzpunkt ist an der Oberfläche in der Mitte der geplanten Nut
module flachnut(l=30.1,d=4) {
    intersection() {
        nut(l=l,d=d);
        cube([5,2.8*2,l],center=true);
    }
}

module rastnase() {
    color ("DimGray") {
    translate ([-1,-1,0]) cube(2);
    intersection () {
        translate ([0,0,2.1]) sphere(d=4);
        cube (2.8*2,center=true);
    };
    };
}

module rundnase() {
    color ("OrangeRed") {
    translate ([-1,-1,0]) cube(2);
    intersection () {
        translate ([0,0,2.1]) sphere(d=4);
        cube (2.8*2,center=true);
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
            rotate ([0,0,a])
                translate ([0,7.5,len/2])
                    nut();
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
    rotate ([180,0,0]) rastnase();
    if (rastnasen==2) {
        translate ([0,0,len]) rastnase();
    }
    
}

module Baustein30(color="Silver") {
    Grundbaustein(color=color);
}

module Baustein30viereckloch(color="Silver") {
    Grundbaustein(color=color, querloch=true,viereckloch=true);
}

module Baustein30rundloch(color="Silver") {
    Grundbaustein(color=color, querloch=true,viereckloch=false);
}

module Baustein15(color="Silver") {
    Grundbaustein(len=15,color=color);
}

module Baustein15_2z(color="Silver") {
    Grundbaustein(len=15,rastnasen=2,color=color);
}

module Baustein15rz(color="Silver") {
    Grundbaustein(len=15,rundnase=true,color=color);
}

module Baustein15_2rz(color="Silver") {
    Grundbaustein(len=15,rastnasen=2,rundnase=true,color=color);
}


// Testaufrufe
nut();
translate ([0,-6,0]) flachnut();
translate ([6,-6,0]) rastnase();

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
