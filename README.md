# <lasercut.scad>
Module for openscad, allowing 3d models to be created from 2d lasercut parts, with a flat file automatically generated.

Updated, not just lasercut can now pass the parameter milling_bit for CNC machines, for the bit to cut in to the corners. 

## Basic usage

To prepare a simple rectangle use lasercutoutSquare()
```
include <lasercut.scad>; 

thickness = 3.1;
x = 50;
y = 100;
lasercutoutSquare(thickness=thickness, x=x, y=y);
```
![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-001.png)

More complex path using the lasercutout()
```
include <lasercut.scad>; 

thickness = 3.1;
x = 50;
y = 100;
points = [[0,0], [x,0], [x,y], [x/2,y], [x/2,y/2], [0,y/2], [0,0]];
lasercutout(thickness=thickness, points = points);
```
![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-002.png)

## Simple Tab
```
include <lasercut.scad>; 

thickness = 3.1;
x = 50;
y = 100;
lasercutoutSquare(thickness=thickness, x=x, y=y,
    simple_tabs=[
            [UP, x/2, y],
            [DOWN, x/2, 0]
        ]
    );
    
translate([0,y+20,-thickness]) rotate([90,0,0]) 
    lasercutoutSquare(thickness=thickness, x=x, y=y,
        simple_tab_holes=[
                [MID, x/2-thickness/2, thickness]
            ]
    );
```
![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-003.png)

## Captive Nuts
Great for holding laser-cut sheets together.

```
include <lasercut.scad>; 

thickness = 3.1;
nut_flat_width = 9.3;
x = 50;
y = 100;
lasercutoutSquare(thickness=thickness, x=x, y=y,
    simple_tabs=[
            [UP, x/2, y],
            [DOWN, x/2, 0]
        ],
    captive_nuts=[
            [LEFT, 0, y/2, nut_flat_width],
            [RIGHT, x, y/2, nut_flat_width],
            
            ]
);

translate([0,y+20,-thickness]) rotate([90,0,0]) 
    lasercutoutSquare(thickness=thickness, x=x, y=y,
        simple_tab_holes=[
                [MID, x/2-thickness/2, thickness]
            ]
    );

translate([-20,0,0]) rotate([90,0,90]) 
    lasercutoutSquare(thickness=thickness, x=y, y=x,
        captive_nut_holes=[
                [DOWN, y/2, 0]
            ]
    );
```
![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-004.png)

##  Box

Easy to make a box with four, five or six side. Uses finger joints with the correct alignment to give a flat edge regardless of number of sides.

```
include <lasercut.scad>; 

thickness = 3.1;
x = 50;
y = 50;
z = 75; 


for (sides =[4:6])
{
    color("Gold",0.75) translate([100*(sides-4),0,0]) 
        lasercutoutBox(thickness = thickness, x=x, y=y, z=z, 
        sides=sides, num_fingers=4);
}

```
![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-005.png)


##  Box for Vinyl Cutters

Easy to make a box with four, five or six side. Uses finger joints with the correct alignment to give a flat edge regardless of number of sides.

```
include <lasercut.scad>; 

lasercutoutVinylBox(x=60, y=50, z=80, thickness=0.2);
```
![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-014.png)

[More detail on Vinyl Boxes, including infil ](https://github.com/bmsleight/lasercut/tree/master/readme/VINYLMORE.md)

##  Finger Joints

Simple finger joints, (as automatically used in the box above). Parameters are direction, startup tap, even number) so for example [UP, 1, 4] - UP direction, starting with a tab not a gap, four figners. 

