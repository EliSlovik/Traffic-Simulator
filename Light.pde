class Light {
  boolean isGreen;
  //int timeGreen;
  long oldTime = 0;
  long timeGreen = 2000;
  long cycleTime = 4000;

  Light(boolean isGreen, int timeGreen) {
    this.isGreen = isGreen;
    this.timeGreen = timeGreen;
  }

  void setTimeGreen(int time) {
    this.timeGreen = time;
  }
  void runPattern() {
    //if(isGreen) {
    //    delay(timeGreen);
    //    isGreen = false;
    //    runPattern();
    //}else if(!isGreen) {
    //   delay(5000-timeGreen);
    //   isGreen = true;
    //   runPattern();
    //}
    long currentTime = millis();
    if (isGreen && (currentTime - oldTime) >= timeGreen) {
      isGreen = false;
      oldTime = currentTime;
    } else if (!isGreen && (currentTime - oldTime) >= (cycleTime - timeGreen)) {
      isGreen = true;
      oldTime = currentTime;
    }
  }
  String getColor() {
    return isGreen ? "Green" : "Red";
  }
}
