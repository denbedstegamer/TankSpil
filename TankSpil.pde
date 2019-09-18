Tank tank1, tank2;
ArrayList<Skud> skudList;
int gamestate = 0;
Tscreen ts;
Settings sett;
ArrayList<Wall> mure;
Block b1;

void setup() {
  fullScreen();
  frameRate(60);
  tank1 = new Tank(new PVector((width*2)/3, (height*2)/3), 3000, width/18, "Player 1");
  tank2 = new Tank(new PVector(width/3, height/3), 3000, width-width/10-300, "Player 2");
  skudList = new ArrayList<Skud>();
  ts = new Tscreen();
  sett = new Settings();
  mure = new ArrayList<Wall>();
  b1 = new Block(150, 150, width-150, height-150);
  mure.add(new Wall(new PVector(150, 150), new PVector(0, height-300)));
  mure.add(new Wall(new PVector(150, 150), new PVector(width-300, 0)));
  mure.add(new Wall(new PVector(150, height-150), new PVector(width-300, 0)));
  mure.add(new Wall(new PVector(width-150, 150), new PVector(0, height-300)));
}

void draw() {
  switch (gamestate) {
  case 1:
    background(255);
    tank1.update();
    tank2.update();
    fill(255, 0, 0);
    tank1.render();
    fill(0, 255, 0);
    tank2.render();
    tank1.lifespan();
    tank2.lifespan();
    ts.escape();

    for (int i = 0; i < skudList.size(); i++) {
      skudList.get(i).shotMoving();
    }
    for (int i = skudList.size(); i > 0; i--) {
      if (skudList.get(i-1).dead) {
        skudList.remove(i-1);
      }
    }
    for (int i = 0; i < mure.size(); i++) {
      mure.get(i).render();
    }
    break;

  case 2:
    ts.displaysettings();
    ts.escape();
    break;

  case 0:
    ts.display();

    break;
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      tank1.up = true;
    }
    if (keyCode == LEFT) {
      tank1.left = true;
    }
    if (keyCode == RIGHT) {
      tank1.right = true;
    }
    if (keyCode == DOWN) {
      tank1.down = true;
    }
  }
  if (key == 'm' || key == 'M') {
    tank1.shoot();
  }
  if (key == 'c' || key == 'C') {
    tank2.shoot();
  }
  if (key == 'w' || key == 'W') {
    tank2.up = true;
  }
  if (key == 's' || key == 'S') {
    tank2.down = true;
  }
  if (key == 'a' || key == 'A') {
    tank2.left = true;
  }
  if (key == 'd' || key == 'D') {
    tank2.right = true;
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      tank1.up = false;
    }
    if (keyCode == LEFT) {
      tank1.left = false;
    }
    if (keyCode == RIGHT) {
      tank1.right = false;
    }
    if (keyCode == DOWN) {
      tank1.down = false;
    }
  }

  if (key == 'w' || key == 'W') {
    tank2.up = false;
  }
  if (key == 's' || key == 'S') {
    tank2.down = false;
  }
  if (key == 'a' || key == 'A') {
    tank2.left = false;
  }
  if (key == 'd' || key == 'D') {
    tank2.right = false;
  }
}
