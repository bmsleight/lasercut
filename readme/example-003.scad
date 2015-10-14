include <../lasercut.scad>; 

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
