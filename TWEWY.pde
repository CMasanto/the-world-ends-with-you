import ddf.minim.*;

ScreenSeparator screenSeparator;
StartScreen startScreen;
Transition transition;
Minim minim;

int state;
final int START_STATE = 1;
final int TRANSITION_STATE = 2;
final int SCRAMBLE_CROSSING_STATE = 3;
final int A_EAST_STATE = 4;
final int BATTLE_STATE = 5;

void setup() {
  size(458, 700); 
  minim = new Minim(this);
  
  screenSeparator = new ScreenSeparator();
  startScreen = new StartScreen(minim);
  transition = new Transition();
  
  state = START_STATE;
}

void draw() {  
  
  // State updating.
  if ((state == START_STATE) && (startScreen.hasPressedStart)) {
    startScreen.display();
    startScreen.playStartSound();
    state = TRANSITION_STATE;
  } else if ((state == TRANSITION_STATE) && (transition.isFinishedDisplaying())) {
     state = SCRAMBLE_CROSSING_STATE;
  }
  
  // States displaying.
  if (state == START_STATE) {
    startScreen.display();
    fill(255, 175);
    noCursor();
    ellipse(mouseX, mouseY, 10, 10);
  } else if (state == TRANSITION_STATE) {
    transition.display();
  } else if (state == SCRAMBLE_CROSSING_STATE) {
    // Display shibuya
  }
  
  screenSeparator.display();
}
