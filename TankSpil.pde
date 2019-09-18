int gamestate = 0;
Tscreen ts;
Settings sett;
Game g;
ArrayList<Skud> skudList;
ArrayList<Wall> mure;
ArrayList<Tank> tankList;
ArrayList<Block> blockList;

void setup() {
  fullScreen();
  frameRate(60);
  g = new Game();
  ts = new Tscreen();
  sett = new Settings(g);
}

void draw() {
  switch (gamestate) {
  case 0:
    ts.display();
    break;

  case 1:
    g.update();
    break;

  case 2:
    sett.display();
    ts.escape();
    break;

  case 3:

    break;

  case 4:
    sett.controls();
    ts.escape();
    break;
    
  case 5:
    sett.colors();
    break;
  }
}

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
  if (key == 'm' || key == 'M') {
    tankList.get(0).shoot();
  }
  if (key == 'c' || key == 'C') {
    tankList.get(1).shoot();
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
