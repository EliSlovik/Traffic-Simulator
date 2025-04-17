Game game;
Car[] cars;
int roadWidth = 600;
int laneWidth = 200;
Light light = new Light(false, 500);
void setup() {
  size(800, 600);
  Car[] cars = {
    new Car(-50, 100, 2, false, false),
    new Car(0, 200, 3, false, false)
  };
  game = new Game("test", cars.length, 60, 1, cars);
}

void draw() {
  background(220);
  fill(100);
  rect(0, 100, width, 100);
  for (int i = 0; i<width/40; i++) {
    fill(255, 255, 0);
    rect(40*i+7, 150-2, 25, 5);
  }
  for (Car car : game.cars) {
    car.update();
    car.drawCar();
    if (car.x > 400) {
      if (!light.isGreen) {
        car.stop();
        delay(light.timeGreen);
        car.speed = 2;
      }
    }
  }
}
