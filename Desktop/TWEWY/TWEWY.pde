import ddf.minim.*;

ScreenSeparator screenSeparator;
StartScreen startScreen;
Minim minim;

int state;
final int START_STATE = 1;
final int SCRAMBLE_CROSSING_STATE = 2;
final int A_EAST_STATE = 3;
final int BATTLE_STATE = 4;

void setup() {
  size(426, 700); 
  minim = new Minim(this);
  
  screenSeparator = new ScreenSeparator();
  startScreen = new StartScreen(minim);
  
  state = START_STATE;
}

void draw() {  
  
  if (state == START_STATE) {
    startScreen.display();
  }
  
  screenSeparator.display();
  text(mouseX + ", " + mouseY, mouseX, mouseY);
}
