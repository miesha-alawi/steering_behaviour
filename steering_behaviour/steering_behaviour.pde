Vehicle pursuer;
Target target;

void setup()
{
  size(800,400);
  pursuer = new Vehicle(width/2, height/2);
  target = new Target(width/3, height/3);
}

void draw()
{
  background(50);
  pursuer.wander();
  
  float d = PVector.dist(pursuer.position, target.position);
  if (d < pursuer.r + target.r) {
    target = new Target(random(width),random(height));
  }
  
  pursuer.boundaries();
  pursuer.update();
  pursuer.draw();
  
  target.boundaries();
  target.update();
  target.draw();
}
