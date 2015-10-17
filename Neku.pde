class Neku {
  PImage activeSprite;
  int xPos;
  int yPos;
  int scale;
  
  PImage[] leftRunSprites;
  PImage[] rightRunSprites;
  PImage[] upRunSprites;
  PImage[] downRunSprites;
  
  PImage[] upLeftRunSprites;
  PImage[] upRightRunSprites;
  PImage[] downLeftRunSprites;
  PImage[] downRightRunSprites;
  
  PImage leftStandSprite;
  PImage rightStandSprite;
  PImage upStandSprite;
  PImage downStandSprite;
  PImage upLeftStandSprite;
  PImage upRightStandSprite;
  PImage downLeftStandSprite;
  PImage downRightStandSprite;
  
  final int SPRITE_HEIGHT = 66;  // The original height of all Neku sprites
  final int DIAGONAL_SPRITE_WIDTH = 48;  // The width of Neku sprites moving diagonally.
  final int HORIZONTAL_SPRITE_WIDTH = 56;  // The width of Neku sprites moving horizontally.
  final int VERTICAL_SPRITE_WIDTH = 25;  // The width of Neku sprites moving vertically.

  Neku() {
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
    
    activeSprite = downStandSprite;
    xPos = ScreenSeparator.CENTER_X_BOTTOM;
    yPos = ScreenSeparator.CENTER_Y_BOTTOM + (ScreenSeparator.SCREEN_HEIGHT)/2 - SPRITE_HEIGHT;
    scale = 1;
  }
  
  void display() {
    image(activeSprite, xPos, yPos);
  }

}
