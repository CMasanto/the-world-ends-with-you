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
//    scrambleCrossingBottom = loadImage();
    imageMode(CENTER);
    scrambleCrossingTop = loadImage("scramble_crossing_top.png");
    
    backgroundMusic = minim.loadFile("underground.mp3");
    
    fadeInCounter = 0;
 }
 
 void display() {
   displayTopScreen();
 }
 
 void displayTopScreen() {
   if (fadeInCounter < FADE_IN_TARGET_COUNT) {
     tint(255, fadeInCounter);
     fadeInCounter += 0.2;
   }
   image(scrambleCrossingTop, ScreenSeparator.CENTER_X_TOP, ScreenSeparator.CENTER_Y_TOP);
 }
 
 void updateSetting(int location, int state) {
   
 }
 
 void playAudio() {
   backgroundMusic.loop(); 
   backgroundMusic.setGain(-30);
   backgroundMusic.shiftGain(backgroundMusic.getGain(), -5, 5000);
 }
  
}
