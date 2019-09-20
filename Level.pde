class Level {

  Game g;
  float wallWidth = height/50, gameScreen = height/5, gameWidth = width-2*gameScreen, gameHeight = height-2*gameScreen;

  Level(ArrayList<Block> b, Game g) {
    this.g = g;
    for (int i = 0; i < b.size(); i++) {
      blockList.add(b.get(i));
    }
  }
//Genstarter værdier
  void reset() {
    for (int i = blockList.size(); i > 0; i--) {
      blockList.remove(i-1);
    }
    for (int i = mure.size(); i > 0; i--) {
      mure.remove(i-1);
    }
    for (int i = skudList.size(); i > 0; i--) {
      skudList.remove(i-1);
    }
    for (int i = tankList.size(); i > 0; i--) {
      tankList.remove(i-1);
    }
    for (int i = g.enemies.size(); i > 0; i--) {
      g.enemies.remove(i-1);
    }
  }
//skifter mellem levels når man vinder det forrige
  Level createLevel(int i) {
    switch(i) {
    case 0:
      return createLevel0();

    case 1:
      return createLevel1();

    case 2:
      return createLevel2();

    case 3:
      return createLevel3();

    default:
      return createLevel1();
    }
  }

//Laver de forskellige levels på de forskellige tidspunkter, bruger de forskellige funktioner fra de andre classes for at angive hvor
//de forskellige ting, som tanks, modstandere og vægge skal være i de forskellige levels.
  Level createLevel1() {
    reset();
    ArrayList<Block> b = new ArrayList<Block>();
    tankList.add(new Tank(new PVector(gameScreen+gameWidth/6, gameScreen+gameHeight*5/12), 3000, width/18, "Player 1", r1, g1, b1, 0));
    tankList.add(new Tank(new PVector(gameScreen+gameWidth/6, gameScreen+gameHeight*7/12), 3000, width-width/10-300, "Player 2", r2, g2, b2, 0));

    g.createEnemy(new PVector(width-gameScreen-gameWidth/6, gameScreen+gameHeight/6));
    g.createEnemy(new PVector(width-gameScreen-gameWidth/6, gameScreen+gameHeight*3/6));
    g.createEnemy(new PVector(width-gameScreen-gameWidth/6, gameScreen+gameHeight*5/6));

    b.add(new Block(gameScreen, gameScreen, width-gameScreen, gameScreen+wallWidth, false, false, false, true));
    b.add(new Block(gameScreen, gameScreen, gameScreen+wallWidth, height-gameScreen, false, false, true, false));
    b.add(new Block(gameScreen, height-gameScreen-wallWidth, width-gameScreen, height-gameScreen, true, false, false, false));
    b.add(new Block(width-gameScreen-wallWidth, gameScreen, width-gameScreen, height-gameScreen, false, true, false, false));

    b.add(new Block(gameScreen+gameWidth/3, gameScreen, gameScreen+gameWidth/3+wallWidth, gameScreen+gameHeight/3, false, true, true, true));
    b.add(new Block(gameScreen+gameWidth*2/3, gameScreen, gameScreen+gameWidth*2/3+wallWidth, gameScreen+gameHeight/3, false, true, true, true));
    b.add(new Block(gameScreen+gameWidth*2/3, gameScreen+gameHeight-gameHeight/3, gameScreen+gameWidth*2/3+wallWidth, gameScreen+gameHeight, true, true, true, false));
    b.add(new Block(gameScreen+gameWidth/3, gameScreen+gameHeight-gameHeight/3, gameScreen+gameWidth/3+wallWidth, gameScreen+gameHeight, true, true, true, false));

    g.currentLevel = 1;
    return new Level(b, g);
  }

  Level createLevel2() {
    reset();
    ArrayList<Block> b = new ArrayList<Block>();
    tankList.add(new Tank(new PVector(gameScreen+gameWidth/6, gameScreen+gameHeight*5/12), 3000, width/18, "Player 1", r1, g1, b1, 0));
    tankList.add(new Tank(new PVector(gameScreen+gameWidth/6, gameScreen+gameHeight*7/12), 3000, width-width/10-300, "Player 2", r2, g2, b2, 0));

    g.createEnemy(new PVector(width-gameScreen-gameWidth/6, gameScreen+gameHeight/6));
    g.createEnemy(new PVector(width-gameScreen-gameWidth*2/6, gameScreen+gameHeight*3/6));
    g.createEnemy(new PVector(width-gameScreen-gameWidth/6, gameScreen+gameHeight*5/6));
    g.createEnemy(new PVector(width-gameScreen-gameWidth*3/6, gameScreen+gameHeight*3/6));

    b.add(new Block(gameScreen, gameScreen, width-gameScreen, gameScreen+wallWidth, false, false, false, true));
    b.add(new Block(gameScreen, gameScreen, gameScreen+wallWidth, height-gameScreen, false, false, true, false));
    b.add(new Block(gameScreen, height-gameScreen-wallWidth, width-gameScreen, height-gameScreen, true, false, false, false));
    b.add(new Block(width-gameScreen-wallWidth, gameScreen, width-gameScreen, height-gameScreen, false, true, false, false));

    b.add(new Block(gameScreen+gameWidth/7, gameScreen+gameHeight/3, gameScreen+gameWidth*2/7, gameScreen+gameHeight/3+wallWidth, true, true, true, true));
    b.add(new Block(gameScreen+gameWidth/7, gameScreen+gameHeight*2/3, gameScreen+gameWidth*2/7, gameScreen+gameHeight*2/3+wallWidth, true, true, true, true));
    b.add(new Block(gameScreen+gameWidth*3/7, gameScreen, gameScreen+gameWidth*4/7, gameScreen+gameHeight/3+wallWidth, false, true, true, true));
    b.add(new Block(gameScreen+gameWidth*3/7, gameScreen+gameHeight*2/3, gameScreen+gameWidth*4/7, gameScreen+gameHeight, true, true, true, false));
    b.add(new Block(gameScreen+gameWidth*5/7, gameScreen+gameHeight/3, gameScreen+gameWidth*6/7, gameScreen+gameHeight/3+wallWidth, true, true, true, true));
    b.add(new Block(gameScreen+gameWidth*5/7, gameScreen+gameHeight*2/3, gameScreen+gameWidth*6/7, gameScreen+gameHeight*2/3+wallWidth, true, true, true, true));

    g.currentLevel = 2;
    return new Level(b, g);
  }

  Level createLevel3() {
    reset();
    ArrayList<Block> b = new ArrayList<Block>();
    tankList.add(new Tank(new PVector(gameScreen+gameWidth*1/3, gameScreen+gameHeight*1/4), 3000, width/18, "Player 1", r1, g1, b1, 0));
    tankList.add(new Tank(new PVector(gameScreen+gameWidth*2/3, gameScreen+gameHeight*3/4), 3000, width-width/10-300, "Player 2", r2, g2, b2, 0));

    g.createEnemy(new PVector(width-gameScreen-gameWidth/2, gameScreen+gameHeight*1/10));
    g.createEnemy(new PVector(width-gameScreen-gameWidth/2, gameScreen+gameHeight*9/10));
    g.createEnemy(new PVector(width-gameScreen-gameWidth*1/10, gameScreen+gameHeight/2));
    g.createEnemy(new PVector(width-gameScreen-gameWidth*9/10, gameScreen+gameHeight/2));
    g.createEnemy(new PVector(width-gameScreen-gameWidth*2/3, gameScreen+gameHeight*3/4));
    g.createEnemy(new PVector(width-gameScreen-gameWidth*1/3, gameScreen+gameHeight*1/4));

    b.add(new Block(gameScreen, gameScreen, width-gameScreen, gameScreen+wallWidth, false, false, false, true));
    b.add(new Block(gameScreen, gameScreen, gameScreen+wallWidth, height-gameScreen, false, false, true, false));
    b.add(new Block(gameScreen, height-gameScreen-wallWidth, width-gameScreen, height-gameScreen, true, false, false, false));
    b.add(new Block(width-gameScreen-wallWidth, gameScreen, width-gameScreen, height-gameScreen, false, true, false, false));

    b.add(new Block(gameScreen+gameWidth*3/7-wallWidth, gameScreen+gameHeight*1/7, gameScreen+gameWidth*3/7, gameScreen+gameHeight*3/7, true, true, true, false));
    b.add(new Block(gameScreen+gameWidth*4/7, gameScreen+gameHeight*1/7, gameScreen+gameWidth*4/7+wallWidth, gameScreen+gameHeight*3/7, true, true, true, false));
    b.add(new Block(gameScreen+gameWidth*1/7, gameScreen+gameHeight*3/7-wallWidth, gameScreen+gameWidth*3/7, gameScreen+gameHeight*3/7, true, true, false, true));
    b.add(new Block(gameScreen+gameWidth*4/7, gameScreen+gameHeight*3/7-wallWidth, gameScreen+gameWidth*6/7, gameScreen+gameHeight*3/7, true, false, true, true));
    b.add(new Block(gameScreen+gameWidth*3/7-wallWidth, gameScreen+gameHeight*4/7, gameScreen+gameWidth*3/7, gameScreen+gameHeight*6/7, false, true, true, true));
    b.add(new Block(gameScreen+gameWidth*4/7, gameScreen+gameHeight*4/7, gameScreen+gameWidth*4/7+wallWidth, gameScreen+gameHeight*6/7, false, true, true, true));
    b.add(new Block(gameScreen+gameWidth*1/7, gameScreen+gameHeight*4/7, gameScreen+gameWidth*3/7, gameScreen+gameHeight*4/7+wallWidth, true, false, true, true));
    b.add(new Block(gameScreen+gameWidth*4/7, gameScreen+gameHeight*4/7, gameScreen+gameWidth*6/7, gameScreen+gameHeight*4/7+wallWidth, true, false, true, true));

    g.currentLevel = 3;
    return new Level(b, g);
  }

  Level createLevel0() {
    reset();
    ArrayList<Block> b = new ArrayList<Block>();
    b.add(new Block(gameScreen, gameScreen, width-gameScreen, gameScreen+wallWidth, false, false, false, true));
    b.add(new Block(gameScreen, gameScreen, gameScreen+wallWidth, height-gameScreen, false, false, true, false));
    b.add(new Block(gameScreen, height-gameScreen-wallWidth, width-gameScreen, height-gameScreen, true, false, false, false));
    b.add(new Block(width-gameScreen-wallWidth, gameScreen, width-gameScreen, height-gameScreen, false, true, false, false));
    
    tankList.add(new Tank(new PVector(gameScreen+gameWidth*1/3, gameScreen+gameHeight*1/4), 3000, width/18, "Player 1", r1, g1, b1, 0));
    tankList.add(g.returnEnemy(new PVector(width/2, height/2)));

    g.currentLevel = 0;
    return new Level(b, g);
  }
}
