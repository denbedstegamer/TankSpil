class Game {
  int currentLevel;
  float wallWidth = height/100+height/50, gameScreen = height/5, gameWidth = width-2*gameScreen, gameHeight = height-2*gameScreen;
  Level l;
  ArrayList<Tank> enemies;

  Game() {
    mure = new ArrayList<Wall>();
    skudList = new ArrayList<Skud>();
    tankList = new ArrayList<Tank>();
    blockList = new ArrayList<Block>();
    enemies = new ArrayList<Tank>();
    createLevel1();
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
        createLevel2();
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
  
  void createLevel1() {
    ArrayList<Block> b = new ArrayList<Block>();
    tankList.add(new Tank(new PVector(gameScreen+gameWidth/6, gameScreen+gameHeight/6), 3000, width/18, "Player 1", 255, 0, 0, true));
    tankList.add(new Tank(new PVector(gameScreen+gameWidth/6, gameScreen+gameHeight*5/6), 3000, width-width/10-300, "Player 2", 0, 255, 0, true));
    
    createEnemy(new PVector(width-gameScreen-gameWidth/6, gameScreen+gameHeight/6));
    createEnemy(new PVector(width-gameScreen-gameWidth/6, gameScreen+gameHeight*3/6));
    createEnemy(new PVector(width-gameScreen-gameWidth/6, gameScreen+gameHeight*5/6));
    
    b.add(new Block(gameScreen, gameScreen, width-gameScreen, gameScreen+wallWidth));
    b.add(new Block(gameScreen, gameScreen, gameScreen+wallWidth, height-gameScreen));
    b.add(new Block(gameScreen, height-gameScreen, width-gameScreen, height-gameScreen-wallWidth));
    b.add(new Block(width-gameScreen-wallWidth, gameScreen, width-gameScreen, height-gameScreen));
    
    b.add(new Block(gameScreen+gameWidth/3, gameScreen, gameScreen+gameWidth/3+wallWidth, gameScreen+gameHeight/3));
    b.add(new Block(gameScreen+gameWidth*2/3, gameScreen, gameScreen+gameWidth*2/3+wallWidth, gameScreen+gameHeight/3));
    b.add(new Block(gameScreen+gameWidth*2/3, gameScreen+gameHeight-gameHeight/3, gameScreen+gameWidth*2/3+wallWidth, gameScreen+gameHeight));
    b.add(new Block(gameScreen+gameWidth/3, gameScreen+gameHeight-gameHeight/3, gameScreen+gameWidth/3+wallWidth, gameScreen+gameHeight));
    
    l = new Level(b);
    currentLevel = 1;
  }

  void createLevel2() {
    l.removeAllBlocks();
    ArrayList<Block> b = new ArrayList<Block>();
    b.add(new Block(gameScreen, gameScreen, width-gameScreen, gameScreen+wallWidth));
    b.add(new Block(gameScreen, gameScreen, gameScreen+wallWidth, height-gameScreen));
    b.add(new Block(gameScreen, height-gameScreen, width-gameScreen, height-gameScreen-wallWidth));
    b.add(new Block(width-gameScreen-wallWidth, gameScreen, width-gameScreen, height-gameScreen));
    
    b.add(new Block(gameScreen+gameWidth/7, gameScreen+));
    
    l = new Level(b);
    currentLevel = 2;
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
