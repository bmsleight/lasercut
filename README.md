# <lasercut.scad>
Module for openscad, allowing 3d models to be created from 2d lasercut parts, with a flat file automatically generated.

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
x = 50;
y = 100;
lasercutoutSquare(thickness=thickness, x=x, y=y,
    simple_tabs=[
            [UP, x/2, y],
            [DOWN, x/2, 0]
        ],
    captive_nuts=[
            [LEFT, 0, y/2],
            [RIGHT, x, y/2],
            
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
        lasercutoutBox(thickness = thickness, x=x, y=y, z=z, sides=sides);
}

```
![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-005.png)

##  Finger Joints

Simple finger joints, (as automatically used in the box above). Parameters are direction, startup tap, even number) so for example [UP, 1, 4] - UP direction, starting with a tab not a gap, four figners. 
```
include <lasercut.scad>; 

thickness = 3.1;
x = 50;
y = 100;
lasercutoutSquare(thickness=thickness, x=x, y=y,
    finger_joints=[
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
![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-006.png)

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


## Automatically Generate Files Ready for Laser-Cutter

These models are all very nice, but we need have a nice file, normally dxf to use in a laser-cutter. So we can do this automatically.
```
/bin/bash ./convert-2d.sh examples.scad 
```
This generates three files; 
* examples.scad.csg  
* [2d_examples.scad](https://raw.githubusercontent.com/bmsleight/lasercut/master/2d_examples.scad)  
* 2d_examples.scad.dxf

### [2d_examples.scad](https://raw.githubusercontent.com/bmsleight/lasercut/master/2d_examples.scad) 
This is a openscad file showing all the shapes along the y-axis.

![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-complex-2d-all.png)
![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-complex-2d-part.png)


To adjust the positions of the cut-out, so that are not all along the y-axis the parameter flat_adjust can be used, either in the main files or tweaked in the 2d_ file. For example flat_adjust = [110, -350]), would put the next peice at 110 in x direction and -250 in y-direction. With just using flat_adjust four times, we get a more practical example. 

See [2d_examples_tweak.scad](https://github.com/bmsleight/lasercut/blob/master/2d_examples_tweak.scad)

Which give an arrangement and can be exported to a new dxf file.
![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-complex-2d-part-tweak-dxf.png)

