class Shibuya {
  private PImage aEastBottom;
  private PImage aEastTop;
  private PImage scrambleCrossingBottom;
  private PImage scrambleCrossingTop;
  
  private AudioPlayer backgroundMusic;
  
  private float fadeInCounter;
  
  final int A_EAST = 2;
  final int CROSSING = 1;
  
  final int STARTING = 3;
  final int ENTERING_FROM_ANOTHER_SETTING = 4;
  
  private final int FADE_IN_TARGET_COUNT = 256;
  
 Shibuya(Minim minim) {
    imageMode(CENTER);
    scrambleCrossingTop = loadImage("scramble_crossing_top.png");
    scrambleCrossingBottom = loadImage("Scramble_Background_Bottom.jpg");
    
    backgroundMusic = minim.loadFile("underground.mp3");
    
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
     fadeInCounter ++;
   }
   image(scrambleCrossingTop, ScreenSeparator.CENTER_X_TOP, ScreenSeparator.CENTER_Y_TOP);
 }
 
  void displayBottomScreen() {
    imageMode(CENTER);
    int imgCenterX = scrambleCrossingBottom.width/2;
    int imgCenterY = scrambleCrossingBottom.height/2;
    image(
        scrambleCrossingBottom.get(
            imgCenterX - ScreenSeparator.SCREEN_WIDTH/2, 
            imgCenterY - ScreenSeparator.SCREEN_HEIGHT/2, 
            ScreenSeparator.SCREEN_WIDTH, 
            ScreenSeparator.SCREEN_HEIGHT
        ), 
        ScreenSeparator.CENTER_X_BOTTOM, 
        ScreenSeparator.CENTER_Y_BOTTOM);
  }
 
 void playerCanWalkLeft(Neku neku) {
   
 }
 
 void playerCanWalkRight(Neku neku) {
   
 }
 
 void playerCanWalkUp(Neku neku) {
   
 }
 
 void playerCanWalkDown(Neku neku) {
   
 }
 
 void playAudio() {
   backgroundMusic.loop(); 
   backgroundMusic.setGain(-30);
   backgroundMusic.shiftGain(backgroundMusic.getGain(), -15, 4000);
 }
  
}
