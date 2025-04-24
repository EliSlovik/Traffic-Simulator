Car[] cars;
Game game;
int roadWidth = 600;
int laneWidth = 200;
Light[] lights;

void setup() {
  size(800, 600);
  cars = new Car[] {
    new Car(-50, 100, 2, false, false),
    new Car(0, 200, 3, false, false)
  };
  lights = new Light[] {
    new Light(false, 2000),
    new Light(true, 3000)
  };
  game = new Game("test", cars.length, 60, 1, cars, lights);
}

void draw() {
  background(220);
  fill(100);
  rect(0, 100, width, 100);
  game.lights[0].runPattern();

  for (int i = 0; i < width / 40; i++) {
    fill(255, 255, 0);
    rect(40 * i + 7, 150 - 2, 25, 5);
  }

  if (game.lights[0].isGreen) {
    fill(0, 255, 0);
    circle(224, 184, 100);
  } else {
    fill(255, 0, 0);
    circle(224, 184, 100);
  }
  
  for (Car car : game.cars) {
    if (!game.lights[0].isGreen && car.x + 100 >= 200 && car.x <= 300) {
      car.stop();
    } else {
      car.go();
    }
    car.update();
    car.drawCar();
  }
}
