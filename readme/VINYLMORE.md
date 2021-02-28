## Vinyl Cutter Made Boxes

To give a box made with a vinyl cutter, using thin material, more strength infill can be set. 


```
include <lasercut.scad>; 

lasercutoutVinylBox(x=60, y=50, z=20, thickness=0.3, infill=true,
    overlapdistance=2,
    infill_x=3,
    infill_y=3,
    sides=1);
    
translate([0,75,0]) lasercutoutVinylBox(x=60, y=50, z=20, thickness=0.3, infill=true,
    overlapdistance=2,
    infill_x=3,
    infill_y=3,
    sides=6);
```

![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-015.png)

![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/vinylexample2.jpg)