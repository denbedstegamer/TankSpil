class Settings {

  Game g;
  int r, green, b;

  Button controls = new Button(width/2-width/3, height/4-height/16, width/6, height/16) {
    @Override
      public void action() {
      gamestate = 4;
    }
  };

  Settings(Game g) {
    this.g = g;
  }

  Button colors = new Button(width/2-width/3, height/4+height/16, width/6, height/16) {
    @Override
      public void action() {
      gamestate = 5;
    }
  };


  void display() {
    background(0);
    fill(230);

    controls.display();
    controls.pressed();

    colors.display();
    colors.pressed();

    textSize(32);
    fill(0);
    text("Controls", width/3-width/8, height/4-height/40);

    textSize(32);
    fill(0);
    text("Colors", width/3-width/8, height/3+height/32);
  }

  void controls() {
    background(0);
  }

  Button p1c1 = new Button(width/2-width/3, height/4-height/16, width/6, height/16) {
    @Override
      public void action() {
      tankList.get(0).r = 0;
      tankList.get(0).g = 0;
      tankList.get(0).b = 255;
      p1c2.pressed = false;
      p1c3.pressed = false;
    }

    @Override
      public void display(int r, int g, int b) {
      pushMatrix();
      rectMode(CORNER);
      fill(r, g, b);
      rect(posx, posy, sizex, sizey);
      popMatrix();
      if (pressed) {
        noFill();
        stroke(255, 255, 0);
        rect(this.posx, this.posy, this.sizex, this.sizey);
        stroke(1);
      }
    }
  };
  
  Button p1c2 = new Button(width/2-width/3+width/6+width/10, height/4-height/16, width/6, height/16) {
    @Override
      public void action() {
      tankList.get(0).r = 0;
      tankList.get(0).g = 255;
      tankList.get(0).b = 0;
      p1c1.pressed = false;
      p1c3.pressed = false;
    }

    @Override
      public void display(int r, int g, int b) {
      pushMatrix();
      rectMode(CORNER);
      fill(r, g, b);
      rect(posx, posy, sizex, sizey);
      popMatrix();
      if (pressed) {
        noFill();
        stroke(255, 255, 0);
        rect(this.posx, this.posy, this.sizex, this.sizey);
        stroke(1);
      }
    }
  };
  
  Button p1c3 = new Button(width/2-width/3+2*(width/6+width/10), height/4-height/16, width/6, height/16) {
    @Override
      public void action() {
      tankList.get(0).r = 255;
      tankList.get(0).g = 0;
      tankList.get(0).b = 0;
      p1c1.pressed = false;
      p1c2.pressed = false;
    }

    @Override
      public void display(int r, int g, int b) {
      pushMatrix();
      rectMode(CORNER);
      fill(r, g, b);
      rect(posx, posy, sizex, sizey);
      popMatrix();
      if (pressed) {
        noFill();
        stroke(255, 255, 0);
        rect(this.posx, this.posy, this.sizex, this.sizey);
        stroke(1);
      }
    }
  };
  
    Button p2c1 = new Button(width/2-width/3, height/3+height/8, width/6, height/16) {
    @Override
      public void action() {
      tankList.get(1).r = 0;
      tankList.get(1).g = 0;
      tankList.get(1).b = 255;
      p2c2.pressed = false;
      p2c3.pressed = false;
    }

    @Override
      public void display(int r, int g, int b) {
      pushMatrix();
      rectMode(CORNER);
      fill(r, g, b);
      rect(posx, posy, sizex, sizey);
      popMatrix();
      if (pressed) {
        noFill();
        stroke(255, 255, 0);
        rect(this.posx, this.posy, this.sizex, this.sizey);
        stroke(1);
      }
    }
  };
  
  Button p2c2 = new Button(width/2-width/3+width/6+width/10, height/3+height/8, width/6, height/16) {
    @Override
      public void action() {
      tankList.get(1).r = 0;
      tankList.get(1).g = 255;
      tankList.get(1).b = 0;
      p2c1.pressed = false;
      p2c3.pressed = false;
    }

    @Override
      public void display(int r, int g, int b) {
      pushMatrix();
      rectMode(CORNER);
      fill(r, g, b);
      rect(posx, posy, sizex, sizey);
      popMatrix();
      if (pressed) {
        noFill();
        stroke(255, 255, 0);
        rect(this.posx, this.posy, this.sizex, this.sizey);
        stroke(1);
      }
    }
  };
  
  Button p2c3 = new Button(width/2-width/3+2*(width/6+width/10), height/3+height/8, width/6, height/16) {
    @Override
      public void action() {
      tankList.get(1).r = 255;
      tankList.get(1).g = 0;
      tankList.get(1).b = 0;
      p2c1.pressed = false;
      p2c2.pressed = false;
    }

    @Override
      public void display(int r, int g, int b) {
      pushMatrix();
      rectMode(CORNER);
      fill(r, g, b);
      rect(posx, posy, sizex, sizey);
      popMatrix();
      if (pressed) {
        noFill();
        stroke(255, 255, 0);
        rect(this.posx, this.posy, this.sizex, this.sizey);
        stroke(1);
      }
    }
  };

  void colors() {
    background(0);
    
    p1c1.display(0, 0, 255);
    p1c1.pressed();
    p1c2.display(0, 255, 0);
    p1c2.pressed();
    p1c3.display(255, 0, 0);
    p1c3.pressed();
    
    p2c1.display(0, 0, 255);
    p2c1.pressed();
    p2c2.display(0, 255, 0);
    p2c2.pressed();
    p2c3.display(255, 0, 0);
    p2c3.pressed();
    
    ts.escape();
    
    textSize(50);
    textAlign(CENTER);
    fill(250);
    text("player 1", width/4-width/32, height/4-height/12);
    text("player 2", width/4-width/32, height/3+height/10);
  }
}
