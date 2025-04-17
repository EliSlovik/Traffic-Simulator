class Light {
  boolean isGreen;
  int timeGreen;
  
  Light(boolean isGreen, int timeGreen) {
    this.isGreen = isGreen;
    this.timeGreen = timeGreen;
  }
  
  void setTimeGreen(int time) {
    this.timeGreen = time;
  }
  
  String getColor() {
    return isGreen ? "Green" : "Red";
  }
}
