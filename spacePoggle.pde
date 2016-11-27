
color bgcolor;
PImage cannonBase;
PImage earth;
float pScale;
float earthScale;

Cannon cannon1;
ArrayList<Ball> balls;
ArrayList<Peg> pegs;
PVector vecs[];
PVector stars[];
int numStars = 1000;
int numPegs = 150;
int pegsLeft = numPegs;
int ballsLeft = 100;
boolean mouseRelease = false;

// Text controls
PFont f;
String txtGameOver = "You have no balls";
String txtYouWin = "You touched all the balls";

//peg setting parameters.  Spiral
float theta = 0.0;  // Start angle at 0
float r = 0.5; //start r at o.4
float a = 8;
float b =5.8; //increases ring spacing
float R = 6;  //increases arc length
float xShift = -6.0;  
float P = 0.4;  //changes pattern.
float d = 3; //increases total phase
float amp = 120; //petal length

void setup() {
  //image
  cannonBase = loadImage("sphere.png");
  earth = loadImage("sun.png");
  pScale = 8; //used to scale image size
  earthScale = random(2, 5); //used to locate and scale earth

  f = createFont("Arial", 30, true);
  size(600, 600);
  //color bgcolor = color(random(0,255), random(0,255), random(0,255));  
  color bgcolor = color(255);
  background(bgcolor);
  cannon1 = new Cannon();
  balls = new ArrayList<Ball>();
  //ball1 = new Ball(cannon1.xPos, cannon1.yPos, 0.00, 0.00);
  pegs = new ArrayList<Peg>();
  vecs = new PVector[numPegs];
  stars = new PVector[numStars];

  vecs = setVecs(numPegs);
  stars = setStars(numStars);
  for (int i = 0; i < numPegs; i++) {
    Peg newPeg = new Peg(vecs[i]);
    pegs.add(newPeg);
  }
}

void draw() {
  //background(255);// white bg
  background(bgcolor);

  //create stars that twinkle
  for (int i = 0; i < numStars; i++) {
    PVector p = stars[i];
    //stroke(random(0, 255));
    float flicker  = map(noise(frameCount/30.0, i), 0, 1, 0, 255);
    float flickerW = map(flicker,0,255,.1,2);
    stroke(flicker);
    strokeWeight(flickerW);
    point(p.x, p.y);
  }

  // load background images
  // image(name, xlocation, ylocation, xsize, ysize)
  image(earth, width/earthScale, height/earthScale, earth.width/earthScale, earth.height/earthScale);

  //check for game over/ win condition
  if (pegsLeft  == 0) {
    background(0);       
    fill(255);
    textFont(f);                  // Set the font
    translate(width/2, height/2);  // Translate to the center
    rotate(theta);                // Rotate by theta
    textAlign(CENTER);            
    text(txtYouWin, 0, 0);            
    theta += 0.02;                // Increase rotation
  } 
  else {

    if (ballsLeft == 0) {
      background(0);       
      fill(255);
      textFont(f);                  // Set the font
      translate(width/2, height/2);  // Translate to the center
      rotate(theta);                // Rotate by theta
      textAlign(CENTER);            
      text(txtGameOver, 0, 0);            
      theta += 0.02;                // Increase rotation
    }  
    //else, game on.         
    else {  
      cannon1.drawCannon();

      //check if each balls are off screen.  remove and subtract from total
      for (int i = balls.size() - 1; i >= 0; i--) {
        if (balls.get(i).location.y > height || balls.get(i).location.y < -50 ) {
          balls.remove(i);
          ballsLeft--;

          //also remove pegs if they were hit
          for (int j = pegs.size() - 1; j >= 0; j--) {
            if (pegs.get(j).hit == true) {
              pegs.remove(j);
              pegsLeft--;
            }
          }
        }
      }

      //if there are balls, draw all of them.
      if (balls.size() > 0) {
        for (int i = 0; i < balls.size(); i++) {
          balls.get(i).drawBall();
        }
      }

      //check collision for each peg and ball in play.  Should this be in Peg class?
      for (Peg p : pegs) {
        if (balls.size() > 0) {
          for (int i = 0; i < balls.size(); i++) {
            Ball ball = balls.get(i);
            p.checkCollision(ball);
          }
        }
        p.drawPeg();
      }  // end for (Peg p : pegs)
    }
  }// end win check
} // end draw()

void  mouseReleased() {
  // limit balls on screen to 1, and check if balls left.
  if (ballsLeft > 0 && balls.size() ==0) {
    float a = mouseX - cannon1.xPos;//+ cannon1.xPos;
    float b =  mouseY - cannon1.yPos;//+ cannon1.yPos;
    float angle = atan2(b, a) -PI/2;
    // power scales with dist. btw. mouse and cannon
    //float r = dist(cannon1.xPos, cannon1.yPos, mouseX, mouseY) / 10;
    float r = 4;
    PVector velocity = new PVector(-1 * r * sin(angle), r * cos(angle));

    // ball initialized at cannon opening.
    PVector barrel = new PVector();
    barrel.x = cannon1.xPos - cannon1.cLength* sin(angle) ;
    barrel.y = cannon1.cLength * cos(angle) + cannon1.yPos;

    //ball1 = new Ball(cannon1.xPos, cannon1.yPos, 0, 0);
    Ball shot = new Ball(barrel, velocity);
    balls.add(shot);
  }
}

//set pegs.  Calculate PVector arrays for placement
PVector[] setVecs(int numPegs) {
  for (int i = 0; i < numPegs; i++) {
      
     //Spiral 
     theta = (sqrt(2 * b * i * R * 2 * PI + a * a) + a) / b;     
     r = a + b*theta;
     vecs[i] = new PVector(r * sin(theta) + width/2, r * cos(theta) - xShift + height/2);
     
     /*
    // polar rose
    theta = 2 * PI  * d *  i / numPegs ;
    r = amp * cos(P * theta) + amp;
    vecs[i] = new PVector(r * sin(theta) + width/2, r * cos(theta) - xShift + height/2);
    */
  }
  return vecs;
}

//set pegs.  Calculate PVector arrays for placement
PVector[] setStars(int numStars) {
  for (int i = 0; i < numStars; i++) {
    stars[i] = new PVector(random(0, width), random(0, height));
  }
  return stars;
}

// test code
void keyPressed() {
  println(balls.size());
}

