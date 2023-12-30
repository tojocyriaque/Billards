int numBalls = 16;
float r = 15;
float holeR = 40;
Ball[] balls = new Ball[numBalls];
Hole[] holes = new Hole[6];

PVector wPos;
PVector cPos;
Stick stk;

PVector[] holesPos = {
  new PVector(10,10),
  new PVector(390,10),
  new PVector(790,10),
  new PVector(10,390),
  new PVector(390,390),
  new PVector(790,390)
};

boolean collide(Ball b1, Ball b2){
  if(b1.eaten || b2.eaten){
    return false;
  }
  float minDist = b1.r + b2.r,
        dx = b1.pos.x - b2.pos.x,
        dy = b1.pos.y - b2.pos.y;
  float d = sqrt(dx*dx + dy*dy);
  
  if(d<minDist){
    return true;
  }
  return false;
}

void removeOverlap(Ball b1, Ball b2,float angle){
  float dx = b2.pos.x - b1.pos.x;
  float dy = b2.pos.y - b1.pos.y;
  float trueDist = b1.r + b2.r;
  
  float overX = trueDist*cos(angle) - dx;
  float overY = trueDist*sin(angle) - dy;
  
  b1.pos.x = b1.pos.x - overX;
  b1.pos.y = b1.pos.y - overY;
  
  b2.pos.x = b2.pos.x + overX;
  b2.pos.y = b2.pos.y + overY;
  
}

float collisionAngle(Ball b1, Ball b2){
  float dx = b2.pos.x - b1.pos.x;
  float dy = b2.pos.y - b1.pos.y;
  return atan2(dy,dx);
}

void updateVel(Ball b1, Ball b2){
  //store velocities to make calculations easier
  float v1x = b1.v.x, v1y = b1.v.y,
        v2x = b2.v.x, v2y = b2.v.y;
  float angle = collisionAngle(b1, b2);
  
  //remove overlapping if there is
  removeOverlap(b1, b2, angle);
  
  //Rotate the velocities so changes will be applied on only one composent of velocities
  float v1xr = v1x*cos(angle) - v1y*sin(angle),
        v1yr = v1x*sin(angle) + v1y*cos(angle);
  
  float v2xr = v2x*cos(angle) - v2y*sin(angle),
        v2yr = v2x*sin(angle) + v2y*cos(angle);

  //Calculations of new velocities
  float v1xn = v2xr, v1yn = v1yr,
        v2xn = v1xr, v2yn = v2yr;

  //Rotate back to have final velocities
  float v1xf = v1xn*cos(angle) + v1yn*sin(angle),
        v1yf = v1yn*cos(angle) - v1xn*sin(angle);
  
  float v2xf = (v2xn*cos(angle) + v2yn*sin(angle))*0.7,
        v2yf = (v2yn*cos(angle) - v2xn*sin(angle))*0.7;

  //update velocities
  b2.v = new PVector(v1xf, v1yf);
  b1.v = new PVector(v2xf, v2yf);

}

void handleCollision(){
  for(int i=0;i<numBalls;i++){
    for(int j=0;j<numBalls;j++){
      if(i!=j && collide(balls[i],balls[j])){
        updateVel(balls[i],balls[j]);
      }
    }
  }
}

void createBalls(){
  int yellow = 0;
  int red = 0;
  int black = 0;
  int white = 0;
  color c_yellow = #ffff00;
  color c_red = #ff0000;
  color c = #000000;
  int num = 1;
  for(int i=0; i<numBalls;i++){
    if(yellow<7){
      c = c_yellow;
      yellow++;
    }
    else if(red<7){
      c = c_red;
      red++;
    }
    else if(black==0){
      c = #000000;
      black++;
    }
    else if(white==0){
      c = #ffffff;
      white++;
    }
    balls[i] = new Ball(random(r,width-r),random(r,height-r),r,c);
    balls[i].num = num;
    num++;
    
    if(num==16){
      wPos = new PVector(balls[i].pos.x,balls[i].pos.y);
      cPos = new PVector(wPos.x,wPos.y);    
    }
    
  }
}

void createHoles(){
  for(int i=0; i<6; i++){
    holes[i] = new Hole(holesPos[i], holeR);
  } 
}

void showHoles(){
  for(Hole hole: holes){
    hole.show();
  }
}

void setup(){
  size(800,400);
  createBalls();
  createHoles();
  stk = new Stick(r);
}

void keyPressed(){
  if(key==' '){
    stk.charge();
  }
}

void keyReleased(){
  if(key==' '){
    cPos.x = wPos.x;
    cPos.y = wPos.y;
    
    balls[15].v.x = -stk.l*cos(stk.angle);
    balls[15].v.y = -stk.l*sin(stk.angle);
    stk.hit();
  }
}

void draw(){
  background(10,60,10);
  handleCollision();
  
  if(balls[15].eaten){
    balls[15].eaten = false;
    balls[15].pos.x = random(r,width-r);
    balls[15].pos.y = random(r,height-r);
    balls[15].v = new PVector(0,0);
  }

  showHoles();
  for(Ball ball:balls){
    ball.show();
    ball.move();
  }
  wPos.x = balls[15].pos.x;
  wPos.y = balls[15].pos.y;
  
  if(!balls[15].isMoving()){
    stk.show(wPos);
  }
  else{
    stk.show(cPos);
  }
  
  
}
