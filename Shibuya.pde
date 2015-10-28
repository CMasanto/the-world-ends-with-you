class Shibuya {
  private PImage aEastBottom;
  private PImage aEastTop;
  private PImage scrambleCrossingBottom;
  private PImage scrambleCrossingTop;
  
  AudioPlayer backgroundMusic;
  
  private float fadeInCounter;
  
  Neku neku;
  
  final int A_EAST = 2;
  final int CROSSING = 1;
  
  final int STARTING = 3;
  final int ENTERING_FROM_ANOTHER_SETTING = 4;
  
  private final int FADE_IN_TARGET_COUNT = 256;
  
 Shibuya(Minim minim, Neku n) {
    imageMode(CENTER);
    scrambleCrossingTop = loadImage("scramble_crossing_top.png");
    scrambleCrossingBottom = loadImage("Scramble_Background_Bottom.jpg");
    
    backgroundMusic = minim.loadFile("underground.mp3");
    
    neku = n;
    fadeInCounter = 0;
 }
 
 void display() {
   displayBottomScreen();
   displayTopScreen();
 }
 
 void displayTopScreen() {
   imageMode(CENTER);  // Required for the following, alternate version of drawing (a subsection of) the image.
   if (fadeInCounter < FADE_IN_TARGET_COUNT) {
     tint(255, fadeInCounter);
     fadeInCounter++;
   }
   image(scrambleCrossingTop, ScreenSeparator.CENTER_X_TOP, ScreenSeparator.CENTER_Y_TOP);
 }
 
  void displayBottomScreen() {
    imageMode(CENTER);
    image(
        scrambleCrossingBottom.get(
            (int)constrain(neku.xPos, ScreenSeparator.CENTER_X_BOTTOM - ScreenSeparator.SCREEN_WIDTH/2, scrambleCrossingBottom.width - ScreenSeparator.SCREEN_WIDTH), 
            (int)map(neku.yPos, ScreenSeparator.CENTER_Y_BOTTOM, ScreenSeparator.CENTER_Y_BOTTOM + ScreenSeparator.SCREEN_HEIGHT/2, 0, scrambleCrossingBottom.height - ScreenSeparator.SCREEN_HEIGHT), 
            ScreenSeparator.SCREEN_WIDTH, 
            ScreenSeparator.SCREEN_HEIGHT
        ), 
        ScreenSeparator.CENTER_X_BOTTOM, 
        ScreenSeparator.CENTER_Y_BOTTOM);
  }
 
 void playAudio() {
   backgroundMusic.loop(); 
   backgroundMusic.setGain(-30);
   backgroundMusic.shiftGain(backgroundMusic.getGain(), -15, 4000);
 }
  
}
