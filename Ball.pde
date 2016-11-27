class Ball {
  //constructor instantiates instance variables

  PVector location;
  PVector velocity;
  float rad;
  float airFriction = 0.015;
  float gravity = 0.1;

  //start constructor

  Ball (PVector LOCATION, PVector VELOCITY) {
    location = LOCATION;
    velocity = VELOCITY;
    rad = 9;
  }

  //define methods
  void collide(Peg p) {
    float minDist = dist(location.x, location.y, p.location.x, p.location.y);
    //where -pos.x/y is actually center of static object - center of ball
    float normalX = (p.location.x-location.x)/minDist;
    float normalY = (p.location.y-location.y)/minDist;
    float newP = (velocity.x * normalX) + (velocity.y * normalY);
    float vecX = velocity.x - 2*(newP * normalX);
    float vecY = velocity.y - 2*(newP * normalY);
    velocity.x = vecX;
    velocity.y = vecY;
  }  

  void drawBall() {

    //if off screen, remove from array list
    if (location.y > height) {
      balls.remove(0);
    }

    //gravity
    if (location.x < 0 || location.x > width) velocity.x = -velocity.x;
    velocity.y += gravity;

    //air friction
    if (velocity.x != 0.00) {
      if (velocity.x >= 0) {
        velocity.x -= airFriction;
      } 
      else {
        velocity.x += airFriction;
      }

      location.x += velocity.x;
      location.y += velocity.y;
    }
   
    strokeWeight(1.0);
    stroke(255);
    fill (50);
    ellipse(location.x, location.y, rad, rad);
  }
}

