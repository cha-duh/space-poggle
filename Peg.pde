class Peg {
  //constructor instantiates instance variables
  PVector location;
  float rad;
  boolean hit;

  //constructor
  Peg (PVector LOCATION) {
    location = LOCATION;
    rad = 14;
    hit = false;
  }

  //methods
  //check and handle collision
  void checkCollision(Ball ball) {
    if (dist(ball.location.x, ball.location.y, location.x, location.y) <= ball.rad/2 + rad/2 + 2.0) {
      ball.collide(this);
      hit = true; //change peg color, or remove from list?
    }
  }

  void drawPeg() {
    if (!hit) {
      strokeWeight(1.0);
      stroke(10, 80,255);
      fill(0,0,255);   
      ellipse(location.x, location.y, rad, rad);
    } 
    else {
      fill(255, 215, 0);
      stroke(205,155, 29);
      ellipse(location.x, location.y, rad, rad);
    }
  }
}

