## Eigene Teile, Bemassung etc.

Loch in der Statik-Strebe: ftpedia 1/2015:78
Bei den neuen Streben (ab 80er Jahre) Senkung auf beiden Seiten
- Gesamt-Dicke 2.8mm, Senkung jeweils 0.8mm, Restmaterial 1.2mm
- Schlitzbreite 3mm
- Durchmesser Innenloch 4mm, Innensenkung 6.4mm

Nutprofil (ftp 1/16:9)
- Die Nut ist kreisförmig, Durchmesser 4mm, 0.1mm versenkt (Mittelpunkt
  2.1mm unter der Oberfläche)
- an der Oberfläche zum 3mm Schlitz aufgeweitet
- halbrunde Nut ist 2.8mm tief (0.7mm hinter Mittelpunkt abgeschnitten)
- Der Nutdurchmesser ist in der Praxis aber oft etwas mehr als 4mm

https://forum.ftcommunity.de/viewtopic.php?t=3709


## Längen S-Streben:

I Raster 15
15 30 45 60 75 90 120 (1 2 3 4 5 6 8)
X Raster 21.2
42.4 63.6 84.8 106 127.2 169.6 (2 3 4 5 6 8)
L Raster 15
30 45 60 75 90 105 120 (2 3 4 5 6 7 8)
Sondertyp 74L



## andere Libraries und Teile

https://github.com/revarbat/BOSL2/wiki/Topics
Große Library mit Zusatzfunktionen z.B. für Assemblies. Teile können als
Attachments aneinander montiert und gemeinsam bewegt werden, bleiben aber
trotzdem unabhängig.


https://github.com/Karijn/FisherParts
Sehr flexible Definition von eigenen Teilen. Die Standard-Blöcke sind dann
nur vordefinierte Spezialfälle. Die Statikstreben scheinen auch enthalten zu
sein. Wird hier verwendet: https://www.youmagine.com/designs/fischertechnik-glider

https://www.thingiverse.com/thing:4368642/files
Beeb-Bot: Ein Roboter. Hier werden alle enthaltenen Teile definiert, incl.
Grundbaustein 30, Baustein 5, Baustein 7.5 etc.


## Fischer-Logo

Radius r
Dicke des Fischs = 2a
vert. Wert des Schnittpunkts r-a
Länge des Fischkörpers = 2dx
dx^2+(r-a)^2=r^2
r2-2ar+a2+dx2-r2= 0 = a2+dx2-2ar
Länge der hinteren Fischhäfte incl. Schwanz = b
b2+(r-2a)^2=r2
b2+r2-4ar+4a2= r2 = a2+dx2-2ar


## Tipp und Design-Stragien

https://hackaday.com/2018/02/13/openscad-tieing-it-together-with-hull/
Lochplatten ganz fix definiert:
points = [ [0,0,0], [10,0,0], [0,10,0], [10,10,0] ];
module cylinders(points, diameter, thickness){
    for (p=points){
        translate(p) cylinder(d=diameter, h=thickness, center=true);
    }
}
 
module plate(points, diameter, thickness, hole_diameter){
    difference(){
        hull() cylinders(points, diameter, thickness);
        cylinders(points, hole_diameter, thickness+1);
    }
}
 
module bar(length, width, thickness, hole_diameter){
    plate([[0,0,0], [length,0,0]], width, thickness, hole_diameter);
}

