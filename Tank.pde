class Tank {
  
  PVector dir, pos, vel;
  float angle, rad, force = 0.3, rotationForce = PI/42;
  boolean up, left, right, down;
  PVector[] corners = new PVector[4];
  
  Tank(PVector pos) {
    this.pos = pos;
    rad = height/25;
    vel = new PVector();
    dir = new PVector(1, 0);
    corners[0] = new PVector(-rad/2, -rad/2);
    corners[1] = new PVector(rad/2, -rad/2);
    corners[2] = new PVector(rad/2, rad/2);
    corners[3] = new PVector(-rad/2, rad/2);
  }
  
  void render() {
    pushMatrix();
    rectMode(CENTER);
    translate(pos.x, pos.y);
    rotate(angle);
    rect(0, 0, rad, rad);
    line(0, 0, rad/2, 0);
    popMatrix();
    for(int i = 0; i != 4; i++){
      ellipse(corners[i].x+pos.x, corners[i].y+pos.y, 3, 3);
    }
  }
  
  void update() {
    if (left) {
      dir.rotate(-rotationForce);
      angle -= rotationForce;
    }
    if (right) {
      dir.rotate(rotationForce);
      angle += rotationForce;
    }
    if (up) {
      vel.add(dir.copy().mult(force));
    }
    if (down) {
      vel.sub(dir.copy().mult(force));
    }
    vel.mult(0.9);
    pos.add(vel);
  }
  
  /*PVector nextPos(){
    if(left){
      
    }
    return BANGEREN;
  }*/
  
  void shoot() {
    skudList.add(new Skud(new PVector(this.pos.x, this.pos.y), new PVector(dir.x, dir.y)));
  }
}
