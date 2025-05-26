Car[] cars; //make arraylist later //<>//
Game game;
boolean started = false;
int roadWidth = 600;
int laneWidth = 200;
Light[] lights, lights2, lights3, lights4;
Button addCarButton, startButton;
Intersection[] inters;
int j = 0;
void setup() {
  size(1500, 1300);
  Table carTable;
  carTable = loadTable("test - Sheet1.csv", "header");
  cars = new Car[carTable.getRowCount()];
  for (TableRow row : carTable.rows()) {
    if (j<cars.length) {
      //int x = row.getInt("x");
      //int y = row.getInt("y");
      Boolean isBlocked = row.getString("isBlocked").equals("TRUE") ? true : false;
      Boolean vertical = row.getString("vertical").equals("TRUE") ? true : false;
      Boolean up = row.getString("up").equals("TRUE") ? true : false;
      int ID = row.getInt("ID");
      int timeBefore = row.getInt("timeBefore");
      //cars[j] = new Car(x, y, isBlocked, vertical, up);
      cars[j] = new Car(isBlocked, vertical, up, ID, timeBefore);
      System.out.println("" + cars[j].x + "     " + cars[j].y);
      j++;
    } else {
      break;
    }
  }
  lights = new Light[] {
    new Light(false, 5000, 600, 550, "horizontal"),
    new Light(true, 5000, 550, 500, "vertical")
  };
  lights2 = new Light[] {
    new Light(true, 3000, 350, 300, "horizontal"),
    new Light(false, 3000, 300, 250, "vertical")
  };
  lights3 = new Light[] {
    new Light(true, 2000, 600, 300, "horizontal"),
    new Light(false, 2000, 550, 250, "vertical")
  };
  lights4 = new Light[] {
    new Light(true, 3000, 350, 550, "horizontal"),
    new Light(false, 3000, 300, 500, "vertical")
  };
  game = new Game("test", cars.length, 60, 1, cars, lights);
  inters = new Intersection[] {
    new Intersection(3, 500, 500, lights),
    new Intersection(0, 250, 250, lights2),
    new Intersection(1, 500, 250, lights3),
    new Intersection(2, 250, 500, lights4)
  };
  addCarButton = new Button(width - 160, height - 60, 150, 50, "Add Random Car", 16);
  startButton = new Button(width/2, height/2, 300, 300, "Start", 20);
  drawStartScreen();
}

void draw() {
  if (started) {
    playGame();
  }
}
void mousePressed() {
  if (addCarButton.isPressed()) {
    addRandomCar();
  }
  if (startButton.isPressed()) {
    started = true;
  }
}
void drawStartScreen() {
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(32);
  text("Traffic Simulation", width / 2, height / 2 - 100);

  // Draw start button
  fill(100, 200, 100);
  startButton.display();
  fill(255);
  textSize(24);
}
void playGame() {
  background(220);
  for (Intersection inter : inters) {
    inter.display();
    fill(0);
  }
  for (Intersection inter : inters) {
    inter.displayLights();
  }
  for (Car car : cars) {
    fill(0);
    boolean shouldStop = false;
    for (Intersection inter : inters) {
      for (Light light : inter.lights) {
        if (light.orientation.equals("horizontal") && !car.vertical) {
          if (car.up && !light.isGreen && car.x == inter.x-100 && abs(inter.y-car.y) < 100) {
            shouldStop = true;
            break;
          } else if (!car.up && !light.isGreen && car.x == inter.x+100 && abs(inter.y-car.y) < 100) {
            shouldStop = true;
            break;
          }
        } else if (light.orientation.equals("vertical") && car.vertical) {
          if (!light.isGreen) {
            if (!car.up && car.y == inter.y-100 && abs(inter.x-car.x) < 100) {
              shouldStop = true;
              break;
            } else if (car.up && car.y == inter.y+100 && abs(inter.x-car.x) < 100) {
              shouldStop = true;
              break;
            }
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
    addCarButton.display();
  }
}
void addRandomCar() {
  int startX, startY;
  boolean isVertical = random(1) > 0.5; // 50% chance of vertical
  boolean isUp = random(1) > 0.5;
  if (isVertical) {
    if (isUp) {
      startX = 500;
      startY = height + 50;
    } else {
      startX = 550;
      startY = -100;
    }
  } else {
    if (isUp) {
      startX = -100;
      startY = 550;
    } else {
      startX = 1500;
      startY = 500;
    }
  }
  //Car newCar = new Car(startX, startY, false, isVertical, isUp);
  //cars = (Car[]) append(cars, newCar);
  game.cars = cars;
  game.carsLeft = cars.length;
}
Boolean isCarInFront(Car currentCar) {
  for (Car other : cars) { //this for loop checks if there is a car going the same direction that is infront of the current car
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
