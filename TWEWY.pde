import ddf.minim.*;

ScreenSeparator screenSeparator;

StartScreen startScreen;
Transition transition;
Shibuya shibuya;
SkullPin skullPin;
Neku neku;
Battle battle;
Slash slashAttack;
ArrayList<Bat> enemies;
ArrayList<Bat> defeated;

PImage slashHitEnemyImage;

Minim minim;

int restartTransitionFrame = 0;

int state;
final int START_STATE = 1;
final int TRANSITION_STATE = 2;
final int SCRAMBLE_STATE = 3;
final int BATTLE_STATE = 5;

final int ENEMIES_PER_BATTLE = 4;

void setup() {
  size(458, 700); 
  minim = new Minim(this);
  startScreen = new StartScreen(minim);
  screenSeparator = new ScreenSeparator();
  transition = new Transition();
  initializeVariables();
  slashHitEnemyImage = loadImage("hit_sprite.png");
  
  state = START_STATE;
}

void draw() {  

  // Update the game's status.
  if ((state == START_STATE) && (startScreen.hasPressedStart)) {
    startScreen.display();
    startScreen.playStartSound();
    state = TRANSITION_STATE;
  } else if ((state == TRANSITION_STATE) && (transition.isFinishedDisplaying())) {
     state = SCRAMBLE_STATE;
     tint(255);
     shibuya.playAudio();
  } else if ((state == SCRAMBLE_STATE) && (skullPin.isReadyForBattle)) {
    state = BATTLE_STATE; 
    neku.isBattling = true;
    neku.canMove = true;
    neku.xPos = ScreenSeparator.CENTER_X_BOTTOM;
    neku.yPos = ScreenSeparator.CENTER_Y_BOTTOM;
    initializeEnemies();
    defeated = new ArrayList<Bat>();
  } else if ((state == BATTLE_STATE) && (battle.numNoiseErased == enemies.size())) {
    if ((restartTransitionFrame++ == 60)) {
      neku.victoryVoice();
      battle.backgroundMusic.shiftGain(battle.backgroundMusic.getGain(), -50, 15000);
    } else if (restartTransitionFrame > 240) {
      battle.backgroundMusic.pause();
      battle.backgroundMusic.rewind();
      initializeVariables();
      shibuya.playAudio();
      state = SCRAMBLE_STATE;
    }
  }
  
  // Display the correct state.
  if (state == START_STATE) {
    startScreen.display();
  } else if (state == TRANSITION_STATE) {
    transition.display();
  } else if (state == SCRAMBLE_STATE) {
    shibuya.display();
    neku.move();
    neku.display();
    skullPin.display();
  } else if (state == BATTLE_STATE) {
    battle.display();
    updateNekuStatus();
    
    if (neku.isHit) {
      neku.fallDown();
    } else if (neku.isAttacking){
      neku.attack();
      slashAttack.display();
    } else {
      neku.move(); 
    }
    
    neku.display();
    for (Bat b : enemies) {
      if (neku.isHit) {
        b.isAttacking = b.isAttacking && random(0, 100) < 20; 
      }
      if (b.hitCounter < Bat.NUM_HITS_BEFORE_DYING) {
        b.display();
      } 
    }
  }
  
  displayStylus();
  screenSeparator.display();
}

void displayStylus() {
  if (state == BATTLE_STATE) {
    fill(255, 0, 0, 175);  // Red stylus, but only during battle.
  } else {
    fill(255, 175);
  }
  noStroke();
  noCursor();
  ellipse(mouseX, mouseY, 10, 10); 
}

void initializeEnemies() {
  enemies = new ArrayList<Bat>();
  final int numEnemies = (int)random(4, 7);
  for (int i = 0; i < ENEMIES_PER_BATTLE; i++) {
    float batX = -1;
    float batY = -1;
    batX = random(
        ScreenSeparator.CENTER_X_BOTTOM - ScreenSeparator.SCREEN_WIDTH/2,
        ScreenSeparator.CENTER_X_BOTTOM + ScreenSeparator.SCREEN_WIDTH/2);
        
    batY = random(
        ScreenSeparator.CENTER_Y_BOTTOM - ScreenSeparator.SCREEN_HEIGHT/2,
        ScreenSeparator.CENTER_Y_BOTTOM + ScreenSeparator.SCREEN_HEIGHT/2);    
    enemies.add(new Bat(batX, batY, minim, neku)); 
  } 
}

void keyPressed() {
  println("key pressed");
  if (!neku.canMove) {
    neku.keyIsPressed[neku.dUP] = false;
    neku.keyIsPressed[neku.dDOWN] = false;
    neku.keyIsPressed[neku.dLEFT] = false;
    neku.keyIsPressed[neku.dRIGHT] = false;
    return;
  }
  
  if (key == CODED) {
    switch (keyCode) {
      case UP: 
        neku.keyIsPressed[neku.dUP] = true;
        break;
      
      case DOWN: 
        neku.keyIsPressed[neku.dDOWN] = true;
        break;
      
      case LEFT:
        neku.keyIsPressed[neku.dLEFT] = true;
        break;
        
      case RIGHT:
        neku.keyIsPressed[neku.dRIGHT] = true;
        break;
    }
  }
}

