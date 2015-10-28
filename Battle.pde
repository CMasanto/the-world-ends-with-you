class Battle {
  Minim minim;
  Neku neku;
  boolean musicIsPlaying;
  AudioPlayer backgroundMusic;
  AudioPlayer areYouReadyPlayer;
  AudioPlayer nekuIntro;
  
  PImage areYouReady;
  PImage battleTopImage;
  PImage battleBottomImage;
  
  int battleFrame;
  int numNoiseErased;
  
  PFont font;
  long startTime;
  
  Battle(Minim m, Neku n) {
    minim = m;
    neku = n;
    
    backgroundMusic = minim.loadFile("OneStar.mp3");
    backgroundMusic.setGain(0);
    areYouReadyPlayer = minim.loadFile("Are_You_Ready.mp3");
    nekuIntro = minim.loadFile("Neku_Intro.mp3");
    musicIsPlaying = false; 
    
    areYouReady = loadImage("Are_You_Ready.png");
    battleTopImage = loadImage("scramble_crossing_battle_background_top.png");
    battleBottomImage = loadImage("scramble_crossing_battle_background_bottom.png");
    
    battleFrame = 0;
    numNoiseErased = 0;
    font = createFont("Herculanum", 36);
    startTime = -1;
  }
  
  void display() {
    if (startTime == -1) {
      startTime = millis();  // Only begin tracking time once the battle has begun
    }
    
    if (!musicIsPlaying) {
      backgroundMusic.loop();
      musicIsPlaying = true; 
    }
    displayBottomScreen();
    displayTopScreen();

    if (battleFrame++ < 180) {
      neku.canMove = false;
      imageMode(CORNER);
      image(
          areYouReady, 
          constrain(
              ScreenSeparator.SCREEN_WIDTH - battleFrame*4.5, 
              ScreenSeparator.CENTER_X_TOP - areYouReady.width/2, 
              10000000), 
          ScreenSeparator.CENTER_Y_TOP - areYouReady.height);
          
      image(
          areYouReady, 
          constrain(
              ScreenSeparator.SCREEN_WIDTH - battleFrame*4.5, 
              ScreenSeparator.CENTER_X_BOTTOM - areYouReady.width/2, 
              10000000), 
          ScreenSeparator.CENTER_Y_BOTTOM - areYouReady.height);
      
      if (battleFrame == 40) {
        areYouReadyPlayer.play();
      }
      
      if (battleFrame == 70) {
        nekuIntro.play(); 
      }
    } else {
      neku.canMove = true;
      areYouReadyPlayer.rewind();  
      nekuIntro.rewind(); 
    }
  }
    
  void displayTopScreen() {
    imageMode(CENTER);  // Required for the following, alternate version of drawing (a subsection of) the image.
    image(battleTopImage, ScreenSeparator.CENTER_X_TOP, ScreenSeparator.CENTER_Y_TOP);
    
    fill(255, 255, 102, 175);
    textAlign(CENTER);
    textFont(font, 36);
    text("Noise erased: " + numNoiseErased, ScreenSeparator.CENTER_X_TOP, ScreenSeparator.CENTER_Y_TOP + 80);
    
    String min = Long.toString((millis() - startTime)/1000/60);
    String sec = Long.toString(((millis() - startTime)/1000) % 60);
    min = min.length() == 1 ? 0 + min : min;
    sec = sec.length() == 1 ? 0 + sec : min;
    
//    text(min + ":" + sec, ScreenSeparator.CENTER_X_TOP, ScreenSeparator.CENTER_Y_TOP + 120);
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
