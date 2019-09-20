class Skud {
  PVector pos, vel;
  float rad = height/60;
  int life;
  boolean dead, hasCol;
  PVector[] points;
  boolean shotFromPlayer;

  Skud (PVector pos, PVector vel, boolean shotFromPlayer) {
    this.shotFromPlayer = shotFromPlayer;
    this.pos = pos;
    this.vel = vel;
    vel.normalize().setMag(3);
    points = new PVector[4];
    points[0] = new PVector(0, -rad/2);
    points[1] = new PVector(rad/2, 0);
    points[2] = new PVector(0, rad/2);
    points[3] = new PVector(-rad/2, 0);
  }

  void update() {
    hasCol = false;
    collision();
    if (!hasCol) {
      pos = nextPos(pos);
    }
    if (g.coop) {
      if (!shotFromPlayer) {
        for (int i = 0; i < tankList.size(); i++) {
          if (shotPlayer(tankList.get(i))) {
            if (tankList.get(i).life > 0) {
              life = 1000;
              tankList.get(i).life -= tankList.get(i).startLife/2;
            }
          }
        }
      } else {
        for (int i = 0; i < g.enemies.size(); i++) {
          if (shotPlayer(g.enemies.get(i))) {
            life = 1000;
            g.enemies.get(i).life = 0;
          }
        }
      }
    } else {
      if (!shotFromPlayer) {
        for (int i = 0; i < tankList.size(); i++) {
          if (shotPlayer(tankList.get(i)) && tankList.get(i).player) {
            if (tankList.get(i).life > 0) {
              life = 1000;
              tankList.get(i).life -= tankList.get(i).startLife/2;
            }
          }
        }
      } else {
        for (int i = 0; i < tankList.size(); i++) {
          if (shotPlayer(tankList.get(i)) && !tankList.get(i).player) {
            if (tankList.get(i).life > 0) {
              life = 1000;
              tankList.get(i).life -= tankList.get(i).startLife/2;
            }
          }
        }
      }
    }

    life++;
    if (life >= 180) {
      dead = true;
    }
    fill(40);
    ellipse(pos.x, pos.y, rad, rad);
  }

  PVector nextPos(PVector p) {
    return p.copy().add(vel);
  }

  void collision() {
    Wall w;
    for (int m = 0; m < mure.size(); m++) {
      w = mure.get(m);
      PVector P0, P1 = new PVector(), W0 = w.pos.copy(), Wn = w.norm.copy();
      if (Wn.copy().normalize().x == -1 || Wn.copy().normalize().x == 1) {
        for (int i = 0; i <= 3; i++) {
          P0 = points[i].copy().add(pos.copy());
          P1 = nextPos(points[i].copy().add(pos.copy()));
          if (P1.y > w.pos.y && P1.y < w.pos.y+w.dir.y) {
            if ((Wn.copy().dot(P0.copy().sub(W0.copy())) > 0 && Wn.copy().dot(P1.copy().sub(W0.copy())) < 0) || (Wn.copy().dot(P0.copy().sub(W0.copy())) < 0 && Wn.copy().dot(P1.copy().sub(W0.copy())) > 0)) {
              float distTravveled = P0.x-w.pos.x, distNeedsToTravel = vel.x-distTravveled;
              pos.x += w.pos.x-P1.x;
              pos.x -= distNeedsToTravel;
              vel.x *= -1;
              hasCol = true;
            }
          }
        }
      }
      if (Wn.copy().normalize().y == -1 || Wn.copy().normalize().y == 1) {
        for (int i = 0; i <= 3; i++) {
          P0 = points[i].copy().add(pos.copy());
          P1 = nextPos(points[i].copy().add(pos.copy()));
          if (P1.x > w.pos.x && P1.x < w.pos.x+w.dir.x) {
            if ((Wn.copy().dot(P0.copy().sub(W0.copy())) > 0 && Wn.copy().dot(P1.copy().sub(W0.copy())) < 0) || (Wn.copy().dot(P0.copy().sub(W0.copy())) < 0 && Wn.copy().dot(P1.copy().sub(W0.copy())) > 0)) {
              float distTravveled = P0.y-w.pos.y, distNeedsToTravel = vel.y-distTravveled;
              pos.y += w.pos.y-P1.y;
              pos.y -= distNeedsToTravel;
              vel.y *= -1;
              hasCol = true;
            }
          }
        }
      }
    }
  }

  boolean shotPlayer(Tank t) {
    PVector w;
    if (t.life > 0) {
      for (int m = 0; m <= 15; m++) {
        w = t.points[m];
        if (dist(w.x+t.pos.x, w.y+t.pos.y, pos.x, pos.y) < rad/2) {
          return true;
        }
      }
    }
    return false;
  }
}
