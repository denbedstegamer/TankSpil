class Button {
  float posx, posy, sizex, sizey;
  boolean pressed;

  Button(float x, float y, float xsize, float ysize) {
    posx = x;
    sizex = xsize;
    posy = y;
    sizey = ysize;
  }
//en funktion til at lave en knap
  void display() {
    pushMatrix();
    rectMode(CORNER);
    rect(posx, posy, sizex, sizey);
    popMatrix();
  }
//en funktion til at lave en knap der kan ændre på nogle integers, bliver brugt til valg af colors
  void display(int r, int g, int b) {
    pushMatrix();
    rectMode(CORNER);
    fill(r, g, b);
    rect(posx, posy, sizex, sizey);
    popMatrix();
  }
//en funktion til at gøre det muligt at klikke på knappen
  void pressed() {
    if (mousePressed==true && mouseX > posx && mouseX < posx +sizex && mouseY > posy && mouseY < posy +sizey) {
      pressed = true;
      action();
    }
  }
//action funktion som bliver ændret inde i de andre classes til at bestemme hvad knappen man laver skal gøre når den bliver trykket
  void action() {
  }
}
