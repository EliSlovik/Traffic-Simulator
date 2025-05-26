class Car {
  int x, y;
  int speed;
  boolean isBlocked;
  int tempSpeed;
  boolean vertical;
  boolean up;
  int ID;
  int timeBefore;
  Car(boolean isBlocked, boolean vertical, boolean up, int ID, int timeBefore) {
    //this.x = x;
    //this.y = y;
    this.speed = 2;
    this.isBlocked = false;
    this.tempSpeed = 2;
    this.vertical = vertical;
    this.ID = ID;
    this.up = up;
    this.timeBefore = timeBefore;
    if (ID == 0) {
      if (up && !vertical) {
        this.x = 0-(100*timeBefore);
        this.y = 300;
      }
      if (!up && vertical) {
        this.x = 250;
        this.y = 0-(100*timeBefore);
      }
    }
    if (ID == 1) {
      if (!up & vertical) {
        this.x = 500;
        this.y = 0-(100*timeBefore);
      }
      if (!up && !vertical) {
        this.x = 1500 + (100*timeBefore);
        this.y = 250;
      }
    }
    if(ID == 2) {
      if(up && vertical) {
         this.x = 300;
         this.y = 1300 + (100*timeBefore);
      }
      if(up && !vertical) {
          this.x = 0-(100*timeBefore);
          this.y = 550;
      }
    }
    if(ID == 3) {
      if(up && vertical) {
         this.x = 550;
         this.y = 1300 + (100*timeBefore);
      }
      if(!up && !vertical) {
         y = 500;
         x = 1500 + (100*timeBefore);
      }
    }
  }
  int getSpeed() {
    return speed;
  }

  void update() {
    if (this.speed > 0) {
      if (vertical) {
        if (up) {
          y -= speed;
        } else {
          y += speed;
        }
      } else {
        if (up) {
          x += speed;
        } else {
          x-=speed;
        }
      }
    }
    this.isBlocked = (this.speed == 0);
  }

  void stop() {
    speed = 0;
    isBlocked = true;
  }

  void go() {
    speed = tempSpeed;
    isBlocked = false;
  }

  void drawCar() {
    if (vertical) {
      if (up) {
        fill(0, 0, 200);
        rect(x, y, 35, 100);
      } else {
        fill(200, 0, 0);
        rect(x, y, 35, 100);
      }
    } else {
      fill(0, 150, 0);
      rect(x, y, 100, 35);
    }
    // Simple wheels for all
    //fill(50); // Black wheels
    //if (vertical) {
    //  ellipse(x - 5, y + 20, 10, 10);
    //  ellipse(x - 5, y + 80, 10, 10);
    //  ellipse(x + 45, y + 20, 10, 10);
    //  ellipse(x + 45, y + 80, 10, 10);
    //} else {
    //  ellipse(x + 20, y - 5, 10, 10);
    //  ellipse(x + 80, y - 5, 10, 10);
    //  ellipse(x + 20, y + 45, 10, 10);
    //  ellipse(x + 80, y + 45, 10, 10);
    //}
  }
}
