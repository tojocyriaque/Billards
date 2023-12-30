float friction = -0.007;

class Ball{
  
  PVector pos = new PVector(0, 0),
          v = new PVector(0,0),
          a = new PVector(0,0);
  float r;
  color col;
  int num;
  boolean eaten = false;
  float holeR = 20;
  PVector[] holesPos = {
    new PVector(10,10),
    new PVector(390,10),
    new PVector(790,10),
    new PVector(10,390),
    new PVector(390,390),
    new PVector(790,390)
  };
  
  public Ball(float x, float y, float r, color c){
    this.pos = new PVector(x, y);
    this.r = r;
    this.col = c;
  }

  void applyForce(PVector F){
    a.add(F);
  }

  void move(){
    if(eaten){
      return;
    }
    
    v.add(a);
    pos.add(v);
    v.x += v.x * friction;
    v.y += v.y * friction;
    
    if(abs(v.x)<0.07){
      v.x = 0;
    }
    if(abs(v.y)<0.07){
      v.y = 0;
    }
    
    if (pos.x<r){
      pos.x = r;
      v.x = -v.x;
    }
    else if(pos.x>width-r){
      pos.x = width-r;
      v.x = -v.x;
    }

    if (pos.y<r){
      pos.y = r;
      v.y = -v.y;
    }
    else if(pos.y>height-r){
      pos.y = height-r;
      v.y = -v.y;
    }
    
    for(PVector p: holesPos){
      if(p.x-holeR<pos.x && pos.x<p.x+holeR && p.y-holeR<pos.y && pos.y<p.y+holeR ){
        if(abs(v.x)<10 && abs(v.y)<10){
          eaten = true;
        }
      }
    }
    
  }
  
  void show(){
    if(eaten){
      return;
    }
    fill(col);
    ellipse(pos.x, pos.y, r*2, r*2);
    if( 5<=num && num<=11 && col!=#ffffff && col!=#000000){
      fill(255);
      ellipse(pos.x, pos.y, r, r);
    }
    fill(#000000);
  }
  
  boolean isMoving(){
    return (abs(v.x)>=0.001 && abs(v.y)>=0.001);
  }
  
}
