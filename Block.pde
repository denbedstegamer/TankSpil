class Block{
  
  //værdierne til at lave nye mure/vægge
  float x, y, xl, yl;
  
  Block(float x1, float y1, float x2, float y2, boolean col1, boolean col2, boolean col3, boolean col4){
    x = x1;
    y = y1;
    xl = x2-x;
    yl = y2-y;
    mure.add(new Wall(new PVector(x1, y1), new PVector(x2-x1, 0), col1));
    mure.add(new Wall(new PVector(x1, y1), new PVector(0, y2-y1), col2));
    mure.add(new Wall(new PVector(x2, y1), new PVector(0, y2-y1), col3));
    mure.add(new Wall(new PVector(x1, y2), new PVector(x2-x1, 0), col4));
  }
  
  //en funktion til at tegne murene/væggene
  void render(){
    rectMode(CORNER);
    fill(0);
    stroke(1);
    rect(x, y, xl, yl);
  }
}
