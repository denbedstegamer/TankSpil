class Tank {

  PVector dir, pos, vel;
  int life, lifeBarX, startLife;
  String lifeBarNavn;
  float angle, rad, force = 0.3, rotationForce = PI/42;
  boolean up, left, right, down, hasCol;
  PVector[] points = new PVector[8];

  Tank(PVector pos, int life, int lifeBarX, String lifeBarNavn) {
    this.life = life;
    startLife = life;
    this.lifeBarX = lifeBarX;
    this.lifeBarNavn = lifeBarNavn;
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
    /*for (int i = 0; i <= 7; i++) {
      ellipse(points[i].x+pos.x, points[i].y+pos.y, 3, 3);
    }*/
  }

  void update() {
    hasCol = false;
    if (canRotate()) {
      if (left) {
        dir.rotate(-rotationForce);
        angle -= rotationForce;
        for (int j = 0; j <= 7; j++) {
          points[j].rotate((-rotationForce));
        }
      }
      if (right) {
        dir.rotate(rotationForce);
        angle += rotationForce;
        for (int j = 0; j <= 7; j++) {
          points[j].rotate((rotationForce));
        }
      }
    }
    /*if (up) {
     vel.add(dir.copy().mult(force));
     }
     if (down) {
     vel.sub(dir.copy().mult(force));
     }
     vel.mult(0.9);
     pos.add(vel);*/
    collision();
    if (!hasCol) {
      pos = nextPos(pos);
    }
  }

  PVector nextPos(PVector pos) {
    PVector cdir = dir.copy(), cvel = vel.copy(), position = pos.copy();
    if (canRotate()) {
      if (left) {
        cdir.rotate(-rotationForce);
      }
      if (right) {
        cdir.rotate(rotationForce);
      }
    }
    if (up) {
      cvel.add(cdir.copy().mult(force));
    }
    if (down) {
      cvel.sub(cdir.copy().mult(force));
    }
    cvel.mult(0.9);
    position.add(cvel);
    return position;
  }

  boolean canRotate() {
    Wall w;
    for (int m = 0; m < mure.size(); m++) {
      w = mure.get(m);
      PVector P0, P1 = new PVector(), W0 = w.pos.copy(), Wn = w.norm.copy();
      if (Wn.copy().normalize().x == -1 || Wn.copy().normalize().x == 1) {
        for (int i = 0; i <= 7; i++) {
          P0 = points[i].copy().add(pos.copy());
          if (left) {
            P1 = points[i].copy().rotate(-rotationForce).add(pos.copy());
          }
          if (right) {
            P1 = points[i].copy().rotate(rotationForce).add(pos.copy());
          }
          if (P1.y > w.pos.y && P1.y < w.pos.y+w.dir.y) {
            if ((Wn.copy().dot(P0.copy().sub(W0.copy())) > 0 && Wn.copy().dot(P1.copy().sub(W0.copy())) < 0) || (Wn.copy().dot(P0.copy().sub(W0.copy())) < 0 && Wn.copy().dot(P1.copy().sub(W0.copy())) > 0)) {
              pos.x += w.pos.x-P1.x;
              return false;
            }
          }
        }
      } else {
        for (int i = 0; i <= 7; i++) {
          P0 = points[i].copy().add(pos.copy());
          if (left) {
            P1 = points[i].copy().rotate(-rotationForce).add(pos.copy());
          }
          if (right) {
            P1 = points[i].copy().rotate(rotationForce).add(pos.copy());
          }
          if (P1.x > w.pos.x && P1.x < w.pos.x+w.dir.x) {
            if ((Wn.copy().dot(P0.copy().sub(W0.copy())) > 0 && Wn.copy().dot(P1.copy().sub(W0.copy())) < 0) || (Wn.copy().dot(P0.copy().sub(W0.copy())) < 0 && Wn.copy().dot(P1.copy().sub(W0.copy())) > 0)) {
              pos.y += w.pos.y-P1.y;
              return false;
            }
          }
        }
      }
    }
    return true;
  }

  void collision() {
    Wall w;
    if (up) {
      vel.add(dir.copy().mult(force));
    }
    if (down) {
      vel.sub(dir.copy().mult(force));
    }
    vel.mult(0.9);
    for (int m = 0; m < mure.size(); m++) {
      w = mure.get(m);
      PVector P0, P1 = new PVector(), W0 = w.pos.copy(), Wn = w.norm.copy();
      if (Wn.copy().normalize().x == -1 || Wn.copy().normalize().x == 1) {
        for (int i = 0; i <= 7; i++) {
          P0 = points[i].copy().add(pos.copy());
          P1 = nextPos(points[i].copy().add(pos.copy()));
          if (P1.y > w.pos.y && P1.y < w.pos.y+w.dir.y) {
            if ((Wn.copy().dot(P0.copy().sub(W0.copy())) > 0 && Wn.copy().dot(P1.copy().sub(W0.copy())) < 0) || (Wn.copy().dot(P0.copy().sub(W0.copy())) < 0 && Wn.copy().dot(P1.copy().sub(W0.copy())) > 0)) {
              pos.x += w.pos.x-P1.x;
              vel.x = 0;
              hasCol = true;
            }
          }
        }
      } else {
        for (int i = 0; i <= 7; i++) {
          P0 = points[i].copy().add(pos.copy());
          P1 = nextPos(points[i].copy().add(pos.copy()));
          if (P1.x > w.pos.x && P1.x < w.pos.x+w.dir.x) {
            if ((Wn.copy().dot(P0.copy().sub(W0.copy())) > 0 && Wn.copy().dot(P1.copy().sub(W0.copy())) < 0) || (Wn.copy().dot(P0.copy().sub(W0.copy())) < 0 && Wn.copy().dot(P1.copy().sub(W0.copy())) > 0)) {
              pos.y += w.pos.y-P1.y;
              vel.y = 0;
              hasCol = true;
            }
          }
        }
      }
    }
  }

  void shoot() {
    skudList.add(new Skud(new PVector(this.pos.x, this.pos.y), new PVector(dir.x, dir.y)));
  }
  
  void lifespan() {
    int lifePercentage;
    String currentLife;
    fill(255);
    strokeWeight(4);
    rectMode(CORNER);
    rect(lifeBarX, height/10, (startLife*300)/startLife, 25);
    strokeWeight(0);
    textSize(32);
    fill(0);
    text(lifeBarNavn, lifeBarX, height/10-25);
    strokeWeight(1);
    lifePercentage = floor(life/(startLife/100));
    currentLife = lifePercentage + "%";
    text(currentLife, lifeBarX+(startLife*300)/startLife+25, height/10+25);
    fill(255, 50, 50);
    if (life > 0) {
      rect(lifeBarX, height/10, (life*300)/startLife, 25);
      life--;
    }
  }
}
