class Game {
  int currentLevel = 1;
  Level l = new Level(new ArrayList<Block>(), this);
  ArrayList<Tank> enemies;

  Game() {
    mure = new ArrayList<Wall>();
    skudList = new ArrayList<Skud>();
    tankList = new ArrayList<Tank>();
    blockList = new ArrayList<Block>();
    enemies = new ArrayList<Tank>();
    l = l.createLevel1();
  }

  void update() {
    for (int i = 0; i < tankList.size(); i++) {
      if (tankList.get(i).life > 0) {
        tankList.get(i).update();
      }
    }

    aim();

    if (frameCount%30==0) {
      for (int i = 0; i < enemies.size(); i++) {
        enemies.get(i).shoot();
      }
    }

    for (int i = 0; i < enemies.size(); i++) {
      enemies.get(i).update();
    }

    for (int i = 0; i < enemies.size(); i++) {
      if (enemies.get(i).life <= 0) {
        enemies.remove(i);
      }
    }
    
    for (int i = skudList.size(); i > 0; i--) {
      if (skudList.get(i-1).dead) {
        skudList.remove(i-1);
      }
    }

    if (tankList.get(0).life <= 0 && tankList.get(1).life <= 0) {
      //TODO make game over screen
    }
    if (enemies.size() == 0) {
      l.createLevel(currentLevel+1);
    }
    
    render();
  }

  void aim() {
    Tank t = new Tank(new PVector(), 0, 0, "Player 1", 0, 0, 0, true);
    if (tankList.get(1).life <= 0) {
      t = tankList.get(0);
    }
    if (tankList.get(0).life <= 0) {
      t = tankList.get(1);
    }
    for (int i = 0; i < enemies.size(); i++) {
      if (tankList.get(0).life > 0 && tankList.get(1).life > 0) {
        if (enemies.get(i).pos.copy().sub(tankList.get(0).pos).mag() > enemies.get(i).pos.copy().sub(tankList.get(1).pos).mag()) {
          t = tankList.get(1);
        } else {
          t = tankList.get(0);
        }
      }
      if (PVector.angleBetween(enemies.get(i).dir, t.pos.copy().sub(enemies.get(i).pos).normalize().rotate(PI/2)) >= PVector.angleBetween(enemies.get(i).dir.copy().mult(-1), t.pos.copy().sub(enemies.get(i).pos).normalize().rotate(PI/2))) {
        enemies.get(i).right = true;
        enemies.get(i).left = false;
      } else {
        enemies.get(i).right = false;
        enemies.get(i).left = true;
      }
      if (enemies.get(i).right) {
        if (PVector.angleBetween(enemies.get(i).dir, t.pos.copy().sub(enemies.get(i).pos).normalize().rotate(PI/2))-PVector.angleBetween(enemies.get(i).dir.copy().mult(-1), t.pos.copy().sub(enemies.get(i).pos).normalize().rotate(PI/2)) <= enemies.get(i).rotationForce) {
          enemies.get(i).right = false;
          enemies.get(i).left = false;
        }
      } else {
        if (PVector.angleBetween(enemies.get(i).dir, t.pos.copy().sub(enemies.get(i).pos).normalize().rotate(PI/2))-PVector.angleBetween(enemies.get(i).dir.copy().mult(-1), t.pos.copy().sub(enemies.get(i).pos).normalize().rotate(PI/2)) >= enemies.get(i).rotationForce*-1) {
          enemies.get(i).right = false;
          enemies.get(i).left = false;
        }
      }
    }
  }

  void render() {
    background(255);
    text(currentLevel, width/2, height/16);
    for (int i = 0; i < tankList.size(); i++) {
      if (tankList.get(i).life > 0) {
        tankList.get(i).render();
      }
      tankList.get(i).lifespan();
    }
    for (int i = 0; i < enemies.size(); i++) {
      enemies.get(i).render();
    }
    for (int i = 0; i < mure.size(); i++) {
      mure.get(i).render();
    }
    for (int i = 0; i < skudList.size(); i++) {
      skudList.get(i).update();
    }
    ts.escape();
  }

  void createEnemy(PVector pos) {
    Tank enemy1 = new Tank(pos, 3000, width-width/10-300, "Player 2", 40, 40, 40, false) {
      @Override
        public void update() {
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
      }

      @Override
        public void shoot() {
        skudList.add(new Skud(new PVector(this.pos.x, this.pos.y), new PVector(dir.x, dir.y), false));
      }
    };
    enemies.add(enemy1);
  }
}
