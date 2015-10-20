class Battle {
  Minim minim;
  boolean musicIsPlaying;
  AudioPlayer backgroundMusic;
  
  PImage battleTopImage;
  PImage battleBottomImage;
  
  Battle(Minim m) {
    minim = m;
    backgroundMusic= minim.loadFile("OneStar.mp3");
    musicIsPlaying = false; 
    
    battleTopImage = loadImage("scramble_crossing_battle_background_top.png");
    battleBottomImage = loadImage("scramble_crossing_battle_background_bottom.png");
  }
  
  void display() {
    if (!musicIsPlaying) {
      backgroundMusic.loop();
      musicIsPlaying = true; 
    }
    
    displayTopScreen();
    displayBottomScreen();
  }
    
  void displayTopScreen() {
    imageMode(CENTER);  // Required for the following, alternate version of drawing (a subsection of) the image.
    image(battleTopImage, ScreenSeparator.CENTER_X_TOP, ScreenSeparator.CENTER_Y_TOP);
  }
   
  void displayBottomScreen() {
    imageMode(CENTER);
    image(
        battleBottomImage.get(
            battleBottomImage.width/2, 
            battleBottomImage.height/2, 
            ScreenSeparator.SCREEN_WIDTH, 
            ScreenSeparator.SCREEN_HEIGHT
        ), 
        ScreenSeparator.CENTER_X_BOTTOM, 
        ScreenSeparator.CENTER_Y_BOTTOM);
  }
   
}
