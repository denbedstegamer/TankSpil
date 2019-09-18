int gamestate = 0;
Tscreen ts;
Settings sett;
Game g;
ArrayList<Skud> skudList;
ArrayList<Wall> mure;

void setup() {
  fullScreen();
  frameRate(60);
  g = new Game();
  ts = new Tscreen();
  sett = new Settings();
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
      g.tank1.up = true;
    }
    if (keyCode == LEFT) {
      g.tank1.left = true;
    }
    if (keyCode == RIGHT) {
      g.tank1.right = true;
    }
    if (keyCode == DOWN) {
      g.tank1.down = true;
    }
  }
  if (key == 'm' || key == 'M') {
    g.tank1.shoot();
  }
  if (key == 'c' || key == 'C') {
    g.tank2.shoot();
  }
  if (key == 'w' || key == 'W') {
    g.tank2.up = true;
  }
  if (key == 's' || key == 'S') {
    g.tank2.down = true;
  }
  if (key == 'a' || key == 'A') {
    g.tank2.left = true;
  }
  if (key == 'd' || key == 'D') {
    g.tank2.right = true;
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      g.tank1.up = false;
    }
    if (keyCode == LEFT) {
      g.tank1.left = false;
    }
    if (keyCode == RIGHT) {
      g.tank1.right = false;
    }
    if (keyCode == DOWN) {
      g.tank1.down = false;
    }
  }

  if (key == 'w' || key == 'W') {
    g.tank2.up = false;
  }
  if (key == 's' || key == 'S') {
    g.tank2.down = false;
  }
  if (key == 'a' || key == 'A') {
    g.tank2.left = false;
  }
  if (key == 'd' || key == 'D') {
    g.tank2.right = false;
  }
}
