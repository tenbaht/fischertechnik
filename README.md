<!-- banner: can be a image or a large font-->
<h1 align="center" style="font-weight: bold; margin-top: 20px; margin-bottom: 20px;">fischertechnik</h1>

<!-- blurb: shortest possible summary (one line max) -->
<h3 align="center" style="font-weight: bold; margin-top: 20px; margin-bottom: 20px;">A library of Fischertechnik-Parts as OpenSCAD definitions.</h3>


<!-- badges: meaningful meta information (one line max), do NOT include anything immediately visible -->
<p align="center">
	<a href="#changelog"><img
		src="https://img.shields.io/github/release-pre/tenbaht/fischertechnik.svg"
		alt="release: NA"></a>
	<a href="https://openscad.org"><img
		src="https://img.shields.io/badge/OpenSCAD-2019.05-blue.svg"
		alt="OpenSCAD: 2019.05"></a>
	<a href="https://github.com/openscad/MCAD"><img
		src="https://img.shields.io/badge/MCAD-2019.05-blue.svg"
		alt="MCAD: 2019.05"></a>
	<a href="#status"><img
		src="https://img.shields.io/badge/status-research-violet.svg"
		alt="status: research"></a>
	<a href="https://github.com/tenbaht/fischertechnik/issues"><img
		src="https://img.shields.io/github/issues/tenbaht/fischertechnik.svg"
		alt="issues: NA"></a>
	<a href="#license"><img
		src="https://img.shields.io/github/license/tenbaht/fischertechnik.svg"
		alt="license: NA"></a>
</p>


<!-- quick links: local links (one line max) -->
<!-- Link to the (most important) h2 chapters, but do NOT link to anything visible without scrolling -->
<p align="center">
  <a href="#getting-started">Getting Started</a> •
  <a href="#about">About</a> •
  <a href="#credits-and-references">Credits</a>
</p>

<!-- separate h2 chapters with white space: <br> -->
<br>

## Introduction

This is a collection of digital models of the classic Fischertechnik parts
for OpenSCAD.
Aside from generating renderings of parts or builds under an open licence it
can be used to design special parts for 3D-printing at home. This is useful
for attaching non-Fischertechnik-Hardware like motors, servos or sensors.



<br>

### Key Features
 - **size accurancy:** All parts are measured exactly and the models reflect
   the geometry well
 - **eye candy:** in some cases even non-functional details are implemented
   to improve the overall look
 - **no difficult dependencies:** this library is written in plain vanilla
   OpenSCAD. Only the involute gears require the MCAD library. Being the
   OpenSCAD-"standard library" it is already part of almost every OpenSCAD
   installation.


<br>

### Usage Example

