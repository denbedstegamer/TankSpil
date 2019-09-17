class Tank {
  
  PVector dir, pos, vel;
  float angle, rad, force = 0.3, rotationForce = PI/42;
  boolean up, left, right, down;
  PVector[] points = new PVector[8];
  
  Tank(PVector pos) {
    this.pos = pos;
    rad = height/25;
    vel = new PVector();
    dir = new PVector(1, 0);
    points[0] = new PVector(-rad/2, -rad/2);
    points[1] = new PVector(rad/2, -rad/2);
    points[2] = new PVector(rad/2, rad/2);
    points[3] = new PVector(-rad/2, rad/2);
    points[4] = new PVector(0, -rad/2);
    points[5] = new PVector(rad/2, 0);
    points[6] = new PVector(0, rad/2);
    points[7] = new PVector(-rad/2, 0);
  }
  
  void render() {
    pushMatrix();
    rectMode(CENTER);
    translate(pos.x, pos.y);
    rotate(angle);
    rect(0, 0, rad, rad);
    line(0, 0, rad/2, 0);
    popMatrix();
    for(int i = 0; i <= 7; i++){
      ellipse(points[i].x+pos.x, points[i].y+pos.y, 3, 3);
    }
  }
  
  void update() {
    if (left) {
      dir.rotate(-rotationForce);
      angle -= rotationForce;
      for(int i = 0; i <= 7; i++){
        points[i].rotate((-rotationForce));
      }
    }
    if (right) {
      dir.rotate(rotationForce);
      angle += rotationForce;
      for(int i = 0; i <= 7; i++){
        points[i].rotate((rotationForce));
      }
    }
    if (up) {
      vel.add(dir.copy().mult(force));
    }
    if (down) {
      vel.sub(dir.copy().mult(force));
    }
    vel.mult(0.9);
    pos.add(vel);
    if(collision(mur)){
      pos.x = width/2;
      pos.y = height/2;
    }
  }
  
  PVector nextPos(PVector pos){
    PVector cdir = dir.copy();
    PVector cvel = vel.copy();
    if(left){
      cdir.rotate(-rotationForce);
    }
    if(right){
      cdir.rotate(rotationForce);
    }
    if (up) {
      cvel.add(cdir.copy().mult(force));
    }
    if (down) {
      cvel.sub(cdir.copy().mult(force));
    }
    cvel.mult(0.9);
    pos.add(cvel);
    return pos;
  }
  
  boolean collision(Wall w){
    PVector P0, P1 = new PVector(), W0 = w.pos.copy(), Wn = w.norm.copy();
    for(int i = 0; i <= 7; i++){
      P0 = points[i].copy().add(pos.copy());
      P1 = nextPos(points[i].copy().add(pos.copy()));
      if((Wn.copy().dot(P0.copy().sub(W0.copy())) > 0 && Wn.copy().dot(P1.copy().sub(W0.copy())) < 0) || (Wn.copy().dot(P0.copy().sub(W0.copy())) < 0 && Wn.copy().dot(P1.copy().sub(W0.copy())) > 0)){
        return true;
      }
    }
    return false;
  }
  
  void shoot() {
    skudList.add(new Skud(new PVector(this.pos.x, this.pos.y), new PVector(dir.x, dir.y)));
  }
}
