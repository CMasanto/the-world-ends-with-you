class Slash {
  int x;
  int y;
  int speed;  // speed in pixels per frame
  
  PImage[] slashSprites;
  PImage[] slashRightSprites;
  PImage[] slashLeftSprites;
  PImage currentSprite;
  int slashIndex;
  
  final static int NUM_SPRITES_IN_SLASH = 5;
  
  Slash(int x, int y, int targetX, int targetY) {
    this.x = x;
    this.y = y;
    this.targetX = targetX;
    this.targetY = targetY;
    speed = 1;
    
    slashRightSprites = new PImage[]{
      "slashRight1.png",
      "slashRight2.png",
      "slashRight3.png",
      "slashRight4.png",
      "slashRight5.png"
    };
    
    slashLeftSprites = new PImage[]{
      "slashLeft1.png",
      "slashLeft2.png",
      "slashLeft3.png",
      "slashLeft4.png",
      "slashLeft5.png"
    };  
  }
  
  void display() {
    image(activeSprite, x, y);
  }
  
  void fly() {
    activeSprite = slashSprites[++slashIndex/10 % NUM_SPRITES_IN_SLASH];
  }
}
