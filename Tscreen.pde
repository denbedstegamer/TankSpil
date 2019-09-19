class Tscreen {

  Button game1pvp = new Button(width/2-width/6, height/4-height/16, width/3, height/8) {
    
    @Override
      public void action() {
      gamestate = 1;
    }
  };
  
  Button setting = new Button(width/2-width/6, height/3, width/3, height/8) {
    @Override
      public void action() {
      gamestate = 2;
    }
  };
  
  Button escape = new Button(width-width/8-10, height-height/10-10, width/8, height/10) {
    @Override
      public void action() {
      gamestate = 0;
    }
  };

  Tscreen() {
  }

  void display() {
    background(0);
    fill(160);
    game1pvp.display();
    game1pvp.pressed();
    
    setting.display();
    setting.pressed();
    
    textSize(32);
    textMode(CENTER);
    fill(0);
    text("Co-op Adventure", width/2-width/16, height/4);
    
    textSize(32);
    fill(0);
    text("Settings", width/2-width/24, height/3+height/16);
  }
  
  void escape(){ 
    fill(230);
    escape.display();
    escape.pressed();
    
    textSize(32);
    fill(0);
    text("Escape", width-width/10, height-height/20);
    
  }
}
