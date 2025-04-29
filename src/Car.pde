class Car {
  int x, y;
  int speed;
  boolean isBlocked;
  boolean isPassed;
  int tempSpeed;
  boolean vertical; // true = vertical movement
  boolean up;       // true = moving up, false = moving down

  Car(int x, int y, int speed, boolean isBlocked, boolean isPassed, boolean vertical, boolean up) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.isBlocked = isBlocked;
    this.isPassed = isPassed;
    this.tempSpeed = speed;
    this.vertical = vertical;
    this.up = up;
  }

  int getSpeed() {
    return speed;
  }

  void update() {
    if (!isBlocked) {
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
  }

  void stop() {
    speed = 0;
  }

  void go() {
    speed = tempSpeed;
  }

  void drawCar() {
    fill(255, 0, 0);
    if (vertical) {
      rect(x, y, 40, 100);
      fill(200, 0, 0);
      rect(x - 20, y + 20, 20, 60);
      fill(0);
      ellipse(x + 40, y + 20, 20, 20);
      ellipse(x + 40, y + 80, 20, 20);
    } else {
      rect(x, y, 100, 40);
      fill(200, 0, 0);
      rect(x + 20, y - 20, 60, 20);
      fill(0);
      ellipse(x + 20, y + 40, 20, 20);
      ellipse(x + 80, y + 40, 20, 20);
    }
  }
}