void keyReleased() {
  println("key released");
  if (key == CODED) {
    switch (keyCode) {
      case UP: 
        println("released up");
        neku.keyIsPressed[neku.dUP] = false;
        break;
      
      case DOWN: 
        println("released down");
        neku.keyIsPressed[neku.dDOWN] = false;
        break;
      
      case LEFT:
        println("released left");
        neku.keyIsPressed[neku.dLEFT] = false;
        break;
        
      case RIGHT:
        println("released right");
        neku.keyIsPressed[neku.dRIGHT] = false;
        break;
    }  
  }
}

void mousePressed() {
  println("mouse pressed");
  if (state == SCRAMBLE_STATE) {
    if (dist(mouseX, mouseY, skullPin.X_POS, skullPin.Y_POS) <= skullPin.PIN_RADIUS) {
      skullPin.isActivated = !skullPin.isActivated;
      if (!skullPin.isActivated) {
        neku.canMove = true;
        skullPin.focusAudio.pause();
        skullPin.focusAudio.rewind(); // Reset "focus" sound effect when user deactivates pin.
        skullPin.activationFieldRadius = skullPin.INITIAL_FIELD_RADIUS;  // Reset the field radius when deactivated.
      } else {
        skullPin.focusAudio.play(); 
        neku.canMove = false;
      }
    } else if (skullPin.isActivated && dist(mouseX, mouseY, skullPin.noiseXPos, skullPin.noiseYPos) <= skullPin.NOISE_SYMBOL_RADIUS) {
      skullPin.isTransitioningToBattle = true;
      if (!skullPin.transitionMusic.isPlaying()) {
        shibuya.backgroundMusic.pause();
        skullPin.transitionMusic.play();
        skullPin.fadeInMusic();
      }
    }
  } else if (state == BATTLE_STATE && !neku.isAttacking && !neku.isHit) {
    print("Neku attacked");
    neku.attackSprites = mouseX < neku.xPos ? neku.attackSpritesLeft : neku.attackSpritesRight;
    
    slashAttack = neku.direction == neku.dLEFT ? new Slash(neku.xPos, neku.yPos, mouseX, mouseY) : new Slash(neku.xPos, neku.yPos, mouseX, mouseY);
    slashAttack.slashSprites = neku.attackSprites == neku.attackSpritesLeft ? slashAttack.slashLeftSprites : slashAttack.slashRightSprites;
    neku.direction = mouseX < neku.xPos ? neku.dLEFT : neku.dRIGHT;
    neku.isAttacking = true;
    neku.attackIndex = 0;
    neku.makeSlashSound();
    neku.attackVoice();
  }
}

void updateNekuStatus() {
  if (neku.isHit && (neku.fallIndex == neku.NUM_SPRITES_IN_FALL * 4)) {
    neku.isHit = false;
    return; 
  } else if (neku.isAttacking && (neku.attackIndex == neku.NUM_SPRITES_IN_ATTACK * 4)) {
    neku.isAttacking = false;
    return;
  }
  
  for (Bat b : enemies) {
    if (b.hitCounter >= Bat.NUM_HITS_BEFORE_DYING) {
      if(!defeated.contains(b)) {
        b.die();
        battle.numNoiseErased++;
        defeated.add(b);
      }
      continue;
    }
    
    if (!neku.isHit && b.isAttacking && (dist(b.xPos, b.yPos, neku.xPos, neku.yPos) <= 20)) {
      b.playHitSound();
      neku.gotHitVoice();
      neku.isHit = true; 
      neku.fallIndex = 0;
      
      if (b.xPos < neku.xPos) {
        neku.fallSprites = neku.fallDownRightSprites;
        neku.direction = neku.dLEFT;
      } else {
        neku.fallSprites = neku.fallDownLeftSprites;
        neku.direction = neku.dRIGHT;
      }
      
      neku.fallDown();
      return;
    } else if (slashAttack != null && dist(slashAttack.x, slashAttack.y, b.xPos, b.yPos) <= Slash.SPRITE_WIDTH) {
      image(slashHitEnemyImage, b.xPos, b.yPos);
      
      if (!b.slashesThatHit.contains(slashAttack)) {
        b.slashesThatHit.add(slashAttack);
        b.hitCounter++;
        
        b.damageNum = (int)random(20, 30);
        b.damageFrame = 1;
        b.damageNumberX = (int)b.xPos;
        b.damageNumberY = (int)b.yPos;
        b.damageNumberFallsToTheRight = !b.damageNumberFallsToTheRight;  // The damage will alternate beteween falling to the left and to the right.
      } 
    }
  } 
}

void initializeVariables() {
  skullPin = new SkullPin(minim);
  neku = new Neku(minim);
  shibuya = new Shibuya(minim, neku);
  battle = new Battle(minim, neku); 
}

void resetAudio() {
  
}

