class Bat {
  PImage activeSprite;
  int spriteIndex;  // Tracks the index of the active sprite within its PImage array.
  
  float xPos;
  float yPos;
  boolean facingRight;
  boolean isAttacking;
  
  PImage[] leftSprites;
  PImage[] rightSprites;
  
  PImage[] leftAttackSprites;
  PImage[] rightAttackSprites;
  
  Minim minim;
  AudioPlayer hitNoise;
  AudioPlayer deathNoise;
  
  Neku enemy;
  
  float currentEnemyX;
  float currentEnemyY;
  
  final int SPRITE_WIDTH = 50;
  final int SPRITE_HEIGHT = 68; 
  final int NUM_SPRITES_IN_ONE_FLAP = 6;  // The number of sprites in each PImage sprite array.
  
  Bat(float x, float y, Minim m, Neku n) {
    xPos = x;
    yPos = y;
    isAttacking = false;
    
    minim = m;
    enemy = n;
    
    leftSprites = new PImage[]{
        loadImage("Bat_Left1.png"),
        loadImage("Bat_Left2.png"),
        loadImage("Bat_Left3.png"),
        loadImage("Bat_Left4.png"),
        loadImage("Bat_Left5.png"),
        loadImage("Bat_Left6.png"),
    };   
  
    rightSprites = new PImage[]{
//        loadImage("Bat_Right1.png"),
//        loadImage("Bat_Right2.png"),
//        loadImage("Bat_Right3.png"),
//        loadImage("Bat_Right4.png"),
//        loadImage("Bat_Right5.png"),
//        loadImage("Bat_Right6.png"),
//        loadImage("Bat_Right7.png"),
//        loadImage("Bat_Right8.png")
    };    
    
    currentEnemyX = neku.xPos;
    currentEnemyY = neku.yPos;
  }
  
  void display() {
    updatePosition();
    
    faceEnemy();
    if (isAttacking) {
     
    } else {
      flap();
      drawShadow(); 
    }
     image(activeSprite, xPos, yPos);
//     updatePositionOnScreen();
  }
  
  void updatePosition() {
    float deltaX = enemy.xPos - currentEnemyX;
    float deltaY = enemy.yPos - currentEnemyY;
    
    xPos -= deltaX;
    yPos -= deltaY;
    
    currentEnemyX = enemy.xPos;
    currentEnemyY = enemy.yPos;
  }
  
  void faceEnemy() {
    facingRight = enemy.xPos > this.xPos;
  }
  
  void flap() {
    if (facingRight) {
      activeSprite = leftSprites[++spriteIndex/3 % NUM_SPRITES_IN_ONE_FLAP];
    } else {
//      activeSprite = rightSprites[++spriteIndex/3 % NUM_SPRITES_IN_ONE_FLAP];
      activeSprite = leftSprites[++spriteIndex/3 % NUM_SPRITES_IN_ONE_FLAP];
    }
  }
  
  void drawShadow() {
    ellipseMode(CENTER);
    noStroke();
    fill(30, 30, 30, 100);
    ellipse(xPos, yPos + 150, 40, 20);  
  }
}
