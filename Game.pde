class Game {
  int currentLevel;
  Level l;

  Game() {
    mure = new ArrayList<Wall>();
    skudList = new ArrayList<Skud>();
    tankList = new ArrayList<Tank>();
    blockList = new ArrayList<Block>();
    tankList.add(new Tank(new PVector((width*2)/3, (height*2)/3), 3000, width/18, "Player 1", 255, 0, 0));
    tankList.add(new Tank(new PVector(width/3, height/3), 3000, width-width/10-300, "Player 2", 0, 255, 0));
    createLevel1();
  }

  void update() {
    for (int i = 0; i < tankList.size(); i++) {
      tankList.get(i).update();
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
    b.add(new Block(150, 150, width-150, height-150));
    l = new Level(b);
    currentLevel = 1;
  }

  void createLevel2() {
    l.removeAllBlocks();
    ArrayList<Block> b = new ArrayList<Block>();
    b.add(new Block(0, 0, width-150, height-150));
    b.add(new Block(10, 10, width-160, height-160));
    l = new Level(b);
    currentLevel = 2;
  }
}
