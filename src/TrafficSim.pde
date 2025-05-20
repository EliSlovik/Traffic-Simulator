Car[] cars = new Car[0];
Game game;
int roadWidth = 600;
int laneWidth = 200;
Light[] lights;
Button addCarButton;

void setup() {
  size(1500, 1300);
  lights = new Light[] {
    new Light(false, 5000, 350, 140, "horizontal"),
    new Light(true, 5000, 360, 150, "vertical")
  };
  game = new Game("test", cars.length, 60, 1, cars, lights);

  addCarButton = new Button(width - 160, height - 60, 150, 50, "Add Random Car", 16); // Positioned at bottom right
}

void draw() {
  background(220);
  // Draw Road
  fill(100);
  rect(0, 100, width, 100);
  rect(300, 0, 100, height);

  // Draw Lane Lines
  for (int i = 0; i < width / 40; i++) {
    fill(255, 255, 0);
    rect(40 * i + 7, 150 - 2, 25, 5);
  }
  // Add vertical lane line
  for (int i = 0; i < height / 40; i++) {
    fill(255, 255, 0);
    rect(350 - 2, 40 * i + 7, 5, 25);
  }


  // Run and Draw Lights
  for (int i = 0; i < game.lights.length; i++) {
    Light light = game.lights[i];
    light.runPattern();

    if (light.isGreen) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    if (light.orientation.equals("horizontal")) {
      circle(light.x + 25, light.y + 5, 30); // Move slightly right into intersection center
    } else {
      circle(light.x + 5, light.y + 25, 30); // Move slightly down into intersection center
    }
    fill(0);
  }


  for (Car car : game.cars) { // Use game.cars as it gets updated
    boolean shouldStop = false;
    for (Light light : game.lights) {
      // Refined stopping logic boundaries
      if (light.orientation.equals("horizontal") && !car.vertical) {
        // Stop before entering the intersection (x=300)
        if (!light.isGreen && car.x + 100 >= 300 && car.x < 300) { // Car's front edge nears intersection start
          shouldStop = true;
          break;
        }
      } else if (light.orientation.equals("vertical") && car.vertical) {
        if (!light.isGreen) {
          // Moving Down: Stop before entering intersection (y=100)
          if (!car.up && car.y + 100 >= 100 && car.y < 100) { // Car's front edge nears intersection start
            shouldStop = true;
            break;
          }
          // Moving Up: Stop before entering intersection (y=200)
          else if (car.up && car.y <= 200 && car.y + 100 > 200) { // Car's front edge nears intersection start
            shouldStop = true;
            break;
          }
        }
      }
    }

    if (shouldStop || isCarInFront(car)) {
      car.stop();
    } else {
      car.go();
    }
    car.update();
    car.drawCar();
    if (!car.vertical && car.x > width + 50) car.x = -150; // Reset horizontal cars
    if (car.vertical && !car.up && car.y > height + 50) car.y = -150; // Reset downward cars
    if (car.vertical && car.up && car.y < -150) car.y = height + 50; // Reset upward cars
  }
  addCarButton.display();
}

void mousePressed() {
  if (addCarButton.isPressed()) {
    addRandomCar();
  }
}

void addRandomCar() {
  int startX, startY;
  int carSpeed = 2;
  boolean isVertical = random(1) > 0.5; // 50% chance of vertical
  boolean isUp = random(1) > 0.5;
  if (isVertical) {
    if (isUp) {
      startX = 320;
      startY = height + 50;
    } else {
      startX = 360;
      startY = -100;
    }
  } else {
    if (isUp) {
      startX = -100;
      startY = 140;
    }
    else {
      startX = 1500;
      startY = 100; 
    }
  }

  Car newCar = new Car(startX, startY, carSpeed, false, false, isVertical, isUp);
  cars = (Car[]) append(cars, newCar);
  game.cars = cars;
  game.carsLeft = cars.length;
}


Boolean isCarInFront(Car currentCar) {
  for (Car other : game.cars) {
    if (other == currentCar) continue;
    if (currentCar.vertical && other.vertical && currentCar.up == other.up) {
      if (currentCar.up) {
        if (other.y < currentCar.y && currentCar.y - other.y < 110) {
          return true;
        }
      } else {
        if (other.y > currentCar.y && other.y - currentCar.y < 110) {
          return true;
        }
      }
    } else if (!currentCar.vertical && !other.vertical && currentCar.up == other.up) {
      if (currentCar.up) {
        if (other.x > currentCar.x && other.x - currentCar.x < 110) {
          return true;
        }
      } else {
        if (other.x < currentCar.x && currentCar.x - other.x < 110) {
          return true;
        }
      }
    }
  }
  return false;
}
