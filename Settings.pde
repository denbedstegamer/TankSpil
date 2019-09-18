class Settings {
  
  int r, g, b;

  Button controls = new Button(width/2-width/3, height/4-height/16, width/6, height/16) {
    @Override
      public void action() {
      gamestate = 4;
    }
  };

  Settings() {
  }
  
  Button colors = new Button(width/2-width/3, height/4+height/16, width/6, height/16) {
    @Override
      public void action() {
      gamestate = 5;
    }
  };


  void display() {
    background(0);
    fill(230);

    controls.display();
    controls.pressed();
    
    colors.display();
    colors.pressed();

    textSize(32);
    fill(0);
    text("Controls", width/3-width/8, height/4-height/40);
    
    textSize(32);
    fill(0);
    text("Colors", width/3-width/8, height/3+height/32);
  }

  void controls() {
    background(0);
    
  }
  
  Button p1c1 = new Button(width/2-width/3, height/4+height/16, width/6, height/16) {
    @Override
      public void action() {
      r = 255;
      g = 0;
      b = 0;
    }
  };
  
  void colors() {
    background(0);
    p1c1.display(255, 0, 0);
    p1c1.pressed();
    ts.escape();
  }
}
