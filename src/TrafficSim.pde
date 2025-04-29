Car[] cars;
Game game;
int roadWidth = 600;
int laneWidth = 200;
Light[] lights;

void setup() {
  size(800, 600);
  cars = new Car[] {
    new Car(-50, 120, 2, false, false, false, false),
    new Car(0, 200, 3, false, false, false, false),
    new Car(320, height + 50, 2, false, false, true, true),
    new Car(350, -50, 2, false, false, true, false)
  };
  lights = new Light[] {
    new Light(false, 3000, 350, 140, "horizontal"),
    new Light(true, 3000, 360, 150, "vertical")
  };

  game = new Game("test", cars.length, 60, 1, cars, lights);
}

void draw() {
  background(220);
  fill(100);
  rect(0, 100, width, 100);
  rect(300, 0, 100, height);

  for (int i = 0; i < game.lights.length; i++) {
    Light light = game.lights[i];
    light.runPattern();

    if (light.isGreen) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    circle(light.x, light.y, 50);
  }
  for (int i = 0; i < width / 40; i++) {
    fill(255, 255, 0);
    rect(40 * i + 7, 150 - 2, 25, 5);
  }
  for (Car car : game.cars) {
    boolean shouldStop = false;
    for (Light light : game.lights) {
      if (light.orientation.equals("horizontal") && !car.vertical) {
        if (!light.isGreen && car.x + 150 >= light.x && car.x <= light.x) {
          shouldStop = true;
          break;
        }
      } else if (light.orientation.equals("vertical") && car.vertical) {
        if (!light.isGreen && car.y + 50 >= light.y && car.y <= light.y  && !car.up) {
          shouldStop = true;
          break;
        } else if (!light.isGreen && car.y - 50 <= light.y && car.y >= light.y  && car.up) {
          shouldStop = true;
          break;
        }
      }
    }

    if (shouldStop) {
      car.stop();
    } else {
      car.go();
    }

    car.update();
    car.drawCar();
  }
}
