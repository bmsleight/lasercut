include <../lasercut.scad>; 

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
