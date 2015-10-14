# lasercut
Module for openscad, allowing 3d models to be created from 2d lasercut parts

## Basic usage

To prepare a simple rectangle
```
include <lasercut.scad>; 

thickness = 3.1;
x = 50;
y = 100;
lasercutoutSquare(thickness=thickness, x=x, y=y);
```
![alt tag](https://raw.githubusercontent.com/bmsleight/lasercut/master/readme/example-001.png)
