class Battle {
  Minim minim;
  boolean musicIsPlaying;
  AudioPlayer backgroundMusic;
  AudioPlayer areYouReadyPlayer;
  AudioPlayer nekuIntro;
  
  PImage areYouReady;
  PImage battleTopImage;
  PImage battleBottomImage;
  
  int battleFrame;
  
  Battle(Minim m) {
    minim = m;
    backgroundMusic = minim.loadFile("OneStar.mp3");
    areYouReadyPlayer = minim.loadFile("Are_You_Ready.mp3");
    nekuIntro = minim.loadFile("Neku_Intro.mp3");
    musicIsPlaying = false; 
    
    areYouReady = loadImage("Are_You_Ready.png");
    battleTopImage = loadImage("scramble_crossing_battle_background_top.png");
    battleBottomImage = loadImage("scramble_crossing_battle_background_bottom.png");
    
    battleFrame = 0;
  }
  
  void display() {
    if (!musicIsPlaying) {
      backgroundMusic.loop();
      musicIsPlaying = true; 
    }
    displayBottomScreen();
    displayTopScreen();

    if (battleFrame++ < 180) {
      imageMode(CORNER);
      image(areYouReady, ScreenSeparator.SCREEN_WIDTH - battleFrame*4.5, ScreenSeparator.CENTER_Y_BOTTOM);
      image(areYouReady, ScreenSeparator.SCREEN_WIDTH - battleFrame*4.5, ScreenSeparator.CENTER_Y_TOP);
      if (battleFrame == 40) {
        areYouReadyPlayer.play();
      }
      
      if (battleFrame == 70) {
        nekuIntro.play(); 
      }
      
    } else {
      areYouReadyPlayer.rewind();  
      nekuIntro.rewind(); 
    }
  }
    
  void displayTopScreen() {
    imageMode(CENTER);  // Required for the following, alternate version of drawing (a subsection of) the image.
    image(battleTopImage, ScreenSeparator.CENTER_X_TOP, ScreenSeparator.CENTER_Y_TOP);
  }
   
  void displayBottomScreen() {
    imageMode(CENTER);
    image(
        battleBottomImage.get(
            (int)constrain(neku.xPos, ScreenSeparator.CENTER_X_BOTTOM - ScreenSeparator.SCREEN_WIDTH/2, battleBottomImage.width - ScreenSeparator.SCREEN_WIDTH), 
            (int)map(neku.yPos, ScreenSeparator.CENTER_Y_BOTTOM - ScreenSeparator.SCREEN_HEIGHT/2, ScreenSeparator.CENTER_Y_BOTTOM + ScreenSeparator.SCREEN_HEIGHT/2, 0, battleBottomImage.height - ScreenSeparator.SCREEN_HEIGHT), 
            ScreenSeparator.SCREEN_WIDTH, 
            ScreenSeparator.SCREEN_HEIGHT
        ), 
        ScreenSeparator.CENTER_X_BOTTOM, 
        ScreenSeparator.CENTER_Y_BOTTOM);
  }
   
}
