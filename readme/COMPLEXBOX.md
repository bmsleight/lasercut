## Complex Boxes

Each side of the box is a lasercutoutSquare. It is possible to pass parameter such as slips, tab or cutout circles to the each lasercutoutSquare within the box. 

For example to cut a circle on the bottom of the box. 

```
include <lasercut.scad>; 

thickness = 3.1;
unit = 70;


circles_remove_a = [
    [
        [unit/14, unit/2-thickness/2, unit/2-thickness]
    ],  
];

lasercutoutBox(thickness = thickness, x=unit, y=unit, z=unit, 
    sides=6, circles_remove_a=circles_remove_a );
```

As circles_remove is an array. So "circles remove a" is an array of arrays. Such that each side of the box may have many circles removed.

```
include <lasercut.scad>; 

thickness = 3.1;
unit = 70;


circles_remove_a = [
    [
        [unit/14, unit*1/6-thickness/2, unit*1/6-thickness/2],
        [unit/14, unit*5/6-thickness/2, unit*5/6-thickness/2],
    ],  
];

lasercutoutBox(thickness = thickness, x=unit, y=unit, z=unit, 
    sides=6, circles_remove_a=circles_remove_a );
```

An cute full example as follows 

![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/complexboxes.png)


```
include <lasercut.scad>; 

thickness = 3.1;
unit = 70;

die_one = [
            [unit/14, unit*7/14-thickness/2, unit*7/14-thickness/2]
            ];

die_two = [
            [unit/14, unit*3/14-thickness/2, unit*3/14-thickness/2], 
            [unit/14, unit*11/14-thickness/2, unit*11/14-thickness/2]
            ];

die_three = [
            [unit/14, unit*3/14-thickness/2, unit*3/14-thickness/2], 
            [unit/14, unit*7/14-thickness/2, unit*7/14-thickness/2],
            [unit/14, unit*11/14-thickness/2, unit*11/14-thickness/2]
            ];

die_four = [
            [unit/14, unit*3/14-thickness/2, unit*3/14-thickness/2], 
            [unit/14, unit*3/14-thickness/2, unit*11/14-thickness/2], 
            [unit/14, unit*11/14-thickness/2, unit*3/14-thickness/2],
            [unit/14, unit*11/14-thickness/2, unit*11/14-thickness/2]
            ];

die_five = [
            [unit/14, unit*3/14-thickness/2, unit*3/14-thickness/2], 
            [unit/14, unit*3/14-thickness/2, unit*11/14-thickness/2], 
            [unit/14, unit*7/14-thickness/2, unit*7/14-thickness/2],
            [unit/14, unit*11/14-thickness/2, unit*3/14-thickness/2],
            [unit/14, unit*11/14-thickness/2, unit*11/14-thickness/2]
            ];

die_six = [
            [unit/14, unit*3/14-thickness/2, unit*3/14-thickness/2], 
            [unit/14, unit*3/14-thickness/2, unit*7/14-thickness/2],
            [unit/14, unit*3/14-thickness/2, unit*11/14-thickness/2], 
            [unit/14, unit*11/14-thickness/2, unit*3/14-thickness/2],
            [unit/14, unit*11/14-thickness/2, unit*7/14-thickness/2],
            [unit/14, unit*11/14-thickness/2, unit*11/14-thickness/2],
            ];


circles_remove_a = [
        die_one,
        die_two,
        die_three,
        die_four,
        die_five,
        die_six
];


lasercutoutBox(thickness = thickness, x=unit, y=unit, z=unit, 
    sides=6, circles_remove_a=circles_remove_a );

```

Noting the "_a" for array of array, the full parameters for lasercutoutBox 

```
module lasercutoutBox(thickness, x=0, y=0, z=0, sides=6, num_fingers=2,
        simple_tab_holes_a=[], 
        captive_nuts_a=[], captive_nut_holes_a=[],
        screw_tab_holes_a=[],
        twist_holes_a=[],
        clip_holes_a=[],
        circles_add_a=[],
        circles_remove_a=[],
        slits_a = [],
        cutouts_a = [],
        milling_bit = 0.0
)
```