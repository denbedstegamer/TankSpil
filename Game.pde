class Game {
  int currentLevel;
  Level l;
  ArrayList<Tank> enemies;

  Game() {
    mure = new ArrayList<Wall>();
    skudList = new ArrayList<Skud>();
    tankList = new ArrayList<Tank>();
    blockList = new ArrayList<Block>();
    enemies = new ArrayList<Tank>();
    l.createLevel1();
  }

  void update() {
    for (int i = 0; i < tankList.size(); i++) {
      tankList.get(i).update();
    }

    for (int i = 0; i < enemies.size(); i++) {
      if (PVector.angleBetween(enemies.get(i).dir, tankList.get(0).pos.copy().sub(enemies.get(i).pos).normalize().rotate(PI/2)) >= PVector.angleBetween(enemies.get(i).dir.copy().mult(-1), tankList.get(0).pos.copy().sub(enemies.get(i).pos).normalize().rotate(PI/2))) {
        enemies.get(i).right = true;
        enemies.get(i).left = false;
      } else {
        enemies.get(i).right = false;
        enemies.get(i).left = true;
      }
      if (enemies.get(i).right) {
        if (PVector.angleBetween(enemies.get(i).dir, tankList.get(0).pos.copy().sub(enemies.get(i).pos).normalize().rotate(PI/2))-PVector.angleBetween(enemies.get(i).dir.copy().mult(-1), tankList.get(0).pos.copy().sub(enemies.get(i).pos).normalize().rotate(PI/2)) <= enemies.get(i).rotationForce) {
          enemies.get(i).right = false;
          enemies.get(i).left = false;
        }
      } else {
        if (PVector.angleBetween(enemies.get(i).dir, tankList.get(0).pos.copy().sub(enemies.get(i).pos).normalize().rotate(PI/2))-PVector.angleBetween(enemies.get(i).dir.copy().mult(-1), tankList.get(0).pos.copy().sub(enemies.get(i).pos).normalize().rotate(PI/2)) >= enemies.get(i).rotationForce*-1) {
          enemies.get(i).right = false;
          enemies.get(i).left = false;
        }
      }
    }
    
    if(frameCount%30==0){
      for (int i = 0; i < enemies.size(); i++) {
        /*enemies.get(i).shoot();*/
      }
    }

    for (int i = 0; i < enemies.size(); i++) {
      enemies.get(i).update();
    }

    for (int i = skudList.size(); i > 0; i--) {
      if (skudList.get(i-1).dead) {
        skudList.remove(i-1);
      }
    }



    for (int i = 0; i < tankList.size(); i++) {
      if (tankList.get(i).life <= 0) {
        l.createLevel2();
      }
    }
    render();
  }

  void render() {
    background(255);
    for (int i = 0; i < tankList.size(); i++) {
      tankList.get(i).render();
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
        skudList.add(new Skud(new PVector(this.pos.x + dir.copy().setMag(rad/2+height/120).x, this.pos.y + dir.copy().setMag(rad/2+height/120).y), new PVector(dir.x, dir.y), false));
      }
    };
    enemies.add(enemy1);
  }
}
