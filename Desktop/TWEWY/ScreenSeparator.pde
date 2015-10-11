class ScreenSeparator {
  
  static final int SCREEN_WIDTH = 426 - 20;
  static final int SCREEN_HEIGHT = 700/2 - 20;
  
  static final int CENTER_X_BOTTOM = 426/2;
  static final int CENTER_Y_BOTTOM = 700 * 3/4;
  static final int CENTER_X_TOP = 426/2;
  static final int CENTER_Y_TOP = 700 * 1/4;

 void display() {
   fill(255);
   noStroke();
   rectMode(CENTER);
   rect(5, height/2, 10, height);  // Left edge
   rect(width - 5, height/2, 10, height);  // Right edge
   rect(width/2, height/2, width, 20);  // Middle bridge
   rect(width/2, 5, width, 10);  // Top edge
   rect(width/2, height - 5, width, 10);  // Bottom edge
 }
  
}
