class Settings {

  Game g;
  int r, green, b;
  PImage img;

  Button controls = new Button(width/2-width/6, height/4, width/3, height/8) {
    @Override
      public void action() {
      gamestate = 4;
    }
  };

  Settings(Game g) {
    this.g = g;
  }

  Button colors = new Button(width/2-width/6, height/4+height/8+height/50, width/3, height/8) {
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

    textSize(55);
    textAlign(CENTER);
    fill(0);
    text("Controls", width/2, height/4+height/16+height/64);
    text("Colors", width/2, height/2-height/32);
  }

  void controls() {
    background(0);
    img = loadImage("TankSpilControls.png");
    image(img, 0, 0, width, height);
    
  }

  Button p1c1 = new Button(width/2-width/3, height/4-height/16, width/6, height/16) {
    @Override
      public void action() {
      r1 = 0;
      g1 = 0;
      b1 = 255;
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
      r1 = 0;
      g1 = 255;
      b1 = 0;
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
      r1 = 255;
      g1 = 0;
      b1 = 0;
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
      r2 = 0;
      g2 = 0;
      b2 = 255;
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
      r2 = 0;
      g2 = 255;
      b2 = 0;
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
      r2 = 255;
      g2 = 0;
      b2 = 0;
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
