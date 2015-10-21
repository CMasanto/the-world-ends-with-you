import ddf.minim.*;

ScreenSeparator screenSeparator;

StartScreen startScreen;
Transition transition;
Shibuya shibuya;
SkullPin skullPin;
Neku neku;
Battle battle;

Minim minim;

int state;
final int START_STATE = 1;
final int TRANSITION_STATE = 2;
final int SCRAMBLE_STATE = 3;
final int BATTLE_STATE = 5;

void setup() {
  size(458, 700); 
//  frameRate(20);
  minim = new Minim(this);
  
  screenSeparator = new ScreenSeparator();
  startScreen = new StartScreen(minim);
  transition = new Transition();
  skullPin = new SkullPin(minim);
  neku = new Neku(minim);
  shibuya = new Shibuya(minim, neku);
  battle = new Battle(minim);
  
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
    neku.move();
    neku.display();
  }
  
  displayStylus();
  screenSeparator.display();
}

void displayStylus() {
    fill(255, 175);
    noStroke();
    noCursor();
    ellipse(mouseX, mouseY, 10, 10); 
}

void keyPressed() {
  println("key pressed");
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
        skullPin.focusAudio.pause();
        skullPin.focusAudio.rewind(); // Reset "focus" sound effect when user deactivates pin.
        skullPin.activationFieldRadius = skullPin.INITIAL_FIELD_RADIUS;  // Reset the field radius when deactivated.
      } else {
        skullPin.focusAudio.play(); 
      }
    } else if (skullPin.isActivated && dist(mouseX, mouseY, skullPin.noiseXPos, skullPin.noiseYPos) <= skullPin.NOISE_SYMBOL_RADIUS) {
      skullPin.isTransitioningToBattle = true;
      if (!skullPin.transitionMusic.isPlaying()) {
        shibuya.backgroundMusic.pause();
        skullPin.transitionMusic.play();
        skullPin.fadeInMusic();
      }
    }
  }
}
