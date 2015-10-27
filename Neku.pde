class Neku {
  PImage activeSprite;
  
  int spriteIndex;  // Tracks the index of the active sprite within its PImage array.
  float xPos;
  float yPos;
  float scale;
  int direction;
  boolean canMove;
  boolean[] keyIsPressed;
  
  PImage[] leftRunSprites;
  PImage[] rightRunSprites;
  PImage[] upRunSprites;
  PImage[] downRunSprites;
  PImage[] upLeftRunSprites;
  PImage[] upRightRunSprites;
  PImage[] downLeftRunSprites;
  PImage[] downRightRunSprites;
  
  PImage[] fallSprites;
  PImage[] fallDownRightSprites;
  PImage[] fallDownLeftSprites;
  int fallIndex;
  
  PImage[] attackSprites;
  PImage[] attackSpritesLeft;
  PImage[] attackSpritesRight;
  int attackIndex;
  
  PImage leftStandSprite;
  PImage rightStandSprite;
  PImage upStandSprite;
  PImage downStandSprite;
  PImage upLeftStandSprite;
  PImage upRightStandSprite;
  PImage downLeftStandSprite;
  PImage downRightStandSprite;
  
  Minim minim;
  AudioPlayer stepAudio;
  
  boolean isBattling;
  boolean isHit;
  boolean isAttacking;
  
  final int SPRITE_HEIGHT = 66;  // The original height of all Neku sprites
  final int DIAGONAL_SPRITE_WIDTH = 48;  // The width of Neku sprites moving diagonally.
  final int HORIZONTAL_SPRITE_WIDTH = 56;  // The width of Neku sprites moving horizontally.
  final int VERTICAL_SPRITE_WIDTH = 25;  // The width of Neku sprites moving vertically.
  
  final int dUP = 0;
  final int dDOWN = 1;
  final int dLEFT = 2;
  final int dRIGHT = 3;
  final int dUP_RIGHT = 4;
  final int dDOWN_RIGHT = 5;
  final int dDOWN_LEFT = 6;
  final int dUP_LEFT = 7;

  final int NUM_SPRITES_IN_ONE_STEP = 8;  // The number of sprites in each PImage sprite array.
  final float VERTICAL_STEP_LENGTH = 4.0;
  final float HORIZONTAL_STEP_LENGTH = 4.0;
  final float DIAGONAL_STEP_LENGTH_X = 2.828427;
  final float DIAGONAL_STEP_LENGTH_Y = 2.828427;
 
 final int NUM_SPRITES_IN_FALL = 10; 
 final int NUM_SPRITES_IN_ATTACK = 7; 

  Neku(Minim m) {
    minim = m;
    stepAudio = minim.loadFile("Step.wav");
    stepAudio.setGain(-22);
    
    leftRunSprites = new PImage[]{
      loadImage("Neku_Run_Left1.png"),
      loadImage("Neku_Run_Left2.png"),
      loadImage("Neku_Run_Left3.png"),
      loadImage("Neku_Run_Left4.png"),
      loadImage("Neku_Run_Left5.png"),
      loadImage("Neku_Run_Left6.png"),
      loadImage("Neku_Run_Left7.png"),
      loadImage("Neku_Run_Left8.png")
    };  
    
    rightRunSprites = new PImage[]{
      loadImage("Neku_Run_Right1.png"),
      loadImage("Neku_Run_Right2.png"),
      loadImage("Neku_Run_Right3.png"),
      loadImage("Neku_Run_Right4.png"),
      loadImage("Neku_Run_Right5.png"),
      loadImage("Neku_Run_Right6.png"),
      loadImage("Neku_Run_Right7.png"),
      loadImage("Neku_Run_Right8.png")
    };
    
    upRunSprites = new PImage[]{
      loadImage("Neku_Run_Up1.png"),
      loadImage("Neku_Run_Up2.png"),
      loadImage("Neku_Run_Up3.png"),
      loadImage("Neku_Run_Up4.png"),
      loadImage("Neku_Run_Up5.png"),
      loadImage("Neku_Run_Up6.png"),
      loadImage("Neku_Run_Up7.png"),
      loadImage("Neku_Run_Up8.png")
    };
    
    downRunSprites = new PImage[]{
      loadImage("Neku_Run_Down1.png"),
      loadImage("Neku_Run_Down2.png"),
      loadImage("Neku_Run_Down3.png"),
      loadImage("Neku_Run_Down4.png"),
      loadImage("Neku_Run_Down5.png"),
      loadImage("Neku_Run_Down6.png"),
      loadImage("Neku_Run_Down7.png"),
      loadImage("Neku_Run_Down8.png")
    };
    
    upLeftRunSprites = new PImage[]{
      loadImage("Neku_Run_Up_Left1.png"),
      loadImage("Neku_Run_Up_Left2.png"),
      loadImage("Neku_Run_Up_Left3.png"),
      loadImage("Neku_Run_Up_Left4.png"),
      loadImage("Neku_Run_Up_Left5.png"),
      loadImage("Neku_Run_Up_Left6.png"),
      loadImage("Neku_Run_Up_Left7.png"),
      loadImage("Neku_Run_Up_Left8.png")
    };  
    
    upRightRunSprites = new PImage[]{
      loadImage("Neku_Run_Up_Right1.png"),
      loadImage("Neku_Run_Up_Right2.png"),
      loadImage("Neku_Run_Up_Right3.png"),
      loadImage("Neku_Run_Up_Right4.png"),
      loadImage("Neku_Run_Up_Right5.png"),
      loadImage("Neku_Run_Up_Right6.png"),
      loadImage("Neku_Run_Up_Right7.png"),
      loadImage("Neku_Run_Up_Right8.png")
    };
    
    downLeftRunSprites = new PImage[]{
      loadImage("Neku_Run_Down_Left1.png"),
      loadImage("Neku_Run_Down_Left2.png"),
      loadImage("Neku_Run_Down_Left3.png"),
      loadImage("Neku_Run_Down_Left4.png"),
      loadImage("Neku_Run_Down_Left5.png"),
      loadImage("Neku_Run_Down_Left6.png"),
      loadImage("Neku_Run_Down_Left7.png"),
      loadImage("Neku_Run_Down_Left8.png")
    };
    
    downRightRunSprites = new PImage[]{
      loadImage("Neku_Run_Down_Right1.png"),
      loadImage("Neku_Run_Down_Right2.png"),
      loadImage("Neku_Run_Down_Right3.png"),
      loadImage("Neku_Run_Down_Right4.png"),
      loadImage("Neku_Run_Down_Right5.png"),
      loadImage("Neku_Run_Down_Right6.png"),
      loadImage("Neku_Run_Down_Right7.png"),
      loadImage("Neku_Run_Down_Right8.png")
    };
    
    leftStandSprite = loadImage("Neku_Stand_Left.png");
    rightStandSprite = loadImage("Neku_Stand_Right.png");
    upStandSprite = loadImage("Neku_Stand_Up.png");
    downStandSprite = loadImage("Neku_Stand_Down.png");
    upLeftStandSprite = loadImage("Neku_Stand_Up_Left.png");
    upRightStandSprite = loadImage("Neku_Stand_Up_Right.png");
    downLeftStandSprite = loadImage("Neku_Stand_Down_Left.png");
    downRightStandSprite = loadImage("Neku_Stand_Down_Right.png");
    
    fallDownRightSprites = new PImage[]{
      loadImage("Neku_Fall_Right1.png"),
      loadImage("Neku_Fall_Right2.png"),
      loadImage("Neku_Fall_Right3.png"),
      loadImage("Neku_Fall_Right4.png"),
      loadImage("Neku_Fall_Right5.png"),
      loadImage("Neku_Fall_Right6.png"),
      loadImage("Neku_Fall_Right7.png"),
      loadImage("Neku_Fall_Right8.png"),
      loadImage("Neku_Fall_Right9.png"),
      loadImage("Neku_Fall_Right10.png")
    };
    fallDownLeftSprites = new PImage[]{
      loadImage("Neku_Fall_Left1.png"),
      loadImage("Neku_Fall_Left2.png"),
      loadImage("Neku_Fall_Left3.png"),
      loadImage("Neku_Fall_Left4.png"),
      loadImage("Neku_Fall_Left5.png"),
      loadImage("Neku_Fall_Left6.png"),
      loadImage("Neku_Fall_Left7.png"),
      loadImage("Neku_Fall_Left8.png"),
      loadImage("Neku_Fall_Left9.png"),
      loadImage("Neku_Fall_Left10.png")
    };
    
    attackSpritesLeft = new PImage[]{
      loadImage("attack_left1.png"),
      loadImage("attack_left2.png"),
      loadImage("attack_left3.png"),
      loadImage("attack_left4.png"),
      loadImage("attack_left5.png"),
      loadImage("attack_left6.png"),
      loadImage("attack_left7.png")    
    };
    attackSpritesRight = new PImage[]{
      loadImage("attack_right1.png"),
      loadImage("attack_right2.png"),
      loadImage("attack_right3.png"),
      loadImage("attack_right4.png"),
      loadImage("attack_right5.png"),
      loadImage("attack_right6.png"),
      loadImage("attack_right7.png") 
    };
    
    activeSprite = downStandSprite;
    spriteIndex = 0;
    canMove = true;
    
    // Set Neku at the very bottom of the player's screen, and at normal size (i.e., scale), looking ahead.
    xPos = ScreenSeparator.CENTER_X_BOTTOM;
    yPos = ScreenSeparator.CENTER_Y_BOTTOM + (ScreenSeparator.SCREEN_HEIGHT)/2 - SPRITE_HEIGHT;
    direction = dDOWN;
    scale = 1;
    
    keyIsPressed = new boolean[]{ false, false, false, false };    
    
    isBattling = false;
    isHit = false;
  }
  
  void display() {    
    drawShadow();
    image(activeSprite, xPos, yPos);
  }
  
  void move() {
    if (!keyIsPressed[dUP] && !keyIsPressed[dDOWN] && !keyIsPressed[dLEFT] && !keyIsPressed[dRIGHT]) {
      final int sIndex = (spriteIndex/4) % NUM_SPRITES_IN_ONE_STEP;
      final boolean currentSpriteIndexSmoothlyTransitionsIntoStandingPosition = 
          direction == dDOWN_LEFT || direction == dDOWN_RIGHT ? (sIndex == 0 || sIndex == 6) : (sIndex == 1 || sIndex == 5);
      if (!currentSpriteIndexSmoothlyTransitionsIntoStandingPosition) {
        moveForStanding();
        updateSpriteSize();
      } else {
        println("standing");
        stand(); 
      } 
    } else {  
      if (keyIsPressed[dUP] && !keyIsPressed[dLEFT] && !keyIsPressed[dRIGHT]) {
        println("up");
        direction = dUP;
        goUp();
        updateSpriteSize();
      } else if (keyIsPressed[dDOWN] && !keyIsPressed[dLEFT] && !keyIsPressed[dRIGHT]) {
        println("down");
        direction = dDOWN;
        goDown();
        updateSpriteSize();
      } else if (keyIsPressed[dLEFT] && !keyIsPressed[dUP] && !keyIsPressed[dDOWN]) {
        println("left");
        direction = dLEFT;
        goLeft();
      } else if (keyIsPressed[dRIGHT] && !keyIsPressed[dUP] && !keyIsPressed[dDOWN]) {
        println("right");
        direction = dRIGHT;
        goRight();
      } else if (keyIsPressed[dUP] && keyIsPressed[dLEFT]) {
        println("up left");
        direction = dUP_LEFT;
        goUpLeft();
        updateSpriteSize();
      } else if (keyIsPressed[dUP] && keyIsPressed[dRIGHT]) {
        println("up right");
        direction = dUP_RIGHT;
        goUpRight();
        updateSpriteSize();
      } else if (keyIsPressed[dDOWN] && keyIsPressed[dLEFT]) {
        println("down left");
        direction = dDOWN_LEFT;
        goDownLeft();
        updateSpriteSize();
      } else if (keyIsPressed[dDOWN] && keyIsPressed[dRIGHT]) {
        println("down right");
        direction = dDOWN_RIGHT;
        goDownRight();
//        updateSpriteSize();
      }
      
      // Play or reset the step sound
      if ((spriteIndex/4 % NUM_SPRITES_IN_ONE_STEP == 1) || (spriteIndex/4 % NUM_SPRITES_IN_ONE_STEP == 5)) {
        stepAudio.play(); 
      } else if ((spriteIndex/4 % NUM_SPRITES_IN_ONE_STEP == 0) || (spriteIndex/4 % NUM_SPRITES_IN_ONE_STEP == 4)) {
        stepAudio.rewind(); 
      }
    }    
  }
  
  void goLeft() {
    activeSprite = leftRunSprites[++spriteIndex/4 % NUM_SPRITES_IN_ONE_STEP];
    xPos = constrain(xPos - HORIZONTAL_STEP_LENGTH, 0, width);
  }
  
  void goRight() {
    activeSprite = rightRunSprites[++spriteIndex/4 % NUM_SPRITES_IN_ONE_STEP];
    xPos = constrain(xPos + HORIZONTAL_STEP_LENGTH, 0, width);
  }
  
  void goUp() {
    activeSprite = upRunSprites[++spriteIndex/4 % NUM_SPRITES_IN_ONE_STEP];
    
    float yLowerBound = isBattling ? ScreenSeparator.CENTER_Y_BOTTOM - ScreenSeparator.SCREEN_HEIGHT/2 + SPRITE_HEIGHT/2 : 
        ScreenSeparator.CENTER_Y_BOTTOM + 25;
    yPos = constrain(yPos - VERTICAL_STEP_LENGTH, yLowerBound, height - SPRITE_HEIGHT/2);
  }
  
  void goDown() {
    activeSprite = downRunSprites[++spriteIndex/4 % NUM_SPRITES_IN_ONE_STEP];
    
    float yLowerBound = isBattling ? ScreenSeparator.CENTER_Y_BOTTOM - ScreenSeparator.SCREEN_HEIGHT/2 + SPRITE_HEIGHT/2 : 
        ScreenSeparator.CENTER_Y_BOTTOM + 25;
    yPos = constrain(yPos + VERTICAL_STEP_LENGTH, yLowerBound, height - SPRITE_HEIGHT/2);
  }
  
  void goDownLeft() {
    activeSprite = downLeftRunSprites[++spriteIndex/4 % NUM_SPRITES_IN_ONE_STEP];
    xPos = constrain(xPos - DIAGONAL_STEP_LENGTH_X, 0, width);
    
    float yLowerBound = isBattling ? ScreenSeparator.CENTER_Y_BOTTOM - ScreenSeparator.SCREEN_HEIGHT/2 + SPRITE_HEIGHT/2 : 
        ScreenSeparator.CENTER_Y_BOTTOM + 25;
    yPos = constrain(yPos + DIAGONAL_STEP_LENGTH_Y, yLowerBound, height - SPRITE_HEIGHT/2);
  }
  
  void goDownRight() {
    activeSprite = downRightRunSprites[++spriteIndex/4 % NUM_SPRITES_IN_ONE_STEP];
    xPos = constrain(xPos + DIAGONAL_STEP_LENGTH_X, 0, width);
    
    float yLowerBound = isBattling ? ScreenSeparator.CENTER_Y_BOTTOM - ScreenSeparator.SCREEN_HEIGHT/2 + SPRITE_HEIGHT/2 : 
        ScreenSeparator.CENTER_Y_BOTTOM + 25;
    yPos = constrain(yPos + DIAGONAL_STEP_LENGTH_Y, yLowerBound, height - SPRITE_HEIGHT/2);
  }
  
  void goUpLeft() {
    activeSprite = upLeftRunSprites[++spriteIndex/4 % NUM_SPRITES_IN_ONE_STEP];
    xPos = constrain(xPos - DIAGONAL_STEP_LENGTH_X, 0, width);
    
    float yLowerBound = isBattling ? ScreenSeparator.CENTER_Y_BOTTOM - ScreenSeparator.SCREEN_HEIGHT/2 + SPRITE_HEIGHT/2 : 
        ScreenSeparator.CENTER_Y_BOTTOM + 25;
    yPos = constrain(yPos - DIAGONAL_STEP_LENGTH_Y, yLowerBound, height - SPRITE_HEIGHT/2);
  }
  
  void goUpRight() {
    activeSprite = upRightRunSprites[++spriteIndex/4 % NUM_SPRITES_IN_ONE_STEP];
    xPos = constrain(xPos + DIAGONAL_STEP_LENGTH_X, 0, width);
    
    float yLowerBound = isBattling ? ScreenSeparator.CENTER_Y_BOTTOM - ScreenSeparator.SCREEN_HEIGHT/2 + SPRITE_HEIGHT/2 : 
        ScreenSeparator.CENTER_Y_BOTTOM + 25;
    yPos = constrain(yPos - DIAGONAL_STEP_LENGTH_Y, yLowerBound, height - SPRITE_HEIGHT/2);
  }
  
  void stand() {
    switch (direction) {
      case dUP:
        activeSprite = upStandSprite;
        break;
        
      case dDOWN:
        activeSprite = downStandSprite;
        break;
        
      case dLEFT:
        activeSprite = leftStandSprite;
        break;
        
      case dRIGHT:
        activeSprite = rightStandSprite;
        break;
        
      case dUP_RIGHT:
        activeSprite = upRightStandSprite;
        break;
        
      case dUP_LEFT:
        activeSprite = upLeftStandSprite;
        break;      
        
      case dDOWN_RIGHT:
        activeSprite = downRightStandSprite;
        break;      
        
      case dDOWN_LEFT:
        activeSprite = downLeftStandSprite;
        break;    
      }
  }
  
  void moveForStanding() {
    println("moving to stand");
    switch (direction) {
      case dUP:
        goUp();
        break;
        
      case dDOWN:
        goDown();
        break;
        
      case dLEFT:
        goLeft();
        break;
        
      case dRIGHT:
        goRight();
        break;
        
      case dUP_RIGHT:
        goUpRight();
        break;
        
      case dUP_LEFT:
        goUpLeft();
        break;      
        
      case dDOWN_RIGHT:
        goDownRight();
        break;      
        
      case dDOWN_LEFT:
        goDownLeft();
        break;    
    }   
  }
  
  void drawShadow() {
    ellipseMode(CENTER);
    noStroke();
    fill(30,30, 30, 128);
    ellipse(xPos, yPos + SPRITE_HEIGHT/2 - 10, VERTICAL_SPRITE_WIDTH*scale, VERTICAL_SPRITE_WIDTH*scale/2);
  }
  
  void updateSpriteSize() {
//    switch (direction) {
//      case dUP:
//        scale = constrain(scale*0.995, 0.7, 1);
//        activeSprite.resize((int)(VERTICAL_SPRITE_WIDTH*scale), (int)(SPRITE_HEIGHT*scale)); 
//        break;
//        
//      case dDOWN:
//        scale = constrain(scale/0.995, 0.7, 1);
//        activeSprite.resize((int)(VERTICAL_SPRITE_WIDTH*scale), (int)(SPRITE_HEIGHT*scale)); 
//        break;
//        
//      case dUP_RIGHT:
//        scale = constrain(scale*0.995, 0.7, 1);
//        activeSprite.resize((int)(DIAGONAL_SPRITE_WIDTH*scale), (int)(SPRITE_HEIGHT*scale)); 
//        break;
//        
//      case dDOWN_RIGHT:
//        scale = constrain(scale/0.995, 0.7, 1);
//        activeSprite.resize((int)(DIAGONAL_SPRITE_WIDTH*scale), (int)(SPRITE_HEIGHT*scale)); 
//        break;
//        
//      case dDOWN_LEFT:
//        scale = constrain(scale/0.995, 0.7, 1);
//        activeSprite.resize((int)(DIAGONAL_SPRITE_WIDTH*scale), (int)(SPRITE_HEIGHT*scale)); 
//        break;
//        
//      case dUP_LEFT:
//        scale = constrain(scale*0.995, 0.7, 1);
//        activeSprite.resize((int)(DIAGONAL_SPRITE_WIDTH*scale), (int)(SPRITE_HEIGHT*scale)); 
//        break;
//    }
  }
  
  void fallDown() {    
    activeSprite = fallSprites[++fallIndex/4 % NUM_SPRITES_IN_FALL];
    if((fallIndex/4 % NUM_SPRITES_IN_FALL == 6) && (random(0, 100) > 20)) {  // Increase time the fallen neku stays flat on the ground.
      fallIndex--;
    }
    
    float pixelsToMove = fallIndex/4 % NUM_SPRITES_IN_FALL <= 5 ? 1.5 : 0;
    xPos = direction == dLEFT ? constrain(xPos + pixelsToMove, 0, width) : constrain(xPos - pixelsToMove, 0, width);  
  }
  
  void attack() {
    activeSprite = attackSprites[++attackIndex/4 % NUM_SPRITES_IN_ATTACK];
    if((attackIndex/4 % NUM_SPRITES_IN_ATTACK == 5) && (random(0, 100) > 20)) {  // Increase time the attacking neku stays in cool position.
      attackIndex--;
    }
  }
}
