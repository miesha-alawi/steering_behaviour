//referenced from 'Nature of Code'
//Daniel Shiffman

class Vehicle {
  PVector acceleration, velocity, position;
  float r, maxspeed, maxforce, wanderTheta;
  Vehicle(float x, float y)
  {
    acceleration = new PVector(0,0);
    velocity = new PVector(1, 0);
    position = new PVector(x,y);
    r = 6;
    maxspeed = 8;
    maxforce = 0.4;
    wanderTheta = PI/2;
  }
  
  void update()
  {
    //update velocity
    velocity.add(acceleration);
    //limit speed
    velocity.limit(maxspeed);
    position.add(velocity);
    //reset acceleration to 0 each cycle
    acceleration.mult(0);
  }
  
  //boundary handling - wrap around
  void boundaries()
  {
    if(position.x < 0) {
      position.x = width;
    }
    else if(position.x > width) {
      position.x = 0;
    }
    
    if(position.y < 0) {
      position.y = height;
    }
    else if(position.y > height) {
      position.y = 0;
    }
    
  }
  
  void wander() 
  {
    PVector wanderPoint = velocity.copy();
    wanderPoint.setMag(100);
    wanderPoint.add(position);
    float wanderRadius = 50;
    float theta = wanderTheta + velocity.heading();
    float x = wanderRadius * cos(theta);
    float y = wanderRadius * sin(theta);
    wanderPoint.add(x,y);
    PVector steer = wanderPoint.sub(position);
    steer.setMag(maxforce);
    float displaceRange = 0.3;
    wanderTheta += random(-displaceRange,displaceRange);
    applyForce(steer);
  }
  
  PVector arrive(PVector target)
  {
    PVector desired = PVector.sub(target, position);
    float slowRadius = 100;
    float dist = desired.mag();
    if(dist < slowRadius) {
      float desiredSpeed = map(dist, 0 , slowRadius, 0, maxspeed);
      desired.setMag(desiredSpeed);
    } else {
      //scale to max speed
      desired.setMag(maxspeed);
    }
    //steering = desired - velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce); //limit to max steering force
    return steer;
  }
  
  void applyForce(PVector force)
  {
    acceleration.add(force);
  }
  
  PVector evade(Vehicle target)
  {
    return pursue(target).mult(-1);
  }
  
  PVector pursue(Vehicle target) 
  {
    PVector targ = target.position.copy();
    PVector prediction = target.velocity.copy().mult(10);
    targ.add(prediction);
    return seek(targ);
  }
  
  //adjusts the vector of seek in the opposite direction
  PVector flee(PVector target) 
  {
    return seek(target).mult(-1);
  }
  
  //calculates a steering force towards a target
  //steer = desired - velocity
  PVector seek(PVector target)
  {
    PVector desired = PVector.sub(target, position);
    
    //scale to max speed
    desired.setMag(maxspeed);
    
    //steering = desired - velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce); //limit to max steering force
    return steer;
  }
  
  void draw()
  {
    //draw a triangle rotated in the direction of velocity
    float theta = velocity.heading() + PI / 2;
    fill(127);
    stroke(200);
    strokeWeight(1);
    push();
    translate(position.x,position.y);
    rotate(theta);
    beginShape();
    vertex(0, -r * 2);
    vertex(-r, r *2);
    vertex(r,r*2);
    endShape(CLOSE);
    pop();
  }
}
