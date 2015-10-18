import ddf.minim.*;

ScreenSeparator screenSeparator;

StartScreen startScreen;
Transition transition;
Shibuya shibuya;
Neku neku;

Minim minim;

int state;
final int START_STATE = 1;
final int TRANSITION_STATE = 2;
final int SCRAMBLE_CROSSING_STATE = 3;
final int A_EAST_STATE = 4;
final int BATTLE_STATE = 5;

void setup() {
  size(458, 700); 
  frameRate(50);
  minim = new Minim(this);
  
  screenSeparator = new ScreenSeparator();
  startScreen = new StartScreen(minim);
  transition = new Transition();
  shibuya = new Shibuya(minim);
  neku = new Neku();
  
  state = START_STATE;
}

void draw() {  
  // Update the game's status.
  if ((state == START_STATE) && (startScreen.hasPressedStart)) {
    startScreen.display();
    startScreen.playStartSound();
    state = TRANSITION_STATE;
  } else if ((state == TRANSITION_STATE) && (transition.isFinishedDisplaying())) {
     state = SCRAMBLE_CROSSING_STATE;
     tint(255);
     shibuya.playAudio();
  }
  
  // Display the correct state.
  if (state == START_STATE) {
    startScreen.display();
  } else if (state == TRANSITION_STATE) {
    transition.display();
  } else if (state == SCRAMBLE_CROSSING_STATE) {
    shibuya.display();
    neku.move();
    neku.display();
  }
  
  displayStylus();
  screenSeparator.display();
}

void displayStylus() {
    fill(255, 175);
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
