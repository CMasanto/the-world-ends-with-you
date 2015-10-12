class Transition {
  PImage bottomTransitionImage;
  PImage topTransitionImage;
  float transparency;
  int transparencyVelocity;
  int zeroCount;

  private static final int DECREASING = -1;
  private static final int INCREASING = 1;
  private static final int TRANSITION_STILL_FRAMES = 60;
  private static final int TRANSITION_TERMINATION_THRESHOLD = 0;

  Transition() {
    bottomTransitionImage = loadImage("transition_bottom.png");
    topTransitionImage = loadImage("transition_top.png");
    transparency = TRANSITION_TERMINATION_THRESHOLD;
    transparencyVelocity = INCREASING;
    zeroCount = 0;
  }
  
  void display() {
    background(0);
    imageMode(CENTER);
    topScreenTransition();
    bottomScreenTransition();
    updateTransitionEffect();
  }
  
  void topScreenTransition() {
    tint(255, transparency);
    image(topTransitionImage, ScreenSeparator.CENTER_X_TOP, ScreenSeparator.CENTER_Y_TOP); 
  }
  
  void bottomScreenTransition() {
    tint(255, transparency);
    image(bottomTransitionImage, ScreenSeparator.CENTER_X_BOTTOM, ScreenSeparator.CENTER_Y_BOTTOM); 
  }
  
  void updateTransitionEffect() {
    
    transparency += (transparencyVelocity == DECREASING) ? -1 : 1.3;
    if (transparency >= 255) {
      if (zeroCount < TRANSITION_STILL_FRAMES) {  // Freeze the transition image when it is no longer transparent.
         zeroCount++;
      } else {
        transparencyVelocity = DECREASING; 
      }
    }
  }
  
  boolean isFinishedDisplaying() {
    return transparency < TRANSITION_TERMINATION_THRESHOLD; 
  }
  
}

