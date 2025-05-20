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
    this.speed = 2;
    this.isBlocked = false; // Car starts moving initially
    this.isPassed = isPassed;
    this.tempSpeed = 2; // Store the original speed
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
        if (up) {
          x += speed;
        } else {
          x-=speed;
        }
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
    if (vertical) {
      if (up) {
        fill(0, 0, 200);
        rect(x, y, 40, 100);
      } else {
        fill(200, 0, 0);
        rect(x, y, 40, 100);
      }
    } else {
      fill(0, 150, 0); 
      rect(x, y, 100, 40);
    }
    // Simple wheels for all
    fill(0); // Black wheels
    if (vertical) {
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
