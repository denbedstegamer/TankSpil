class Tscreen {

  //knapper til titlescreen gamestaten, en til coop, pvp, settings og escape. De skifter hver især til de tisvarende gamestates
  //starter et nyt spil når den bliver trykket i stedet for at fortsætte på det gamle
  Button coop = new Button(width/2-width/6, height/4, width/3, height/8) {
    
    @Override
      public void action() {
      gamestate = 1;
      g = new Game(true);
    }
  };
  
  Button pvp = new Button(width/2-width/6, height/4+height/8+height/50, width/3, height/8) {
    
    @Override
      public void action() {
      gamestate = 3;
      g = new Game(false);
    }
  };
  
  Button setting = new Button(width/2-width/6, height/4+height/8*2+height/50*2, width/3, height/8) {
    @Override
      public void action() {
      gamestate = 2;
    }
  };
  //escape knappen bliver brugt i næsten alle gamestates så man altid kan komme tilbage til titlescreen
  Button escape = new Button(width-width/8-10, height-height/10-10, width/8, height/10) {
    @Override
      public void action() {
      gamestate = 0;
    }
  };

  Tscreen() {
  }
//funktionen der viser knapperne der er i title screen, som er i gamestate 0
  void display() {
    background(0);
    fill(230);
    coop.display();
    coop.pressed();
    pvp.display();
    pvp.pressed();
    
    setting.display();
    setting.pressed();
    
    textSize(55);
    textAlign(CENTER);
    fill(0);
    text("Co-op Adventure", width/2, height/4+height/16+height/64);
    text("Pvp", width/2, height/2-height/32);
    text("Settings", width/2, height/2-height/32+height/8+height/64);
  }
  //escape knappen/funktionen bliver brugt i næsten alle gamestates så man altid kan komme tilbage til titlescreen
  void escape(){ 
    fill(230);
    escape.display();
    escape.pressed();
    
    textAlign(CENTER);
    textSize(32);
    fill(0);
    text("Escape", width-width/20-height/40, height-height/20);
    
  }
}
