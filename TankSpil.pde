Tank tank1, tank2;
ArrayList<Skud> skudList;
int gamestate = 0;
Tscreen ts;
ArrayList<Wall> mure;

void setup() {
  fullScreen();
  frameRate(60);
  tank1 = new Tank(new PVector((width*2)/3, (height*2)/3), 600);
  tank2 = new Tank(new PVector(width/3, height/3), 600);
  skudList = new ArrayList<Skud>();
  ts = new Tscreen();
  mure = new ArrayList<Wall>();
  mure.add(new Wall(new PVector(250,250), new PVector(0,height-500)));
  mure.add(new Wall(new PVector(250,250), new PVector(width-500,0)));
  mure.add(new Wall(new PVector(250,height-250), new PVector(width-500,0)));
  mure.add(new Wall(new PVector(width-250,250), new PVector(0,height-500)));
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
