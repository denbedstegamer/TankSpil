int gamestate = 0;
Tscreen ts;
Escreen es;
Settings sett;
Game g;
ArrayList<Skud> skudList;
ArrayList<Wall> mure;
ArrayList<Tank> tankList;
ArrayList<Block> blockList;
int r1 = 255, g1, b1, r2, g2 = 255, b2;

void setup() {
  fullScreen();
  frameRate(60);
  g = new Game(true);
  ts = new Tscreen();
  es = new Escreen();
  sett = new Settings(g);
}

void draw() {
  // Gamestate cases som bliver kaldt i de andre classes
  switch (gamestate) {
  case 0: //title screen
    ts.display();
    break;

  case 1: //coop mode
    g.update();
    break;

  case 2: //settings skærm
    sett.display();
    ts.escape();
    break;

  case 3: //pvp mode
    g.update();
    break;

  case 4: //controls fra settings skærmen
    sett.controls();
    ts.escape();
    break;

  case 5: //colors fra settings skærmen
    sett.colors();
    break;

  case 6: //gamestate for når man dør i coop mode
    es.deathdisplay();
    break;
  
  case 7: //end screen til når man vinder coop mode
    es.enddisplay();
    break;
    
  case 8: //end screen til når player 2 vinder
    es.enddisplay("2");
    break;
  
  case 9: //end screen til når player 1 vinder
    es.enddisplay("1");
    break;
  }
}


//KeyPressed og KeyReleased til at kunne bevæge de tanks der bliver lavet på samme tid.
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      tankList.get(0).up = true;
    }
    if (keyCode == LEFT) {
      tankList.get(0).left = true;
    }
    if (keyCode == RIGHT) {
      tankList.get(0).right = true;
    }
    if (keyCode == DOWN) {
      tankList.get(0).down = true;
    }
  }

  if ((key == 'm' || key == 'M') && tankList.get(0).life > 0) {
    tankList.get(0).shoot(tankList.get(0).player);
  }
  if ((key == 'c' || key == 'C') && tankList.get(1).life > 0) {
    tankList.get(1).shoot(tankList.get(1).player);
  }
  if (key == 'w' || key == 'W') {
    tankList.get(1).up = true;
  }
  if (key == 's' || key == 'S') {
    tankList.get(1).down = true;
  }
  if (key == 'a' || key == 'A') {
    tankList.get(1).left = true;
  }
  if (key == 'd' || key == 'D') {
    tankList.get(1).right = true;
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      tankList.get(0).up = false;
    }
    if (keyCode == LEFT) {
      tankList.get(0).left = false;
    }
    if (keyCode == RIGHT) {
      tankList.get(0).right = false;
    }
    if (keyCode == DOWN) {
      tankList.get(0).down = false;
    }
  }

  if (key == 'w' || key == 'W') {
    tankList.get(1).up = false;
  }
  if (key == 's' || key == 'S') {
    tankList.get(1).down = false;
  }
  if (key == 'a' || key == 'A') {
    tankList.get(1).left = false;
  }
  if (key == 'd' || key == 'D') {
    tankList.get(1).right = false;
  }
}
