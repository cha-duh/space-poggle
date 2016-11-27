class Cannon {
  //constructor instantiates instance variables
  float xPos;
  float yPos;
  float rad; //draw cannon as ball for now
  float cLength;

  // constructor
  Cannon () {
    this.xPos = width/2;
    this.yPos = 0;
    rad = 20;
    cLength = 50;
  }

  //defin methods
  void drawCannon() {

    //draw cannon barrel
    float a = mouseX - xPos;
    float b =  mouseY - yPos;
    float angle = atan2(b, a) - PI/2;
    float r = cLength;
    float barrelX = xPos - r * sin(angle);
    float barrelY = r * cos(angle) + yPos;

    strokeWeight(12.0);
    stroke(80);
    strokeCap(ROUND);
    //line(xPos, yPos, 0.5 * (mouseX + xPos), 0.5 * (mouseY + yPos) );
    line(xPos, yPos, barrelX, barrelY );
    fill(255);
    strokeWeight(3.0);
    ellipse(barrelX, barrelY, 8, 10);
    image(cannonBase, xPos-41, yPos-25, 
    cannonBase.width/pScale, cannonBase.height/pScale);
  
    strokeWeight(2.0);
    stroke(10, 150,0);
    fill (0, 255, 0);
    //ellipse(xPos, yPos, 2*rad, 2*rad);
    strokeWeight(1.0);
  }
}

