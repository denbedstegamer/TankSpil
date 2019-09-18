class Settings {

  Button controls = new Button(width/2-width/3, height/4-height/16, width/6, height/16) {
    @Override
      public void action() {
      gamestate = 4;
    }
  };

  Settings() {
  }

  void display() {
    background(0);
    fill(230);

    controls.display();
    controls.pressed();

    textSize(32);
    textMode(CORNER);
    fill(0);
    text("Controls", width/3-width/8, height/4-height/40);
  }

  void controls() {
    background(0);
    
  }
}
