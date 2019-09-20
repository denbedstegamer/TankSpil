class Tank {

  PVector dir, pos, vel;
  int life, lifeBarX, startLife, r, g, b;
  String lifeBarNavn;
  float angle, rad, force, rotationForce = PI/42, lastShot;
  boolean up, left, right, down, hasCol, dead, player;
  PVector[] points = new PVector[16];

  //constructor for en tank
  Tank(PVector pos, int life, int lifeBarX, String lifeBarNavn, int r, int g, int b, int playerType) {
    if (playerType == 0) {
      force = 0.3;
      player = true;
    }
    if(playerType == 1){
      force = 0.1;
      up = true;
      rotationForce = PI/82;
      player = false;
    }
    if (playerType == 2) {
      force = 0.3;
      player = false;
    }
    this.life = life;
    startLife = life;
    this.r = r;
    this.g = g;
    this.b = b;
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
    points[8] = new PVector(rad/4, -rad/2);
    points[9] = new PVector(rad/2, rad/4);
    points[10] = new PVector(rad/4, rad/2);
    points[11] = new PVector(-rad/2, rad/4);
    points[12] = new PVector(-rad/4, -rad/2);
    points[13] = new PVector(rad/2, -rad/4);
    points[14] = new PVector(-rad/4, rad/2);
    points[15] = new PVector(-rad/2, -rad/4);
  }

  //funktion der viser tanken
  void render() {
    pushMatrix();
    rectMode(CENTER);
    translate(pos.x, pos.y);
    rotate(angle);
    fill(r, g, b);
    rect(0, 0, rad, rad);
    line(0, 0, rad/2, 0);
    popMatrix();
    /*for (int i = 0; i <= 15; i++) {
     ellipse(points[i].x+pos.x, points[i].y+pos.y, 3, 3);
     }*/
    /*for (int i = 0; i <= 3; i++) {
     line(sider[i].pos.x+pos.x, sider[i].pos.y+pos.y, sider[i].pos.x+sider[i].dir.x+pos.x, sider[i].pos.y+sider[i].dir.y+pos.y);
     }*/
  }
  
  //funktion der opdatere tankens position
  void update() {
    hasCol = false;
    if (canRotate()) {
      if (left) {
        dir.rotate(-rotationForce);
        angle -= rotationForce;
        for (int j = 0; j <= 15; j++) {
          points[j].rotate((-rotationForce));
        }
      }
      if (right) {
        dir.rotate(rotationForce);
        angle += rotationForce;
        for (int j = 0; j <= 15; j++) {
          points[j].rotate((rotationForce));
        }
      }
    }
    collision();
    if (!hasCol) {
      pos = nextPos(pos);
    }
    lastShot--;
  }

  //funktion der udregner den neste position for et punket på tanken
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

  //funktion der udregner om tanken kan rotere eller ej
  boolean canRotate() {
    Wall w;
    for (int m = 0; m < mure.size(); m++) {
      if (mure.get(m).collision) {
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
    }
    return true;
  }

  //funktion der ser om tanken colliderer med murene
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
      if (mure.get(m).collision) {
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
  }

  //funktion der skyder et skud ud fra tanken
  void shoot(boolean fromPlayer) {
    if (lastShot <= 0) {
      //skudList.add(new Skud(new PVector(this.pos.x + dir.copy().setMag(rad/2+height/120).x, this.pos.y + dir.copy().setMag(rad/2+height/120).y), new PVector(dir.x, dir.y), true));
      skudList.add(new Skud(new PVector(this.pos.x, this.pos.y), new PVector(dir.x, dir.y), fromPlayer));
      lastShot = 15;
    }
  }

  //funktion der viser tankens liv
  void lifespan() {
    int lifePercentage;
    String currentLife;
    rectMode(CORNER);
    textAlign(CORNER);
    fill(255);
    strokeWeight(4);
    rect(lifeBarX, height/10, (startLife*300)/startLife, 25);
    fill(255, 50, 50);
    if (life > 0) {
      strokeWeight(0);
      rect(lifeBarX, height/10, (life*300)/startLife, 25);
    }
    strokeWeight(1);
    textSize(32);
    fill(0);
    text(lifeBarNavn, lifeBarX, height/10-25);
    lifePercentage = floor(life/(startLife/100));
    currentLife = lifePercentage + "%";
    text(currentLife, lifeBarX+(startLife*300)/startLife+25, height/10+25);
  }
}
