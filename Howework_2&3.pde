class Ball {
  float initialX, initialY;
  float x, y;
  float vx, vy;
  float size = 10;
  color c;

  Ball(float x, float y, color c) {
    this.x = initialX = x;
    this.y = initialY = y;
    this.c = c;
    vx = 2+random(1);
    vy = random(1);
  }

  void draw() {
    noStroke();
    fill(c);
    ellipse(x, y, size*2, size*2);
  }

  void reset() {
    x = initialX;
    y = initialY;
    vx = 2+random(1);
    if (random(1) < 0.5) {
      vx = -vx;
    }
    vy = random(2) - 1;
  }

  void move() {
    x += vx;
    y += vy;
    if (x < size || x > width-size) {
      vx = -vx;
    }
    if (y < size || y > height-size) {
      vy = -vy;
    }
    if (x-size < leftPaddle.x + leftPaddle.w) {
      if (y > leftPaddle.y &&
        y < leftPaddle.y + leftPaddle.h) {
        vx = -2*vx;
      } else {
        rightScore++;
        reset();
      }
    }
    if (x+size > rightPaddle.x) {
      if (y > rightPaddle.y &&
        y < rightPaddle.y + rightPaddle.h) {
        vx = -2*vx;
      } else {
        leftScore++;
        reset();
      }
      if (x-size < bottomPaddle.y + bottomPaddle.h) {
        if (x > bottomPaddle.x &&
          x < bottomPaddle.x + bottomPaddle.w) {
          vy = -2*vx;
        }
      }
      if (y+size > topPaddle.y) {
        if (x > topPaddle.x &&
          x < topPaddle.x + topPaddle.w) {
          vy = -2*vx;
        }
      }
    }
  }
}

class Paddle {
  float x, y;
  float vy;
  float w = 15, h = 80;
  color c;

  Paddle(float x, float y, color c) {
    this.x = x;
    this.y = y;
    this.c = c;
    vy = 0;
  }

  void draw() {
    noStroke();
    fill(c);
    rect(x, y, w, h);
  }

  void move() {
    y += vy;
    if (y < 0 || y > height-h) {
      vy = 0;
      y = constrain(y, 0, height-h);
    }
  }
}
class Paddle2 {
  float x, y;
  float vx;
  float w = 80, h = 15;
  color c;

  Paddle2(float x, float y, color c) {
    this.x = x;
    this.y = y;
    this.c = c;
    vx = 0;
  }

  void draw() {
    noStroke();
    fill(c);
    rect(x, y, w, h);
  }

  void move() {
    x += vx;
    if (x < 0 || x > height-w) {
      vx = 0;
      x = constrain(x, 0, height-w);
    }
  }
}
ArrayList<Ball> list;
Paddle leftPaddle, rightPaddle;
Paddle2 bottomPaddle, topPaddle;
int leftScore = 0;
int rightScore = 0;

void setup() {
  size(500, 500);
  colorMode(HSB);
  list = new ArrayList<Ball>();
  list.add(new Ball(width/2, height/2, color(random(255), 255, 255)));

  leftPaddle = new Paddle(15, 150, color(0));
  rightPaddle = new Paddle(width-15-15, 150, color(0));
  bottomPaddle = new Paddle2(150, 60, color(0));
  topPaddle = new Paddle2(150, height-15-60, color(0));
}

void drawScores() {
  textSize(32);
  text(""+leftScore, width/2-30, 40);
  text(""+rightScore, width/2+10, 40);
}

void draw() {
  background(255);

  for (int i = 0; i < list.size(); i += 1) {
    list.get(i).draw();
    list.get(i).move();
  }

  leftPaddle.move();
  leftPaddle.draw();
  rightPaddle.move();
  rightPaddle.draw();
  bottomPaddle.move();
  bottomPaddle.draw();
  topPaddle.move();
  topPaddle.draw();
  drawScores();
}

void mousePressed() {
  list.add(new Ball(mouseX, mouseY, color(random(255), 255, 255)));
}

void keyPressed() {
  if (key == 'q') {
    leftPaddle.vy = -4;
  }
  if (key == 'a') {
    leftPaddle.vy = 4;
  }
  if (key == 'o') {
    rightPaddle.vy = -4;
  }
  if (key == 'l') {
    rightPaddle.vy = 4;
  }
  if (key == 'k') {
    bottomPaddle.vx = -4;
  }
  if (key == 'm') {
    bottomPaddle.vx = 4;
  }
  if (key == 'w') {
    topPaddle.vx = -4;
  }
  if (key == 'd') {
    topPaddle.vx = 4;
  }
}

void keyReleased() {
  if (key == 'q' && leftPaddle.vy < 0) {
    leftPaddle.vy = 0;
  }
  if (key == 'a' && leftPaddle.vy > 0) {
    leftPaddle.vy = 0;
  }
  if (key == 'o' && rightPaddle.vy < 0) {
    rightPaddle.vy = 0;
  }
  if (key == 'l' && rightPaddle.vy > 0) {
    rightPaddle.vy = 0;
  }
  if (key == 'k' && bottomPaddle.vx < 0) {
    leftPaddle.vy = 0;
  }
  if (key == 'm' && bottomPaddle.vx > 0) {
    leftPaddle.vy = 0;
  }
  if (key == 'w' && topPaddle.vx < 0) {
    rightPaddle.vy = 0;
  }
  if (key == 'd' && topPaddle.vx > 0) {
    rightPaddle.vy = 0;
  }
}
