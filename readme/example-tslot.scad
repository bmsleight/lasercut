include <lasercut.scad>; 

thickness = 1;

x=25;
y=40;
z=20;

sides=6;


tslots_1_2 = [
            [LEFT, 0, y/2],
            [RIGHT, x, y/2]
        ];

tslot_holes_1_2=[
                [UP, x/2, y],
                [DOWN, x/2, 0],
            ];


tslot_holes_3_4=[
                [RIGHT, z, y/2],
                [LEFT, 0, y/2],
            ];

tslots_5_6=[
            [RIGHT, x, (z-thickness*4)/2],
            [LEFT, 0, (z-thickness*4)/2]
        ];
//        x=x, y=z-thickness*4,

translate([0,0,thickness])
{
    translate([0,0,0]) lasercutoutSquare(thickness=thickness, 
            x=x, y=y,
            tslots=tslots_1_2
            );
    
    translate([x,0,z-thickness*2]) rotate([0,180,0]) lasercutoutSquare(thickness=thickness, 
            x=x, y=y,
            tslots=tslots_1_2
            );
    
    
    translate([0,0,-thickness]) rotate([0,270,0]) lasercutoutSquare(thickness=thickness,
            x=z, y=y,
            tslot_holes=tslot_holes_3_4
            );
    
    translate([x,0,z-thickness]) rotate([0,90,0]) lasercutoutSquare(thickness=thickness,
            x=z, y=y,
            tslot_holes=tslot_holes_3_4
                );
    
    translate([0,thickness*2,thickness]) rotate([90,0,0]) lasercutoutSquare(thickness=thickness,
            x=x, y=z-thickness*4,
            tslots=tslots_5_6
            );
            
    translate([0,y-thickness*2,z-thickness*3]) rotate([270,0,0]) lasercutoutSquare(thickness=thickness,
            x=x, y=z-thickness*4,
            tslots=tslots_5_6
            );
}