class Target extends Vehicle {
  Target(float x, float y) {
    super(x,y);
    maxspeed = 5;
  }
  
  @Override
  void draw() {
    //draw a triangle rotated in the direction of velocity
    fill(255,0,0,100);
    noStroke();
    strokeWeight(1);
    push();
    translate(position.x,position.y);
    ellipse(0,0,r*2,r*2);
    pop();
  }
}
