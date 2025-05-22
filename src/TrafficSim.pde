Car[] cars = new Car[1];//make arraylist later
Game game;
int roadWidth = 600;
int laneWidth = 200;
Light[] lights;
Light[] lights2;
Button addCarButton;
Intersection[] inters;
int j = 0;
void setup() {
  size(1500, 1300);
  Table carTable;
  carTable = loadTable("test - Sheet1.csv", "header");
  for (TableRow row : carTable.rows()) {
    int x = row.getInt("x");
    int y = row.getInt("y");
    Boolean isBlocked = row.getString("isBlocked") == "TRUE" ? true : false;
    Boolean vertical = row.getString("vertical") == "TRUE" ? true : false;
    Boolean up = row.getString("up") == "TRUE" ? true : false;
    cars[j] = new Car(x, y, isBlocked, vertical, up);
    j++;
  }
  lights = new Light[] {
    new Light(false, 5000, 600, 550, "horizontal"),
    new Light(true, 5000, 550, 500, "vertical")
  };
  lights2 = new Light[] {
    new Light(true, 3000, 350, 300, "horizontal"),
    new Light(false, 3000, 300, 250, "vertical")
  };
  game = new Game("test", cars.length, 60, 1, cars, lights);
  inters = new Intersection[] {
    new Intersection(0, 500, 500, lights),
    new Intersection(1, 250, 250, lights2)
  };
  addCarButton = new Button(width - 160, height - 60, 150, 50, "Add Random Car", 16);
}

void draw() {
  background(220);
  for (Intersection inter : inters) {
    inter.display();
    fill(0);
  }
  for (Intersection inter : inters) {
    inter.displayLights();
  }
  for (Intersection inter : inters) {
    for (Car car : cars) {
      boolean shouldStop = false;
      for (Light light : inter.lights) {
        if (light.orientation.equals("horizontal") && !car.vertical) {
          if (car.up && !light.isGreen && car.x+100 == inter.x) {
            shouldStop = true;
            break;
          } else if (!car.up && !light.isGreen && car.x == inter.x) {
            shouldStop = true;
            break;
          }
        } else if (light.orientation.equals("vertical") && car.vertical) {
          if (!light.isGreen) {
            if (!car.up && car.y+100 == inter.y) {
              shouldStop = true;
              break;
            } else if (car.up && car.y == inter.y+100) {
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
    }
    addCarButton.display();
  }
}
void mousePressed() {
  if (addCarButton.isPressed()) {
    addRandomCar();
  }
}

void addRandomCar() {
  int startX, startY;
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
    } else {
      startX = 1500;
      startY = 100;
    }
  }

  Car newCar = new Car(startX, startY, false, isVertical, isUp);
  cars = (Car[]) append(cars, newCar);
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
    //for (Car other : game.cars) {
    //  if (other.x > 300 && other.x < 400 && other.y > 100 && other.y < 200) {//check if there is a car in the intersection
    //    if ((currentCar.vertical && currentCar.up && currentCar.y <= 200 && currentCar.y + 100 > 200) ||
    //      (currentCar.vertical && !currentCar.up && currentCar.y + 100 >= 100 && currentCar.y < 100) ||
    //      (!currentCar.vertical && currentCar.up && currentCar.x + 100 >= 300 && currentCar.x < 250) ||
    //      (!currentCar.vertical && !currentCar.up && currentCar.x-100 <=200 && currentCar.x > 350)) {
    //      if (currentCar.vertical != other.vertical) { //check if it is in the way
    //        System.out.println("testing");
    //        return true;
    //      }
    //    }
    //  }
    //}
    return false;
  }
