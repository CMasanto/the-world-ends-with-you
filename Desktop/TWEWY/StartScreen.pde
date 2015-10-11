class StartScreen {
  PImage bottomStartImage;
  PImage bottomStartShimmerImage;
  PImage topStartImage;
  PImage topStartShimmerImage;
  float transparency;
  
  Minim minim;  // The main audio controller.
  AudioPlayer welcomePlayer;
  
  boolean fadeIn;
  boolean hasPressedStart;
  boolean isHoveringOverStart;
  
  StartScreen(Minim minim) {
    bottomStartImage = loadImage("TWEWY_Start_Screen_bottom.jpg");
    bottomStartShimmerImage = loadImage("TWEWY_Start_Screen_bottom_shimmer.jpg");
    topStartImage = loadImage("TWEWY_Start_Screen_top.jpg");
    topStartShimmerImage = loadImage("TWEWY_Start_Screen_top_shimmer.jpg");
    transparency = 250;

    welcomePlayer = minim.loadFile("Wonderful.mp3");
    welcomePlayer.loop();
    
    fadeIn = false;
    hasPressedStart = false;
    isHoveringOverStart = false;
  }
  
  void display() {
    imageMode(CENTER);
    topScreenShimmer();
    bottomScreenShimmer();
    updateShimmerEffect();
  }
  
  void topScreenShimmer() {
    imageMode(CENTER);
    tint(255, 255 - transparency);
    image(topStartImage, ScreenSeparator.CENTER_X_TOP, ScreenSeparator.CENTER_Y_TOP);
    tint(255, transparency);
    image(topStartShimmerImage, ScreenSeparator.CENTER_X_TOP, ScreenSeparator.CENTER_Y_TOP); 
  }
  
  void bottomScreenShimmer() {
    imageMode(CENTER);
    tint(255, 255 - transparency);
    image(bottomStartImage, ScreenSeparator.CENTER_X_BOTTOM, ScreenSeparator.CENTER_Y_BOTTOM);
    tint(255, transparency);
    image(bottomStartShimmerImage, ScreenSeparator.CENTER_X_BOTTOM, ScreenSeparator.CENTER_Y_BOTTOM); 
  }
  
  void updateShimmerEffect() {
    fadeIn = (transparency == 0) || (transparency == 250) ? !fadeIn : fadeIn;
    transparency = fadeIn ? transparency - 5 : transparency + 2.5; 
  }
  
//  boolean hasPressedStart() {
//    return hasPressedStart;
//  }
//  
//  boolean isHoveringOverStart() {
//    
//  }
  
  void mouseClicked() {

  }
  
}
