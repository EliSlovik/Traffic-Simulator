class Car {
  int speed;
  boolean isBlocked;
  boolean isPassed;
  
  Car(int speed, boolean isBlocked, boolean isPassed) {
    this.speed = speed;
    this.isBlocked = isBlocked;
    this.isPassed = isPassed;
  }
  
  int getSpeed() {
    return speed;
  }
}
