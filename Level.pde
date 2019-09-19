class Level {
  
  float wallWidth = height/100+height/50, gameScreen = height/5, gameWidth = width-2*gameScreen, gameHeight = height-2*gameScreen;

  Level(ArrayList<Block> b) {
    for (int i = 0; i < b.size(); i++) {
      blockList.add(b.get(i));
    }
  }

  void removeAllBlocks() {
    for (int i = blockList.size(); i > 0; i--) {
      blockList.remove(i-1);
    }
    for (int i = mure.size(); i > 0; i--) {
      mure.remove(i-1);
    }
  }
  
  Level createLevel1() {
    ArrayList<Block> b = new ArrayList<Block>();
    tankList.add(new Tank(new PVector(gameScreen+gameWidth/6, gameScreen+gameHeight/6), 3000, width/18, "Player 1", 255, 0, 0, true));
    tankList.add(new Tank(new PVector(gameScreen+gameWidth/6, gameScreen+gameHeight*5/6), 3000, width-width/10-300, "Player 2", 0, 255, 0, true));
    
    g.createEnemy(new PVector(width-gameScreen-gameWidth/6, gameScreen+gameHeight/6));
    g.createEnemy(new PVector(width-gameScreen-gameWidth/6, gameScreen+gameHeight*3/6));
    g.createEnemy(new PVector(width-gameScreen-gameWidth/6, gameScreen+gameHeight*5/6));
    
    b.add(new Block(gameScreen, gameScreen, width-gameScreen, gameScreen+wallWidth));
    b.add(new Block(gameScreen, gameScreen, gameScreen+wallWidth, height-gameScreen));
    b.add(new Block(gameScreen, height-gameScreen, width-gameScreen, height-gameScreen-wallWidth));
    b.add(new Block(width-gameScreen-wallWidth, gameScreen, width-gameScreen, height-gameScreen));
    
    b.add(new Block(gameScreen+gameWidth/3, gameScreen, gameScreen+gameWidth/3+wallWidth, gameScreen+gameHeight/3));
    b.add(new Block(gameScreen+gameWidth*2/3, gameScreen, gameScreen+gameWidth*2/3+wallWidth, gameScreen+gameHeight/3));
    b.add(new Block(gameScreen+gameWidth*2/3, gameScreen+gameHeight-gameHeight/3, gameScreen+gameWidth*2/3+wallWidth, gameScreen+gameHeight));
    b.add(new Block(gameScreen+gameWidth/3, gameScreen+gameHeight-gameHeight/3, gameScreen+gameWidth/3+wallWidth, gameScreen+gameHeight));
    
    g.currentLevel = 1;
    return new Level(b);
  }

  Level createLevel2() {
    l.removeAllBlocks();
    ArrayList<Block> b = new ArrayList<Block>();
    b.add(new Block(gameScreen, gameScreen, width-gameScreen, gameScreen+wallWidth));
    b.add(new Block(gameScreen, gameScreen, gameScreen+wallWidth, height-gameScreen));
    b.add(new Block(gameScreen, height-gameScreen, width-gameScreen, height-gameScreen-wallWidth));
    b.add(new Block(width-gameScreen-wallWidth, gameScreen, width-gameScreen, height-gameScreen));
    
    b.add(new Block(gameScreen+gameWidth/7, gameScreen+));
    g.currentLevel = 2;
    return new Level(b);
  }
}
