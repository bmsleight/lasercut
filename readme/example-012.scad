include <../lasercut.scad>; 

$fn=60;
thickness = 3.1;
x = 130;
y = 100;
lasercutoutSquare(thickness=thickness, x=x, y=y,
    finger_joints=[
            [UP, 0, 3],
            [DOWN, 1, 3]
        ],
        milling_bit=3.125
    );


translate([0,y+20,thickness]) rotate([90,0,0]) 
    lasercutoutSquare(thickness=thickness, x=x, y=y,
        finger_joints=[
                [UP, 1, 3],
                [DOWN, 0, 3]
            ],
        milling_bit=3.125
    );
    
