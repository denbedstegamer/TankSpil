class Block{
  
  Block(float x1, float y1, float x2, float y2){
    mure.add(new Wall(new PVector(x1, y1), new PVector(x2-x1, 0)));
    mure.add(new Wall(new PVector(x1, y1), new PVector(0, y2-y1)));
    mure.add(new Wall(new PVector(x2, y1), new PVector(0, y2-y1)));
    mure.add(new Wall(new PVector(x1, y2), new PVector(x2-x1, 0)));
  }
}
