class Stick{
  PVector[] coords = new PVector[2];
  float dist = 20;
  float d = 20;
  float len = 400;
  float r;
  float angle;
  float l = 0;
 
  public Stick(float bRad){
    r = bRad;
  }
 
  void charge(){
    if(d<1000){
      d = d + 5;
      l = l + 1;
    }
  }
  
  void hit(){
    d = dist;
    l = 0;
  }
  
  void trackCoords(PVector bPos){
    float mx = mouseX;
    float my = mouseY;
    float x1 = 0, y1 = 0,
          x2 = 0, y2 = 0;
 
    angle = atan2(my-bPos.y,mx-bPos.x);
    x1 = bPos.x + (r+d)*cos(angle);
    y1 = bPos.y + (r+d)*sin(angle);
    
    x2 = x1 + len*cos(angle);
    y2 = y1 + len*sin(angle);
    
    coords[0] = new PVector(x1,y1);
    coords[1] = new PVector(x2,y2);    
  }
  
  void showStick(){
    stroke(180,100,40);
    strokeWeight(10);
    line(coords[0].x, coords[0].y,coords[1].x,coords[1].y);
    stroke(255);
    strokeWeight(0.2);
  } 
  
  void show(PVector bPos){
    trackCoords(bPos);
    showStick();
  }
   
}
