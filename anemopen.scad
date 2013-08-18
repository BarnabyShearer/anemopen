/*
 * Anemopen
 *
 * Copyright 2013 b@Zi.iS
 *
 * License CC BY 3.0
 */

include <scadhelper/main.scad>;
use <scadhelper/vitamins/rfmu.scad>;
use <scadhelper/vitamins/solarpanel.scad>;
use <scadhelper/vitamins/lipo.scad>;
use <scadhelper/vitamins/lipo_rider.scad>;
use <scadhelper/planetary_gear_bearing.scad>;

anemopen();

module anemopen(
	rod = 8,
	bearing = [
		30, //diameter
		20 //height
	]
) {
	//Rod
	translate([
		0,
		0,
		-125
	]) {
		color([.5,.5,.5,1]) {
			cylinder(
				r = rod/2,
				h = 100
			);
		}
	}
	
	
	rotate([
		0,
		0,
		-360*$t
	]) {
	
		//Anomometer bearing
		translate([
			0,
			0,
			-25 - bearing[1]*2 - 5
		]) {
			color(color_plastic) {
				difference() {
					planetary_gear_bearing(
						r = bearing[0],
						h_sun = bearing[1]*.75,
						h_planets = bearing[1]*.75,
						h_rim = bearing[1]
					);
					e() cylinder(
						r = rod/2,
						h = 20
					);
				}
			}
		}
	}
		
	//Anemometer
	color([.5,1,.5,1]) {
	
		for(i=[0:3]) {
			rotate([
				0,
				0,
				360/3*i
			]) {
					if(i==2) {
					translate([
						35,
						-5,
						-60
					]) {
						cube([
							5,
							5,
							33
						]);
					}
				}
				translate([
					0,
					-5,
					-62.5
				]) {
					cube([
						56,
						5,
						5
					]);
				}
				translate([
					70,
					0,
					-60
				]) {
					difference() {
						sphere(r = 15);
						translate([
							-15,
							0,
							-15,
						]) {
							cube(30);
						}
						translate([
							0,
							1,
							0,
						]) {
							sphere(r = 14);
						}
					}
				}
			}
		}
	}


	rotate([
		0,
		0,
		20*sin($t*180)
	]) {
		//Vane bearing
		translate([
			0,
			0,
			-25 - bearing[1]
		]) {
			color(color_plastic) {
				difference() {
					planetary_gear_bearing(
						r = bearing[0],
						h_sun = bearing[1]*.75,
						h_planets = bearing[1]*.75,
						h_rim = bearing[1]
					);
					e() cylinder(
						r = rod/2,
						h = 20
					);
				}
			}
		}
	
		solarpanel();
		
		translate([
			25,
			0,
			-4
		]) {
			rfmu();
		}
		translate([
			0,
			0,
			-12
		]) {
			lipo();
		}
		
		translate([
			0,
			0,
			-13
		]) {
			rotate([
				180,
				0,
				0
			]) {
				lipo_rider();
			}
		}
			
		//Box
		translate([
			-45,
			-40,
			-25
		]) {
			color([.5,.5,1,.1]) {
				cube([
					100,
					80,
					32
				]);
			}
		}
		
		//Vane
		translate([
			-4,
			-.5,
			-25
		]) {
			color([.5,.5,1,.1]) {
				cube([
					200,
					1,
					50
				]);
			}
		}
	}
}