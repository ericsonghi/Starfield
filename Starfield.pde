// Declare variables needed
double myX, myY, myAngle, mySpeedX, mySpeedY;
int myColor;
boolean accelerateDown = false;
boolean exploded = false;

firework hello;
Particle[] particles;
OutlierParticle outlier;

// Creates empty apartments!!!
void setup() {
  size(500, 500);
  background(0);
  hello = new firework();
  particles = new Particle[(int)(Math.random()*200 + 100)];

  outlier = new OutlierParticle((float)myX, (float)myY);
  particles[0] = outlier;
}

void mousePressed(){
  for(int i = 0; i < 2; i++){
    hello.reset();
  }
}

void draw() {
//The background here makes sure that the firework doesn't leave any residue
  background(0);

//If the explosion hasn't been set off yet, the rocket will move
  if (exploded == false) {
    hello.show();
    hello.shoot();
    
//Once mySpeedY reaches 0 and below, the ellipse will begin moving down. 
    if (mySpeedY >= 0 && accelerateDown == false) {
      accelerateDown = true;
    }

//When the rocket is about to descend, the rocket is considered to be exploding
    if (accelerateDown == true) {
      exploded = true;
//This creates little particles inside the firework
      for (int i = 0; i < particles.length; i++) {
        particles[i] = new Particle((float)myX, (float)myY);
      }
      outlier = new OutlierParticle((float)myX, (float)myY);
    }
  } else {
    for (int i = 0; i < particles.length; i++) {
        particles[i].scatter();
        particles[i].show();
      }

      outlier.scatter();
      outlier.show();
    }
}

class firework {
  firework() {
    myX = (Math.random()*300 + 100);
    myY = 500;

    if (myX >= 100 && myX <= 250) {
      myAngle = (Math.random() * (PI / 4) + (PI / 4));
    } else if (myX >= 250 && myX <= 400) {
      myAngle = (Math.random() * (PI / 4) + (PI / 2));
    }

    mySpeedX = Math.cos(myAngle) * (Math.random() * 4 + 3);
    mySpeedY = -Math.sin(myAngle) * (Math.random() * 4 + 9);
    myColor = color((int)(Math.random() * 255), (int)(Math.random() * 255), (int)(Math.random() * 255));
  }

  void show() {
    fill(myColor);
    ellipse((float)myX, (float)myY, 15, 15);
  }

  void shoot() {
    myX += mySpeedX;
    myY += mySpeedY;
    mySpeedY += 0.15;
  }
  
  void reset(){
      myX = (Math.random()*300 + 100);
      myY = 500;
      accelerateDown = false;
      exploded = false;
      if (myX >= 100 && myX <= 250) {
      myAngle = (Math.random() * (PI/4) + (PI/4));
    } else if (myX >= 250 && myX <= 400) {
      myAngle = (Math.random() * (PI/4) + (PI/2));
    }

    mySpeedX = Math.cos(myAngle) * (Math.random() * 4 + 3);
    mySpeedY = -Math.sin(myAngle) * (Math.random() * 4 + 9);
    myColor = color((int)(Math.random() * 255), (int)(Math.random() * 255), (int)(Math.random() * 255));
      
    }
}



class Particle {
//Declared inside class in order to give each particle a unique set of attributes
  float x, y, angle, speed, size;
  int opacity;

//Float parameters are used because you're inputting the x and y values (floats) from the firework
  Particle(float startX, float startY) {
    x = startX;
    y = startY;
//Random angle to replicate circle
    angle = (float)(Math.random() * TWO_PI);
    speed = (float)(Math.random()*2 + 1);
    opacity = 255;
    size = 10;
  }

  void scatter() {
    x = x + cos(angle)*speed;
    y = y + sin(angle)*speed;

    if (opacity > 0) {
      opacity -= 4;
  }
}

  void show() {
    fill((int)(Math.random()*255), (int)(Math.random()*255), (int)(Math.random()*255), opacity);
    ellipse(x, y, size, size);
  }
}

class OutlierParticle extends Particle {
  float vroom, randomAngle;

  OutlierParticle(float startX, float startY) {
//This is used to call the startX and startY from the previous particles
    super(startX, startY);
    vroom = (float)(Math.random()*20 + 10);
    size = 20;
    randomAngle = ((float)(Math.random()* PI));
  }

  void scatter() {
//Oddball has different movement
    x = (float)(x + cos(randomAngle)*vroom);
    y = (float)(y + sin(randomAngle)*vroom);
  }
}