The file `example/filled_boxes.scad` contains filled boxes of the 1975 edition
(small boxes) of the classic
[Grundkasten 50](https://ft-datenbank.de/ft-article/1971) and
[Grundkasten 50/1](https://ft-datenbank.de/ft-article/1972).

The sorting boxes are fully modeled and all parts contained in the real
boxes are neatly sorted into their places according to the original packing
plan.

It should be possible to use these models for printing fully functional
replica of these boxes. Doing so wouldn't be meaningful though, as used
boxes in good condition sell so frequently and so cheaply.





<br>

## Getting Started

- Clone or download the repository
- Start OpenSCAD and open the file `fischertechnik.scad` or
  `example/filled_boxes.scad` from this repository
- Press F5 to render it into a quick preview.



<br>


## Under the Hood (Internals)

### Eigene Teile, Bemassung etc.

Loch in der Statik-Strebe:
[ft:pedia 1/2015:78](https://www.ftcommunity.de/ftpedia/2015/2015-1/ftpedia-2015-1.pdf)
Bei den neuen Streben (ab 80er Jahre) Senkung auf beiden Seiten
- Gesamt-Dicke 2.8mm, Senkung jeweils 0.8mm, Restmaterial 1.2mm
- Schlitzbreite 3mm
- Durchmesser Innenloch 4mm, Innensenkung 6.4mm

Nutprofil
[ft:pedia 1/2016:9](https://www.ftcommunity.de/ftpedia/2016/2016-1/ftpedia-2016-1.pdf)
- Die Nut ist kreisförmig, Durchmesser 4mm, 0.1mm versenkt (Mittelpunkt
  2.1mm unter der Oberfläche)
- an der Oberfläche zum 3mm Schlitz aufgeweitet
- halbrunde Nut ist 2.8mm tief (0.7mm hinter Mittelpunkt abgeschnitten)
- Der Nutdurchmesser ist in der Praxis aber oft etwas mehr als 4mm

https://forum.ftcommunity.de/viewtopic.php?t=3709

<br>

### Längen S-Streben:

I Raster 15
15 30 45 60 75 90 120 (1 2 3 4 5 6 8)
X Raster 21.2
42.4 63.6 84.8 106 127.2 169.6 (2 3 4 5 6 8)
L Raster 15
30 45 60 75 90 105 120 (2 3 4 5 6 7 8)
Sondertyp 74L

<br>


### Fischer-Logo

I didn't implement the Fischer logo and replaced it with my initials "MM"
due to copyright concerns (Better to ask them for permission beforehand)

Radius r
Dicke des Fischs = 2a
vert. Wert des Schnittpunkts r-a
Länge des Fischkörpers = 2dx
dx^2+(r-a)^2=r^2
r2-2ar+a2+dx2-r2= 0 = a2+dx2-2ar
Länge der hinteren Fischhäfte incl. Schwanz = b
b2+(r-2a)^2=r2
b2+r2-4ar+4a2= r2 = a2+dx2-2ar



<br>

### Tipps und Design-Stragien

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



<br>

## About

This library was written mostly as an exercise when learning how to use
OpenSCAD on slightly more complex shapes.


<br>

### Status

I still consider this as a
<img src="https://img.shields.io/badge/status-research-violet.svg"
alt="status: research"> project.

Even basic API properties like the module names or the number of parameters
might change suddenly. If you happen to use it for anything else than
learing about OpenSCAD please make sure to reference a specific version or
a commit.

Being of practial use was not the first design priority, but eventually it
evolved well into this direction.


<br>

### Known Issues

- Only the basic blocks Baustein 30 and Baustein 15 use facetts, all others
  have unbroken corners.
- The measurements don't account for production tolerances. Both, the slots
  and the locking pieces, are designed with diameter=4mm. This wouldn't fit
  in reality.

### Parts that could be improved

(But most likely never will):

- Reifen 45: The "teeth" don't have the right shape at the edges.
- Reifen 60: Only a rough estimate
- KlemmringZ36: The inside is only a very rough estimate

These models are good enough for my purposes, but pull requests are welcome.


<br>

### Planned Features, Roadmap

I will add more parts as they are contained in these boxes:

- I am working on [Aufbaukasten Statik 50S, edition
  1975 (small box, 30150)](https://ft-datenbank.de/ft-article/4124) now
- Next would be [Statik 50S/1 (30160)](https://ft-datenbank.de/ft-article/4125)
- maybe [50/2, edition 1975 (30141)](https://ft-datenbank.de/ft-article/1973)
- maybe the whole 50-1977 series in the big box
- maybe Hobby1/2/3/S and u-t1/2/3/S 1970 or 1982/CVK edition.

But don't hold your breath. We will see when (and if at all) it will happen.


<br>


### Changelog

This project is going to follow the basic ideas of the [semantic versioning
scheme](https://semver.org/). It still is (and probably will ever stay) at
the development stage with 0.x.x version numbers and possible bigger API
changes even for minor version increments.

v0.2.0
- add parts for box 50/1-1975
- separate the definitions for the filled boxes into the examples directory
- add some drawings as dxf for some more complex parts

v0.1.0
- initial release with most parts for box 50-1975


<br>

## Credits and References

The part names and the numbering scheme refer to the
[Fischertechnik-Datenbank](https://ft-datenbank.de/). Usually the original
german names are used for the parts, because I am not aware of a consistant
set of english translations.

This README is (starting to be) based on the
[git-template](https://github.com/nqtronix/git-template) by nqtronix.


<br>

### other libraries and parts

**good overview of OpenSCAD libraries**:
https://stackoverflow.com/questions/60562858/best-libraries-for-openscad

**MCAD**:
Ist immer mit enthalten, am ehesten eine Art von Standard-Lib.

[BOSL v1](https://github.com/revarbat/BOSL):
Das Original. Seit 2019 kaum noch weiterentwickelt, sie konzentrieren sich
auf BOLT2. Rendert aber sehr viel schneller als die v2.

[BOSL v2](https://github.com/revarbat/BOSL2/wiki/Topics):
Große Library mit Zusatzfunktionen z.B. für Assemblies. Teile können als
Attachments aneinander montiert und gemeinsam bewegt werden, bleiben aber
trotzdem unabhängig.
Noch Beta-Status. Funktioniert nur beinahe mit openscad 2019.05, da
teilweise die neue "^" Syntax anstelle der alten pow() Funktion verwendet
wird. Ist aber leicht anzupassen.


[FisherParts by Karijn](https://github.com/Karijn/FisherParts):
Sehr flexible Definition von eigenen Teilen. Die Standard-Blöcke sind dann
nur vordefinierte Spezialfälle. Die Statikstreben scheinen auch enthalten zu
sein. Wird hier verwendet: https://www.youmagine.com/designs/fischertechnik-glider

[Beeb-Bot](https://www.thingiverse.com/thing:4368642/files):
Ein Roboter. Hier werden alle enthaltenen Teile definiert, incl.
Grundbaustein 30, Baustein 5, Baustein 7.5 etc.



<br>

## Licence

This project uses the [MIT licence](https://opensource.org/licenses/MIT): Do
whatever you like with the code, but don't forget to mention the original
source.
