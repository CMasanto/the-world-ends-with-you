class Slash {
  float x;
  float y;
  float startX;
  float startY;
  float targetX;
  float targetY;
  int speed;  // speed in pixels per frame
  
  PImage[] slashSprites;
  PImage[] slashRightSprites;
  PImage[] slashLeftSprites;
  PImage activeSprite;
  int slashIndex;
    
  final static int NUM_SPRITES_IN_SLASH = 5;
  final static int SPRITE_HEIGHT = 65;
  final static int SPRITE_WIDTH = 80;
  
  Slash(float x, float y, float targetX, float targetY) {
    this.x = x;
    this.y = y;
    this.startX = x;
    this.startY = y;
    this.targetX = targetX;
    this.targetY = targetY;

    slashRightSprites = new PImage[]{
      loadImage("slashRight1.png"),
      loadImage("slashRight2.png"),
      loadImage("slashRight3.png"),
      loadImage("slashRight4.png"),
      loadImage("slashRight5.png")
    };
    
    slashLeftSprites = new PImage[]{
      loadImage("slashLeft1.png"),
      loadImage("slashLeft2.png"),
      loadImage("slashLeft3.png"),
      loadImage("slashLeft4.png"),
      loadImage("slashLeft5.png")
    };  
  }
  
  void display() {
    fly();
    if (y >= height/2 + SPRITE_HEIGHT/2) {    
      image(activeSprite, x, y);
    }
  }
  
  void fly() {
    
    activeSprite = slashSprites[++slashIndex/5 % NUM_SPRITES_IN_SLASH];
    
    x += (targetX - startX) / 15;
    y += (targetY - startY) / 15;
  }
}
