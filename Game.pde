class Game {
  int currentLevel = 1;
  Level l = new Level(new ArrayList<Block>(), this);
  ArrayList<Tank> enemies;
  boolean coop;
//en boolean som starter level 1 hvis coop knappen er blevet trykket, ellers starter den pvp når den bliver kaldt fra pvp knappen
  Game(boolean coop) {
    this.coop = coop;
    mure = new ArrayList<Wall>();
    skudList = new ArrayList<Skud>();
    tankList = new ArrayList<Tank>();
    blockList = new ArrayList<Block>();
    enemies = new ArrayList<Tank>();
    if (coop) {
      l = l.createLevel(1);
    } else {
      l = l.createLevel(0);
    }
  }
//funktionen der tjekker hvordan det går i spillet, om man har mistet liv eller dræbt de andre
//den opdaterer gamestate til en vilkårlig end screen når målene er opfyldt
  void update() {
    if (coop) {
      for (int i = 0; i < tankList.size(); i++) {
        if (tankList.get(i).life > 0) {
          tankList.get(i).update();
        }
      }
    } else {
      for (int i = 0; i < tankList.size(); i++) {
        tankList.get(i).update();
      }
    }

    if (coop) {
      aim();
    }

    if (frameCount%30==0) {
      for (int i = 0; i < enemies.size(); i++) {
        enemies.get(i).shoot(false);
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

    if (coop) {
      if (tankList.get(0).life <= 0 && tankList.get(1).life <= 0) {
        gamestate = 6;
      }

      if (enemies.size() == 0) {
        if (currentLevel != 3) {
          l.createLevel(currentLevel+1);
        } else {
          gamestate = 7;
        }
      }
    } else {
      if (tankList.get(0).life <= 0){
        gamestate = 8;
      }
      if(tankList.get(1).life <= 0) {
        gamestate = 9;
      }
    }
    render();
  }
  
  //giver modstanderene mulighed for at sigte efter spillerne for at gøre det lidt sværre
  void aim() {
    Tank t = new Tank(new PVector(), 0, 0, "Player 1", 0, 0, 0, 0);
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

//funktionen der starter levelet
  void render() {
    background(255);
    textAlign(CENTER);
    if (currentLevel != 0) {
      text(currentLevel, width/2, height/16);
    } else {
      text("PvP", width/2, height/16);
    }
    for (int i = 0; i < tankList.size(); i++) {
      if (tankList.get(i).life > 0) {
        tankList.get(i).render();
      }
      tankList.get(i).lifespan();
    }
    for (int i = 0; i < enemies.size(); i++) {
      enemies.get(i).render();
    }
    for (int i = 0; i < blockList.size(); i++) {
      blockList.get(i).render();
    }
    for (int i = 0; i < mure.size(); i++) {
      mure.get(i).render();
    }
    for (int i = 0; i < skudList.size(); i++) {
      skudList.get(i).update();
    }
    ts.escape();
  }

//en funktion der bliver brugt til at spawne modstanderene og fjerne dem igen hvis de bliver skudt af en spiller
  void createEnemy(PVector pos) {
    Tank enemy1 = new Tank(pos, 3000, width-width/10-300, "Player 2", 40, 40, 40, 1) {
      @Override
        public void shoot(boolean shotFromPlayer) {
        skudList.add(new Skud(new PVector(this.pos.x, this.pos.y), new PVector(dir.x, dir.y), shotFromPlayer));
      }
    };
    enemies.add(enemy1);
  }

  Tank returnEnemy(PVector pos) {
    Tank enemy1 = new Tank(pos, 3000, width-width/10-300, "Player 2", 0, 255, 0, 2) {
      @Override
        public void shoot(boolean shotFromPlayer) {
        if (lastShot <= 0) {
          skudList.add(new Skud(new PVector(this.pos.x, this.pos.y), new PVector(dir.x, dir.y), shotFromPlayer));
          lastShot = 15;
        }
      }
    };
    return enemy1;
  }
}
