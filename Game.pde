class Game {
  public Tank tank1, tank2;
  Block b1;
  int r;
  
  Game(){
    mure = new ArrayList<Wall>();
    skudList = new ArrayList<Skud>();
    tank1 = new Tank(new PVector((width*2)/3, (height*2)/3), 3000, width/18, "Player 1", 255, 0, 0);
    tank2 = new Tank(new PVector(width/3, height/3), 3000, width-width/10-300, "Player 2", 0, 255, 0);
    b1 = new Block(150, 150, width-150, height-150);
  }

  void update() {
    tank1.update();
    tank2.update();
    
    for (int i = skudList.size(); i > 0; i--) {
      if (skudList.get(i-1).dead) {
        skudList.remove(i-1);
      }
    }
    render();
  }

  void render() {
    background(255);
    tank1.render();
    tank2.render();
    tank1.lifespan();
    tank2.lifespan();
    for (int i = 0; i < mure.size(); i++) {
      mure.get(i).render();
    }
    for (int i = 0; i < skudList.size(); i++) {
      skudList.get(i).update();
    }
    ts.escape();
  }
}
