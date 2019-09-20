class Escreen {

  Button playagain = new Button(width/2-width/6, height/4+height/3, width/3, height/8) {
    @Override
      public void action() {
      gamestate = 0;
    }
  };
  
  Escreen() {
  }
  
  void deathdisplay(){
    background(0);
    fill(127);
    playagain.display();
    playagain.pressed();
    
    textAlign(CENTER);
    textSize(200);
    fill(255,0,0);
    text("YOU DIED", width/2, height/2);
    
    textSize(75);
    fill(250);
    text("play again", width/2, height/2+height/6);
    
  }
  
  void enddisplay(){
    background(100);
  }
  
}
