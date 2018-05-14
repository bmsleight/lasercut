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