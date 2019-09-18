class Wall{
  PVector pos, dir, norm;
  
  Wall(PVector pos, PVector dir){
    this.pos = pos.copy();
    this.dir = dir.copy();
    norm = this.dir.copy().normalize().rotate(-PI/2);
  }
  
  void render(){
    line(pos.x, pos.y, pos.x+dir.x, pos.y+dir.y);
  }
}
