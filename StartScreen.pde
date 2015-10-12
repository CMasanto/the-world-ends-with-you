class StartScreen {
  PImage bottomStartImage;
  PImage bottomStartShimmerImage;
  PImage topStartImage;
  PImage topStartShimmerImage;
  float transparency;
  
  Minim minim;  // The main audio controller.
  AudioPlayer welcomePlayer;
  AudioPlayer scratchPlayer;
  AudioPlayer selectPlayer;
  
  boolean fadeIn;
  boolean hasPressedStart;
  
  StartScreen(Minim minim) {
    bottomStartImage = loadImage("TWEWY_Start_Screen_bottom.jpg");
    bottomStartShimmerImage = loadImage("TWEWY_Start_Screen_bottom_shimmer.jpg");
    topStartImage = loadImage("TWEWY_Start_Screen_top.jpg");
    topStartShimmerImage = loadImage("TWEWY_Start_Screen_top_shimmer.jpg");
    transparency = 250;

    welcomePlayer = minim.loadFile("Wonderful.mp3");
    welcomePlayer.loop();
    
    scratchPlayer = minim.loadFile("startScratch.wav");
    selectPlayer = minim.loadFile("startSelect.wav");
        
    fadeIn = false;
    hasPressedStart = false;
  }
  
  void display() {
    imageMode(CENTER);
    topScreenShimmer();
    bottomScreenShimmer();
    updateShimmerEffect();
    updateStartStatus();
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
  
  void updateStartStatus() {
    if (mousePressed && (hasPressedStart == false)) {
      hasPressedStart = dist(70, 420, mouseX, mouseY) <= 50;
    } 
  }
  
  void playStartSound() {
    welcomePlayer.shiftGain(welcomePlayer.getGain(), -70, 6000);
    selectPlayer.play();
    scratchPlayer.play();
  }
  
}

