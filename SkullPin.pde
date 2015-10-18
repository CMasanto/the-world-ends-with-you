class SkullPin {

  PImage skullPinImage;
  boolean isActivated;
  int activationFieldRadius;
  
  PImage noiseSymbol;
  float noiseXPos;
  float noiseYPos;
  float perlinXindex;
  float perlinYindex;

  final int FIELD_SPEED = 5;
  final int INITIAL_FIELD_RADIUS = 50;
  final int INITIAL_NOISE_X_POS = ScreenSeparator.CENTER_X_BOTTOM;
  final int INITIAL_NOISE_Y_POS = ScreenSeparator.CENTER_Y_BOTTOM;
  final int PIN_RADIUS = 15;
  final int X_POS = ScreenSeparator.CENTER_X_BOTTOM + ScreenSeparator.SCREEN_WIDTH/2 - PIN_RADIUS - 10;
  final int Y_POS = ScreenSeparator.CENTER_Y_BOTTOM + ScreenSeparator.SCREEN_HEIGHT/2 - PIN_RADIUS - 10;

  SkullPin() {
    skullPinImage = loadImage("skullPin.png");
    isActivated = false;
    activationFieldRadius = INITIAL_FIELD_RADIUS;
    noiseSymbol = loadImage("redNoiseSymbol.png");
    noiseXPos = INITIAL_NOISE_X_POS;
    noiseYPos = INITIAL_NOISE_Y_POS;
    perlinXindex = random(0, 100000);
    perlinYindex = random(0, 100000);
  } 

  void display() {
    if (isActivated) {
      activationFieldRadius += FIELD_SPEED;
      drawActivationField(); 
      if (activationFieldRadius > height) {  // The field has expanded to all of the screen.
        displayNoiseSymbol();
        displayNoiseShadow();
      }
    }
    imageMode(CENTER);
    image(skullPinImage, X_POS, Y_POS);
  }
  
  void drawActivationField() {
    println("drawing field");
    strokeWeight(20);
    stroke(102, 0, 255);
    fill(25, 71, 209, 128);
    ellipse(width/2, height/2, activationFieldRadius, activationFieldRadius);
  }
  
  void displayNoiseSymbol() {
    imageMode(CENTER);
    
    noiseXPos += map(noise(perlinXindex), 0, 1, -1, 1);
    noiseXPos = constrain(noiseXPos, ScreenSeparator.CENTER_X_BOTTOM - 25, ScreenSeparator.CENTER_X_BOTTOM + 25);
    perlinXindex += 0.01;
    
    noiseYPos += map(noise(perlinYindex), 0, 1, -1, 1);
    noiseYPos = constrain(noiseYPos, ScreenSeparator.CENTER_Y_BOTTOM - 25, ScreenSeparator.CENTER_Y_BOTTOM + 25);
    perlinYindex += 0.01;
    
    image(noiseSymbol, noiseXPos, noiseYPos);
  }
  
  void displayNoiseShadow() {
    ellipseMode(CENTER);
    noStroke();
    fill(30, 30, 30, map(noiseYPos, ScreenSeparator.CENTER_Y_BOTTOM - 25, ScreenSeparator.CENTER_Y_BOTTOM + 150, 60, 256));
    ellipse(noiseXPos, ScreenSeparator.CENTER_Y_BOTTOM + 150, 40, 20);
  }
}

