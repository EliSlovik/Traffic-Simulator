class Car {
  int x, y;
  int speed;
  boolean isBlocked;
  boolean isPassed;

  Car(int x, int y, int speed, boolean isBlocked, boolean isPassed) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.isBlocked = isBlocked;
    this.isPassed = isPassed;
  }

  int getSpeed() {
    return speed;
  }

  void update() {
    if (!isBlocked && !isPassed) {
      x += speed;
    }
  }
  void stop() {
   speed = 0; 
  }
  void drawCar() {
    fill(255, 0, 0);
    rect(x, y, 100, 40);

    fill(200, 0, 0);
    rect(x + 20, y - 20, 60, 20);

    fill(0);
    ellipse(x + 20, y + 40, 20, 20);
    ellipse(x + 80, y + 40, 20, 20);
  }
}
