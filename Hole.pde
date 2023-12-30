class Hole{
  PVector pos;
  float r;
  
  public Hole(PVector pos, float r){
    this.pos = pos;
    this.r = r;
  }
  
  void show(){
    
    fill(20);
    ellipse(pos.x,pos.y,r,r);
    noStroke();
    fill(10);
    ellipse(pos.x,pos.y,r*0.8,r*0.8);
    fill(0);
    ellipse(pos.x,pos.y,r*0.6,r*0.6);
  }
  
}