[As suggested in the OpenSCAD forum,](http://forum.openscad.org/Lasercut-tp14126p14174.html) bumpy_finger_joints, when printed in wood the dimple will crush a little and ensure a press fit. 

```
include <../lasercut.scad>; 

$fn=60;
thickness = 3.1;
x = 50;
y = 100;
lasercutoutSquare(thickness=thickness, x=x, y=y,
    bumpy_finger_joints=[
            [UP, 1, 4],
            [DOWN, 1, 4]
        ]
    );


translate([0,y+20,thickness]) rotate([90,0,0]) 
    lasercutoutSquare(thickness=thickness, x=x, y=y,
        finger_joints=[
                [UP, 1, 4],
                [DOWN, 1, 4]
            ]
    );
  
```
![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-006b.png)


##  Finger Joints Milled

Simple finger joints, (as automatically used in the box above), but now using the parameter milling_bit for the bit to cut in to the corners.

```
include <../lasercut.scad>; 

$fn=60;
thickness = 3.1;
x = 130;
y = 100;
lasercutoutSquare(thickness=thickness, x=x, y=y,
    finger_joints=[
            [UP, 0, 2],
            [DOWN, 1, 2]
        ],
        milling_bit=3.125
    );

translate([0,y+20,thickness]) lasercutoutBox(thickness = thickness, x=x, y=y, z=x/2, sides=5, 
          num_fingers=2, milling_bit=3.125);
```
![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-012.png)
    

## Tabs Held in Place by Screws

Simple through tab, held in place by a screw. Paarameters are direction, x, y, Screw-size) so for example [UP, 50, 100, 3] - for a M3 screw to hold the tab in place. 

```
include <../lasercut.scad>; 

thickness = 3.1;
x = 50;
y = 100;

$fn=60;

module base()
{
    lasercutoutSquare(thickness=thickness, x=x, y=y,
        screw_tabs=[
                [UP, x/2, y, 3]
                ]
    );
}

module side()
{
    rotate([90,0,0]) 
    lasercutoutSquare(thickness=thickness, x=x, y=y,
        screw_tab_holes=[
                [MID, x/2-thickness/2, thickness, 3]
            ]
    );
}

translate([0,0,0]) base();
translate([0,y+thickness+20,-thickness]) side();
translate([x+20,0,0]) base();
translate([x+20,y+thickness,-thickness]) side();
```
![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-008.png)

## Twist Fit

Example joint, copied with permission from http://msraynsford.blogspot.co.uk/2012/06/panel-joinery-10.html from  [Martin Raynsford's Blog](http://msraynsford.blogspot.co.uk/). This joint is formed by placing one part through the other and rotating it into place.

Usual parameters (direction, x, y, spine=optional). Spine is option and determines the length of the central spine, default is three times thickness.

```
include <../lasercut.scad>; 

// From http://msraynsford.blogspot.co.uk/2012/06/panel-joinery-10.html

$fn=60;
thickness = 3.1;
x = 100;
y = 150;
x_beam = 50;

module beam()
{
    lasercutoutSquare(thickness=thickness, x=x_beam, y=y,
        twist_connect=[
            [RIGHT,x/2,y/2],
            [RIGHT,x/2,y/4,x_beam/2]
            ]
    );
}

module crossBeam()
{
    rotate([90,0,0]) 
    lasercutoutSquare(thickness=thickness, x=x, y=y,
        twist_holes=[
            [RIGHT, x/2, y*3/4, x_beam, x_beam/2],
            [UP, x/2, y/4, x_beam]
            ]
    );
}


rotate([-90,0,0])  crossBeam();
translate([x+thickness,0,0]) beam();


translate([0,y+75,0]) crossBeam();
translate([(x-x_beam)/2,y/2+75-thickness,y*1/4-thickness/2]) rotate([0,0,0]) beam();
translate([x/2-thickness/2,y*3/4+75-thickness,y*3/4+x_beam/2]) rotate([0,90,0]) beam();


```
![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-010.png)

## Clip

Loosley based upon http://www.deferredprocrastination.co.uk/blog/2013/so-whats-a-practical-laser-cut-clip-size/ the clip and mathcing hole. Should be good for acrylic, mdf but maybe not plywood. 
 
 This is quite a long connnector (thickness * 11) to allow the material to bend and clip in place.

```
include <../lasercut.scad>; 

$fn=60;
thickness = 3.1;
x = 50;
y = 75;
x_beam = 20;

module beam()
{
    lasercutoutSquare(thickness=thickness, x=x_beam, y=y,
        clips=[
            [UP,x_beam/2,y]
            ]
    );
}

module crossBeam()
{
    rotate([90,0,0]) 
    lasercutoutSquare(thickness=thickness, x=x, y=y,
        clip_holes=[
            [DOWN, x/2, y/4, x_beam]
            ]
    );
}


rotate([-90,0,0])  crossBeam();
translate([x+thickness,0,0]) beam();

translate([0,y*3/2+50,0]) crossBeam();
translate([(x-x_beam)/2,y/2+50-thickness,y/4]) rotate([0,0,0]) beam();
```
![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-011.png)


