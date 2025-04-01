class Game {
  int carsLeft;
  int time;
  int level;
  String name;
  Car[] cars;
  
  Game(String name, int carsLeft, int time, int level, Car[] cars) {
    this.name = name;
    this.carsLeft = carsLeft;
    this.time = time;
    this.level = level;
    this.cars = cars;
  }
  
  void endGame() {
  }
  
  void pauseGame() {
  }
}

