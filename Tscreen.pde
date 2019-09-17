class Tscreen {

  Button game1pvp = new Button(width/2-width/6, height/4-height/16, width/3, height/8) {
    @Override
      public void action() {
      gamestate = 1;
    }
  };

  Tscreen() {
  }

  void display() {
    background(0);
    fill(160);
    game1pvp.display();
    game1pvp.pressed();
  }
}