## Add or remove circles, make a slit or cut-out a rectangle
Circles are [radius, x, y]
Slits are [direction,x,y,length of slit]
Cutouts are [x, y, width of cutout, height of cutout]

```
include <lasercut.scad>; 

thickness = 3.1;
x = 50;
y = 100;
r = thickness*2;
lasercutoutSquare(thickness=thickness, x=x, y=y,
    finger_joints=[
            [UP, 1, 4],
            [DOWN, 1, 4]
        ],
    circles_add = [
            [r, x+thickness, y/5],
        ],
    circles_remove = [
            [r, x/2, y/2],
            [1.5, x/2, y*2/3], // Screw-hole
        ],
    slits = [
            [RIGHT,x,y/2,10]
        ],
    cutouts = [
            [x/6, y/6, thickness*5, thickness*2]
        ]
    );
    
```
![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-007.png)
    

## Complex Example
Putting these all together - gives a better example - https://github.com/bmsleight/lasercut/blob/master/examples.scad

![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-complex.png)

## Complex Examples - Box is an array
The box is made of 4,5 or 6 sides. Each of the sides can have any of slips, tab or cutout circles. 

[More detail on Boxes ](https://github.com/bmsleight/lasercut/tree/master/readme/COMPLEXBOX.md)
![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/complexboxes.png)



## Automatically Generate Files Ready for Laser-Cutter

These models are all very nice, but we need to have a file compatible with our laser-cutter software, such as a dxf or svg file. This can be automated using the included `convert-2d.py` script, as shown below.
```
python ./convert-2d.py --keep examples.scad examples_flattened.dxf
```
This generates two new files:
* [examples_flattened.scad](https://raw.githubusercontent.com/bmsleight/lasercut/master/examples_flattened.scad)
* examples_flattened.dxf

If only the dxf file is desired, the `--keep` option can be omitted and the generated .scad will not be kept. 

### [examples_flattened.scad](https://raw.githubusercontent.com/bmsleight/lasercut/master/examples_flattened.scad) 
This is an openscad file showing all the shapes along the y-axis.

![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-complex-2d-all.png)
![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-complex-2d-part.png)


To adjust the positions of the cut-out, so that are not all along the y-axis the parameter flat_adjust can be used, either in the main files or tweaked in the flattened file. For example flat_adjust = [110, -350]), would put the next peice at 110 in x direction and -250 in y-direction. With just using flat_adjust six times, we get a more practical example. 

See [examples_flattened_tweak.scad](https://github.com/bmsleight/lasercut/blob/master/examples_flattened_tweak.scad)

Which give an arrangement and can be exported to a new dxf file.
![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-complex-2d-part-tweak-dxf.png)

### Additional Functionality of convert-2d.py
Specify the output file
```commandline
python ./convert-2d.py examples.scad desired_output_path.scad
```

Export to a specific format supported by OpenSCAD, e.g., .dxf, .svg, .pdf. The intermediate, flattened scad file will be deleted.
```commandline
python ./convert-2d.py examples.scad desired_output_path.svg
```

Export to a specific format supported by OpenSCAD, while keeping the intermediate, flattened scad file. 
```commandline
python ./convert-2d.py --keep examples.scad desired_output_path.svg
```

Generate a flattened scad file where the pieces have a given thickness, e.g. 3.0mm, This is useful for 3D prints.
```commandline
python ./convert-2d.py --extrude=3 examples.scad desired_output_path.scad
```

Generate a flattened scad file where the pieces have a given thickness in a supported 3D format (.stl, .off, .amf, .3mf)
```commandline
python ./convert-2d.py --extrude=2.5 examples.scad desired_output_path.stl
```

Specify the path to the OpenSCAD executable
```commandline
python ./convert-2d.py --openscadbin "C:\Program Files\OpenSCAD\openscad.exe" examples.scad
```

Specify the path to the lasercut.scad library
```commandline
python ./convert-2d.py --library lasercut.scad examples.scad desired_output_path.scad
```

## No Laser-Cutter, use Vinyl Cutter

```
include <lasercut.scad>; 

rotate([0,270,0]) lasercutoutVinylBox(x=80, y=60, z=50, thickness=0.2);
```

![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/vinylexample.jpg)
