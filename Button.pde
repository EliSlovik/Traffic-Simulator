public class Button {
  int x;
  int y;
  int wid;
  int hei;
  String text;
  int textSize;

  public Button(int x, int y, int wid, int hei, String text, int textSize) {
    this.x = x;
    this.y = y;
    this.wid = wid;
    this.hei = hei;
    this.text = text;
    this.textSize = textSize;
  }
  void display() {
    fill(32,31,34);
    rect(x, y, wid, hei, 0,0,24,0);
    fill(237,36,144);
    textAlign(CENTER, CENTER);
    text(text, x + wid / 2, y + hei / 2);
    fill(12);
  }
  boolean isPressed() {
    if (mouseX >= x && mouseX <= x + wid && mouseY >= y && mouseY <= y + hei) {
      if (mousePressed) {
        return true;
      }
    }
    return false;
  }
}
