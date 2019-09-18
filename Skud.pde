class Skud {
  PVector pos, vel;
  float rad;
  int life;
  boolean dead;
  
  Skud (PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
    pos.add(vel.setMag(15));
    vel.normalize().mult(6);
    rad = height/60;
  }
  
  void update() {
    pos.add(vel);
    fill(40);
    ellipse(pos.x, pos.y, rad, rad);
    life++;
    if (life >= 180) {
      dead = true;
    }
  }
  
  float dist(Wall w){
    if (w.norm.copy().normalize().x == -1 || w.norm.copy().normalize().x == 1) {
      return abs(w.pos.x-pos.x);
    } else {
      return abs(w.pos.y-pos.y);
    }
  }
}
