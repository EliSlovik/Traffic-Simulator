class Light {
  boolean isGreen;
  int interval;
  int lastSwitchTime;
  float x, y;
  String orientation; // "vertical" or "horizontal"

  Light(boolean isGreen, int interval, float x, float y, String orientation) {
    this.isGreen = isGreen;
    this.interval = interval;
    this.x = x;
    this.y = y;
    this.orientation = orientation;
    this.lastSwitchTime = millis();
  }

  void runPattern() {
    if (millis() - lastSwitchTime > interval) {
      isGreen = !isGreen;
      lastSwitchTime = millis();
    }
  }
}
