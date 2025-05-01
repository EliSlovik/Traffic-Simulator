//Car[] cars;
//Game game;
//int roadWidth = 600;
//int laneWidth = 200;
//Light[] lights;

//void setup() {
//  size(800, 600);
//  cars = new Car[] {
//    new Car(-50, 120, 2, false, false, false, false),
//    new Car(0, 200, 3, false, false, false, false),
//    new Car(320, height + 50, 2, false, false, true, true),
//    new Car(350, -50, 2, false, false, true, false)
//  };
//  lights = new Light[] {
//    new Light(false, 3000, 350, 140, "horizontal"),
//    new Light(true, 3000, 360, 150, "vertical")
//  };

//  game = new Game("test", cars.length, 60, 1, cars, lights);
//}

//void draw() {
//  background(220);
//  fill(100);
//  rect(0, 100, width, 100);
//  rect(300, 0, 100, height);

//  for (int i = 0; i < game.lights.length; i++) {
//    Light light = game.lights[i];
//    light.runPattern();

//    if (light.isGreen) {
//      fill(0, 255, 0);
//    } else {
//      fill(255, 0, 0);
//    }
//    circle(light.x, light.y, 50);
//  }
//  for (int i = 0; i < width / 40; i++) {
//    fill(255, 255, 0);
//    rect(40 * i + 7, 150 - 2, 25, 5);
//  }
//  for (Car car : game.cars) {
//    boolean shouldStop = false;
//    for (Light light : game.lights) {
//      if (light.orientation.equals("horizontal") && !car.vertical) {
//        if (!light.isGreen && car.x + 150 >= light.x && car.x <= light.x) {
//          shouldStop = true;
//          break;
//        }
//      } else if (light.orientation.equals("vertical") && car.vertical) {
//        if (!light.isGreen && car.y + 50 >= light.y && car.y <= light.y  && !car.up) {
//          shouldStop = true;
//          break;
//        } else if (!light.isGreen && car.y - 50 <= light.y && car.y >= light.y  && car.up) {
//          shouldStop = true;
//          break;
//        }
//      }
//    }

//    if (shouldStop) {
//      car.stop();
//    } else {
//      car.go();
//    }

//    car.update();
//    car.drawCar();
//  }
//}
 Car[] cars; // Already declared
 Game game; // Already declared
 int roadWidth = 600; // Already declared
 int laneWidth = 200; // Already declared
 Light[] lights; // Already declared
Button addCarButton; // Declare the button globally

void setup() {
  size(800, 600);
  cars = new Car[] {
    new Car(-50, 120, 2, false, false, false, false), // Horizontal, right moving
    new Car(0, 200, 3, false, false, false, false),   // Horizontal, right moving (This one will likely collide/overlap initially, maybe adjust y?) Let's change to 160
    new Car(320, height + 50, 2, false, false, true, true), // Vertical, up moving
    new Car(360, -50, 2, false, false, true, false)  // Vertical, down moving (Adjusted x for right lane)
  };
  // Corrected initial car positions slightly for better lane separation
  cars[1].y = 160;

  lights = new Light[] {
    new Light(false, 3000, 350, 140, "horizontal"),
    new Light(true, 3000, 360, 150, "vertical")
  };

  game = new Game("test", cars.length, 60, 1, cars, lights);

  // Initialize the button
  addCarButton = new Button(width - 160, height - 60, 150, 50, "Add Random Car", 16); // Positioned at bottom right
}

void draw() {
  background(220);
  // Draw Road
  fill(100);
  rect(0, 100, width, 100); // Horizontal road
  rect(300, 0, 100, height); // Vertical road

  // Draw Lane Lines
  for (int i = 0; i < width / 40; i++) {
    fill(255, 255, 0);
    rect(40 * i + 7, 150 - 2, 25, 5); // Horizontal lane line
  }
   // Add vertical lane line
   for (int i = 0; i < height / 40; i++) {
    fill(255, 255, 0);
    rect(350 - 2, 40 * i + 7, 5, 25); // Vertical lane line
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
    // Adjust circle position slightly to better align with roads
    if (light.orientation.equals("horizontal")) {
         circle(light.x + 25, light.y + 5, 30); // Move slightly right into intersection center
    } else {
         circle(light.x + 5, light.y + 25, 30); // Move slightly down into intersection center
    }
    // Reset fill
    fill(0);
  }


  // Update and Draw Cars
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

    if (shouldStop) {
      car.stop();
    } else {
      car.go();
    }

    car.update();
    car.drawCar();

    // Simple wrap-around / despawn logic (optional but good practice)
    if (!car.vertical && car.x > width + 50) car.x = -150; // Reset horizontal cars
    if (car.vertical && !car.up && car.y > height + 50) car.y = -150; // Reset downward cars
    if (car.vertical && car.up && car.y < -150) car.y = height + 50; // Reset upward cars

  }

  // Display the button
  addCarButton.display();
}

// Handle mouse press events
void mousePressed() {
  if (addCarButton.isPressed()) {
    addRandomCar();
  }
}

// Function to add a random car
void addRandomCar() {
  int startX, startY;
  int carSpeed = (int)random(2, 5); // Random speed between 2 and 4
  boolean isVertical = random(1) > 0.5; // 50% chance of vertical
  boolean isUp = false; // Default for horizontal or moving down

  if (isVertical) {
    isUp = random(1) > 0.5; // 50% chance of moving up if vertical
    if (isUp) {
      // Start from bottom, moving up (left vertical lane)
      startX = 320; // Left lane for upward traffic
      startY = height + 50;
    } else {
      // Start from top, moving down (right vertical lane)
      startX = 360; // Right lane for downward traffic
      startY = -100; // Start further off screen
    }
  } else {
    // Start from left, moving right (pick a horizontal lane)
    startX = -100; // Start further off screen
    startY = (random(1) > 0.5) ? 120 : 160; // Randomly pick top or bottom horizontal lane
    isUp = false; // Not applicable for horizontal, but set for clarity
  }

  // Create the new car
  Car newCar = new Car(startX, startY, carSpeed, false, false, isVertical, isUp);

  // Add the new car to the array
  // Use Processing's append() function which creates a new, larger array
  cars = (Car[]) append(cars, newCar);

  // IMPORTANT: Update the game object with the new array reference and count
  game.cars = cars;
  game.carsLeft = cars.length;

  println("Added a random car. Total cars:", game.carsLeft); // Optional debug message
}
