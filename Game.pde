class Game {
  int carsLeft;
  int time;
  int level;
  String name;
  Car[] cars;
  Light[] lights;
    Game(String name, int carsLeft, int time, int level, Car[] cars, Light[] lights) {
    this.name = name;
    this.carsLeft = carsLeft;
    this.time = 0;
    this.level = level;
    this.cars = cars;
    this.lights = lights;
  }

  void endGame() {
    println("Game Over!");
  }

  void pauseGame() {
    println("Game Paused.");
  }
}
