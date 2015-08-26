include <lasercut.scad>; 

thickness = 3.1;
x = 100;
y = 200;
z =  50;
height = 75;


module support()
{
    lasercutoutSquare(thickness=thickness, x=x, y=height,
        simple_tab_holes=[
            [MID, x*.25-thickness/2, height/2], 
            [MID, x*.75-thickness/2, height/2]
            ],
        captive_nuts=[[UP, x/2, height] ]
    );   
}

module stut()
{
    lasercutoutSquare(thickness=thickness, x=x, y=y-thickness*6,  
        simple_tabs=[
            [UP, x*.75, y-thickness*6], [UP, x*.25, y-thickness*6],
            [DOWN, x*.75, 0], [DOWN, x*.25, 0] 
            ]
        );   
}

module box()
{
    circles_remove_a = [
        [],
        [[x/4, x/2, y/2]]
    ];
    captive_nut_holes_a = [
        [[UP, x/2, y-2*thickness,], [DOWN, x/2, 0,], ]
    ];
    lasercutoutBox(thickness = thickness, x=x, y=y, z=z, sides=6, captive_nut_holes_a = captive_nut_holes_a, circles_remove_a=circles_remove_a );
}


translate([0,thickness*3,0]) rotate([90,0,0]) support();
translate([0,y-thickness*2,0]) rotate([90,0,0]) support();
translate([0,thickness*3,height/2]) stut();
translate([0,0,height]) box();
