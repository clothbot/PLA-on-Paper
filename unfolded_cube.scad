// Simple Unfolded Cube

render_part="unfolded_cube_map"; // unfolded_cube_map()

module frame_2d(size,th) {
  difference() {
    square(size,center=true);
    square(size-2*th,center=true);
  }
}

module unfolded_cube_map(size=15.0,spacing=1.0,wall_th=2.0,wall_h=1.0) {
  // Top face is center  face 0
  linear_extrude(height=wall_h) frame_2d(size,wall_th);
  if($children>0) child(0);
  // CCW from X+
  // face 1
  translate([size+spacing,0,0]) {
    linear_extrude(height=wall_h) frame_2d(size,wall_th);
    if($children==1) child(0);
    if($children>1) child(1);
  }
  // face 2
  translate([0,size+spacing,0]) {
    linear_extrude(height=wall_h) frame_2d(size,wall_th);
    if($children==1) child(0);
    if($children>2) child(2);
  }
  // face 3
  translate([-size-spacing,0,0]) {
    linear_extrude(height=wall_h) frame_2d(size,wall_th);
    if($children==1) child(0);
    if($children>3) child(3);
  }
  // face 4
  translate([0,-size-spacing,0]) {
    linear_extrude(height=wall_h) frame_2d(size,wall_th);
    if($children==1) child(0);
    if($children>4) child(4);
  }
  // Bottom face 5
  translate([0,-2*(size+spacing),0]) {
    linear_extrude(height=wall_h) frame_2d(size,wall_th);
    if($children==1) child(0);
    if($children>5) child(5);
  }
}

if(render_part=="unfolded_cube_map") {
  echo("Rendering unfolded_cube_map()...");
  unfolded_cube_map();
}


