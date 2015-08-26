use <lasercut.scad>; 
projection(cut = false) 
	
lasercutout(thickness=3.1, 
             points= [[0, 0], [100, 0], [100, 75], [0, 75], [0, 0]], 
            simple_tabs = [], 
            simple_tab_holes = [[360, 23.45, 37.5], [360, 73.45, 37.5]], 
            captive_nuts = [[0, 50, 75]], 
            captive_nut_holes = [], 
            finger_joints = [], 
            circles_add = [], 
            circles_remove = []) 

lasercutout(thickness=3.1, 
             points= [[0, 0], [100, 0], [100, 75], [0, 75], [0, 0]], 
            simple_tabs = [], 
            simple_tab_holes = [[360, 23.45, 37.5], [360, 73.45, 37.5]], 
            captive_nuts = [[0, 50, 75]], 
            captive_nut_holes = [], 
            finger_joints = [], 
            circles_add = [], 
            circles_remove = []) 

lasercutout(thickness=3.1, 
             points= [[0, 0], [100, 0], [100, 181.4], [0, 181.4], [0, 0]], 
            simple_tabs = [[0, 75, 181.4], [0, 25, 181.4], [180, 75, 0], [180, 25, 0]], 
            simple_tab_holes = [], 
            captive_nuts = [], 
            captive_nut_holes = [], 
            finger_joints = [], 
            circles_add = [], 
            circles_remove = []) 

lasercutout(thickness=3.1, 
             points= [[0, 0], [93.8, 0], [93.8, 193.8], [0, 193.8], [0, 0]], 
            simple_tabs = [[180, -1.55, 0], [180, -1.55, 196.9], [270, 93.8, -1.55]], 
            simple_tab_holes = undef, 
            captive_nuts = undef, 
            captive_nut_holes = [[0, 50, 193.8], [180, 50, 0]], 
            finger_joints = [[0, 1, 4], [180, 1, 4], [90, 1, 4], [270, 0, 4]], 
            circles_add = undef, 
            circles_remove = []) 

lasercutout(thickness=3.1, 
             points= [[0, 0], [93.8, 0], [93.8, 193.8], [0, 193.8], [0, 0]], 
            simple_tabs = [[180, -1.55, 0], [270, 93.8, -1.55]], 
            simple_tab_holes = undef, 
            captive_nuts = undef, 
            captive_nut_holes = undef, 
            finger_joints = [[0, 0, 4], [180, 1, 4], [90, 1, 4], [270, 0, 4]], 
            circles_add = undef, 
            circles_remove = [[25, 50, 100]]) 

lasercutout(thickness=3.1, 
             points= [[0, 0], [93.8, 0], [93.8, 43.8], [0, 43.8], [0, 0]], 
            simple_tabs = [], 
            simple_tab_holes = undef, 
            captive_nuts = undef, 
            captive_nut_holes = undef, 
            finger_joints = [[0, 1, 4], [180, 0, 4], [90, 1, 4], [270, 0, 4]], 
            circles_add = undef, 
            circles_remove = undef) 

lasercutout(thickness=3.1, 
             points= [[0, 0], [93.8, 0], [93.8, 43.8], [0, 43.8], [0, 0]], 
            simple_tabs = [[0, -1.55, 43.8], [180, 95.35, 0]], 
            simple_tab_holes = undef, 
            captive_nuts = undef, 
            captive_nut_holes = undef, 
            finger_joints = [[0, 1, 4], [180, 1, 4], [90, 1, 4], [270, 0, 4]], 
            circles_add = undef, 
            circles_remove = undef) 

lasercutout(thickness=3.1, 
             points= [[0, 0], [43.8, 0], [43.8, 193.8], [0, 193.8], [0, 0]], 
            simple_tabs = [], 
            simple_tab_holes = undef, 
            captive_nuts = undef, 
            captive_nut_holes = undef, 
            finger_joints = [[0, 0, 4], [180, 1, 4], [90, 0, 4], [270, 1, 4]], 
            circles_add = undef, 
            circles_remove = undef) 

lasercutout(thickness=3.1, 
             points= [[0, 0], [43.8, 0], [43.8, 193.8], [0, 193.8], [0, 0]], 
            simple_tabs = [[0, 45.35, 193.8]], 
            simple_tab_holes = undef, 
            captive_nuts = undef, 
            captive_nut_holes = undef, 
            finger_joints = [[0, 0, 4], [180, 1, 4], [90, 0, 4], [270, 1, 4]], 
            circles_add = undef, 
            circles_remove = undef) 

;
