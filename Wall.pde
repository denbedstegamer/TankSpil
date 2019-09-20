class Wall{
  PVector pos, dir, norm;
  boolean collision;
  
  //constructer for wall
  Wall(PVector pos, PVector dir, boolean collision){
    this.collision = collision;
    this.pos = pos.copy();
    this.dir = dir.copy();
    norm = this.dir.copy().normalize().rotate(-PI/2);
  }
  
  //funktion der viser muren
  void render(){
    line(pos.x, pos.y, pos.x+dir.x, pos.y+dir.y);
  }
}
