class Intersection {
  int ID, x, y;
  Light[] lights;
  public Intersection(int id, int ex, int why, Light[] Lights) {
    this.ID = id;
    this.x = ex;
    this.y = why;
    this.lights = Lights;
  }
  public void display() {
    rect(0, y, width, 100);
    rect(x, 0, 100, height);

    for (int i = 0; i < width / 40; i++) {
      fill(255, 255, 0);
      rect(40 * i + 7, y+50, 25, 5);
    }
    for (int i = 0; i < height / 40; i++) {
      fill(255, 255, 0);
      rect(x+50, 40 * i + 7, 5, 25);
    }
  }
  void displayLights() {
    for (int i = 0; i < lights.length; i++) {
      Light light = lights[i];
      light.runPattern();

      if (light.isGreen) {
        fill(0, 255, 0);
      } else {
        fill(255, 0, 0);
      }
      if (light.orientation.equals("horizontal")) {
        circle(light.x, light.y, 30);
      } else {
        circle(light.x, light.y, 30);
      }
      fill(0);
    }
  }
}
