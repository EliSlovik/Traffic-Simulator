//class Car {
//  int x, y;
//  int speed;
//  boolean isBlocked;
//  boolean isPassed;
//  int tempSpeed;
//  boolean vertical; // true = vertical movement
//  boolean up;       // true = moving up, false = moving down

//  Car(int x, int y, int speed, boolean isBlocked, boolean isPassed, boolean vertical, boolean up) {
//    this.x = x;
//    this.y = y;
//    this.speed = speed;
//    this.isBlocked = isBlocked;
//    this.isPassed = isPassed;
//    this.tempSpeed = speed;
//    this.vertical = vertical;
//    this.up = up;
//  }

//  int getSpeed() {
//    return speed;
//  }

//  void update() {
//    if (!isBlocked) {
//      if (vertical) {
//        if (up) {
//          y -= speed;
//        } else {
//          y += speed;
//        }
//      } else {
//        x += speed;
//      }
//    }
//  }

//  void stop() {
//    speed = 0;
//  }

//  void go() {
//    speed = tempSpeed;
//  }

//  void drawCar() {
//    fill(255, 0, 0);
//    if (vertical) {
//      rect(x, y, 40, 100);
//      fill(200, 0, 0);
//      rect(x - 20, y + 20, 20, 60);
//      fill(0);
//      ellipse(x + 40, y + 20, 20, 20);
//      ellipse(x + 40, y + 80, 20, 20);
//    } else {
//      rect(x, y, 100, 40);
//      fill(200, 0, 0);
//      rect(x + 20, y - 20, 60, 20);
//      fill(0);
//      ellipse(x + 20, y + 40, 20, 20);
//      ellipse(x + 80, y + 40, 20, 20);
//    }
//  }
//}
class Car {
  int x, y;
  int speed;
  boolean isBlocked; // Not used in current logic, but kept
  boolean isPassed;  // Not used in current logic, but kept
  int tempSpeed;
  boolean vertical; // true = vertical movement
  boolean up;       // if vertical: true = moving up, false = moving down

  Car(int x, int y, int speed, boolean isBlocked, boolean isPassed, boolean vertical, boolean up) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.isBlocked = false; // Car starts moving initially
    this.isPassed = isPassed;
    this.tempSpeed = speed; // Store the original speed
    this.vertical = vertical;
    this.up = up;
  }

  int getSpeed() {
    return speed;
  }

  void update() {
   // Only move if speed is greater than 0
   if (this.speed > 0) {
      if (vertical) {
        if (up) {
          y -= speed;
        } else {
          y += speed;
        }
      } else {
        x += speed;
      }
   }
   // Reset isBlocked flag conceptually - it's controlled by stop/go now
   this.isBlocked = (this.speed == 0);
  }

  void stop() {
    speed = 0;
    isBlocked = true; // Set blocked state when stopped
  }

  void go() {
    speed = tempSpeed; // Restore original speed
    isBlocked = false; // Unblock when told to go
  }

  void drawCar() {
    // Simplified drawing for clarity
    if (vertical) { // Draw vertical car
        if (up) { // Pointing up
           fill(0,0,200); // Blue for up
           rect(x, y, 40, 100); // Body
        } else { // Pointing down
           fill(200, 0, 0); // Red for down
           rect(x, y, 40, 100); // Body
        }

    } else { // Draw horizontal car (always moves right in this setup)
      fill(0, 150, 0); // Green for horizontal
      rect(x, y, 100, 40); // Body
    }
     // Simple wheels for all
     fill(0); // Black wheels
     if(vertical){
        ellipse(x - 5, y + 20, 10, 10);
        ellipse(x - 5, y + 80, 10, 10);
        ellipse(x + 45, y + 20, 10, 10);
        ellipse(x + 45, y + 80, 10, 10);
     } else {
        ellipse(x + 20, y - 5, 10, 10);
        ellipse(x + 80, y - 5, 10, 10);
        ellipse(x + 20, y + 45, 10, 10);
        ellipse(x + 80, y + 45, 10, 10);
     }

  }
}
