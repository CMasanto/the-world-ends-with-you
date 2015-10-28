class Bat {
  int frameCounter;
  
  PImage activeSprite;
  int spriteIndex;  // Tracks the index of the active sprite within its PImage array.
  
  float xPos;
  float yPos;
  
  float xMoveAttack;
  float yMoveAttack;
  
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
  
  int shadowDistance;  // The number of pixels the Bat's shadow appears below the bat (decreases when Bat attacks Neku).
  
  final static int SPRITE_WIDTH = 50;
  final static int SPRITE_HEIGHT = 68; 
  final static int NUM_SPRITES_IN_ONE_FLAP = 6;  // The number of sprites in each PImage sprite array.
  final static int NUM_SPRITES_IN_ONE_ATTACK = 4;
  final static int NUM_FRAMES_TO_ATTACK = 100;  // The duration of the bat's movement towards Neku.
  final static int NUM_HITS_BEFORE_DYING = 7;
  
  
  int attackFrame;  // The current frame during the attack (whch will last NUM_FRAMES_TO_ATTACK frames).
  int waitingFrames;  // The amount of time between attacks.
  
  int hitCounter;
  ArrayList<Slash> slashesThatHit;
  
  Bat(float x, float y, Minim m, Neku n) {
    frameCounter = 1;

    xPos = x;
    yPos = y;
    
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
        loadImage("Bat_Right1.png"),
        loadImage("Bat_Right2.png"),
        loadImage("Bat_Right3.png"),
        loadImage("Bat_Right4.png"),
        loadImage("Bat_Right5.png"),
        loadImage("Bat_Right6.png")
    };    
    
    leftAttackSprites = new PImage[] {
        loadImage("Bat_Attack_Left1.png"),
        loadImage("Bat_Attack_Left2.png"),
        loadImage("Bat_Attack_Left3.png"),
        loadImage("Bat_Attack_Left4.png") 
    };
    
    rightAttackSprites = new PImage[] {
        loadImage("Bat_Attack_Right1.png"),
        loadImage("Bat_Attack_Right2.png"),
        loadImage("Bat_Attack_Right3.png"),
        loadImage("Bat_Attack_Right4.png") 
    };
    
    currentEnemyX = neku.xPos;
    currentEnemyY = neku.yPos;
    
    isAttacking = false;
    waitingFrames = (int)random(180, 400);
    
    slashesThatHit = new ArrayList<Slash>();
    
    deathNoise = minim.loadFile("batDeathNoise.wav");
  }
  
  void display() {
    updatePosition();
    
    faceEnemy();
    if (isAttacking) {
      attack();
    } else {
      flap();
    }
    
    if (yPos >= ScreenSeparator.CENTER_Y_BOTTOM - ScreenSeparator.SCREEN_HEIGHT/2) {
      image(activeSprite, xPos, yPos);
    }
    
    if (yPos >= ScreenSeparator.CENTER_Y_BOTTOM - ScreenSeparator.SCREEN_HEIGHT/2 - 75) {
      drawShadow(); 
    }

    if (!isAttacking && (frameCounter++ % waitingFrames == 0)) {
      attackFrame = 0;
      isAttacking = true;
      yPos += 20;  // Bat lowers itself to the ground when attacking
    } else if (isAttacking && (attackFrame++ == 200)) {
      frameCounter = 1;
      isAttacking = false; 
      yPos -= 20;
    }
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
    facingRight = enemy.xPos < this.xPos;
  }
  
  void flap() {
    if (facingRight) {
      activeSprite = leftSprites[++spriteIndex/3 % NUM_SPRITES_IN_ONE_FLAP];
    } else {
      activeSprite = rightSprites[++spriteIndex/3 % NUM_SPRITES_IN_ONE_FLAP];
    }
  }
  
  void drawShadow() {
    ellipseMode(CENTER);
    noStroke();
    fill(30, 30, 30, 100);
    if (isAttacking) {
      ellipse(xPos, yPos + 55, 40, 20);  
    } else {
      ellipse(xPos, yPos + 75, 40, 20);  
    }
  }
  
  void attack() {
    if (facingRight) {
      activeSprite = leftAttackSprites[++spriteIndex/3 % NUM_SPRITES_IN_ONE_ATTACK];
    } else {
      activeSprite = rightAttackSprites[++spriteIndex/3 % NUM_SPRITES_IN_ONE_ATTACK];
    }  
    
    if (dist(xPos, yPos, neku.xPos, neku.yPos) > 20) {
      xPos += xPos < neku.xPos ? 3 : -3;
      yPos += yPos < neku.yPos ? 4.2 : -4.2;
    }
  }
  
  void die() {
    deathNoise.play(); 
  }
}
