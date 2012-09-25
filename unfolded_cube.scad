// Simple Unfolded Cube

render_part="unfolded_cube_map"; // unfolded_cube_map()
render_part="unfolded_cube_w_led"; // unfolded_cube_w_led()

module frame_2d(size,th) {
  difference() {
    square(size,center=true);
    square(size-2*th,center=true);
  }
}

module hinge(size,spacing,wall_h) {
  hull() {
    translate([size/2-spacing,-size/2+2*spacing,wall_h]) cube([spacing/2,spacing/2,wall_h],center=true);
    translate([size/2+2*spacing, size/2-2*spacing,wall_h]) cube([spacing/2,spacing/2,wall_h],center=true);
  }
}

module unfolded_cube_map(size=15.0,spacing=1.0,wall_th=2.0,wall_h=1.0,add_hinges=true) {
  // Top face is center  face 0    
  linear_extrude(height=wall_h) frame_2d(size-spacing,wall_th);
  if(add_hinges) for(i=[0:3]) rotate([0,0,360*i/4]) hinge(size,spacing,wall_h);
  if($children>0) child(0);
  // CCW from X+
  // face 1
  translate([size+spacing,0,0]) {
    linear_extrude(height=wall_h) frame_2d(size-spacing,wall_th);
    if($children==1) child(0);
    if($children>1) child(1);
  }
  // face 2
  translate([0,size+spacing,0]) {
    linear_extrude(height=wall_h) frame_2d(size-spacing,wall_th);
    if($children==1) child(0);
    if($children>2) child(2);
  }
  // face 3
  translate([-size-spacing,0,0]) {
    linear_extrude(height=wall_h) frame_2d(size-spacing,wall_th);
    if($children==1) child(0);
    if($children>3) child(3);
  }
  // face 4
  translate([0,-size-spacing,0]) {
    linear_extrude(height=wall_h) frame_2d(size-spacing,wall_th);
    if($children==1) child(0);
    if($children>4) child(4);
  }
  // Bottom face 5
  translate([0,-2*(size+spacing),0]) {
    linear_extrude(height=wall_h) frame_2d(size-spacing,wall_th);
    rotate([0,0,90]) hinge(size,spacing,wall_h);
    if($children==1) child(0);
    if($children>5) child(5);
  }
}

if(render_part=="unfolded_cube_map") {
  echo("Rendering unfolded_cube_map()...");
  unfolded_cube_map();
}

module unfolded_cube_w_led(size=20.0, spacing=1.0, inner_h=5.0, wall_h=0.5,wall_th=2.0, led_d=5.2) {
  $fn=16;
  unfolded_cube_map(size=size,wall_th=wall_th,wall_h=wall_h,spacing=spacing) intersection() {
    hull() {
      translate([0,0,spacing/4]) cube([size-spacing,size-spacing,spacing/2],center=true);
      translate([0,0,inner_h-wall_h/2]) cube([size-2*inner_h-spacing,size-2*inner_h-spacing,wall_h],center=true);
    }
    union() {
      difference() {
	  cylinder(r=led_d/2+wall_th,h=2*wall_th,center=true);
	  cylinder(r=led_d/2,h=size+wall_h,center=true);
	}
	for(i=[0:3]) rotate([0,0,360*i/4+45]) translate([led_d/2+wall_th/2,-wall_th/2,wall_h/2]) cube([size,wall_th,wall_h],center=false);
    }
  }
}

if(render_part=="unfolded_cube_w_led") {
  echo("Rendering unfolded_cube_w_led()...");
  unfolded_cube_w_led(wall_h=0.5,led_d=5.6,inner_h=1.25);
}

