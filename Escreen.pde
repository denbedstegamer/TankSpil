class Escreen {
//en knap til at spille igen, den sender en tilbage til case 0 i gamestate, hvilket er title screen
  Button playagain = new Button(width/2-width/6, height-height/4, width/3, height/8) {
    @Override
      public void action() {
      gamestate = 0;
    }
  };
  
  Escreen() {
  }
  //end screen til når begge spillere dør i coop mode
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
    text("play again", width/2, height-height/6);
    
  }
  //end screen til når coop mode bliver vundet
  void enddisplay(){
    background(0);
    fill(127);
    playagain.display();
    playagain.pressed();
    
    textAlign(CENTER);
    textSize(200);
    fill(255,255,0);
    text("YOU WIN", width/2, height/2);
    
    textSize(75);
    fill(250);
    text("play again", width/2, height-height/6);
  }
  //end screen til vinderen af pvp mode
  void enddisplay(String winner){
    background(0);
    fill(127);
    playagain.display();
    playagain.pressed();
    
    textAlign(CENTER);
    textSize(200);
    fill(255,255,0);
    text("Player " + winner + " WINS", width/2, height/2);
    
    textSize(75);
    fill(250);
    text("play again", width/2, height-height/6);
  }
  
}
