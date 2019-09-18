class Button{
  float posx, posy, sizex, sizey;
  
  Button(float x, float y, float xsize, float ysize){
      posx = x;
      sizex = xsize;
      posy = y;
      sizey = ysize;
  }
  
   void display(){
       pushMatrix();
       rectMode(CORNER);
       rect(posx, posy, sizex, sizey);
       popMatrix();
   }
   
   void display(int r,int g, int b){
       pushMatrix();
       rectMode(CORNER);
       fill(r, g, b);
       rect(posx, posy, sizex, sizey);
       popMatrix();
   }
   
   void pressed(){
      if(mousePressed==true && mouseX > posx && mouseX < posx +sizex && mouseY > posy && mouseY < posy +sizey){
         action();
      }
   }
   
   void action(){
     
   }
}
