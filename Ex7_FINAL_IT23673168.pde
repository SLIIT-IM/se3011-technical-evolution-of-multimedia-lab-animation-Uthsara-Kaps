//------------------IT23673168----------------------
//----------FINAL TASK — Catch the Orb--------------


float px, py;     
float pr = 20;    
float step = 6;

float ox, oy;     
float oxs = 4, oys = 3;
float or_ = 15;     

float hx, hy;       
float ease = 0.10;

boolean trails = false;
int score = 0;

int state = 0;       
int startTime;
int duration = 30;

void setup() {
  size(700, 350);
  resetGame();
}

void resetGame() 
{
  px = width / 2;
  py = height / 2;
  hx = px;
  hy = py;
  ox = 100;
  oy = 100;
  oxs = 4;
  oys = 3;
  score = 0;
  trails = false;
}

void draw()
{

  if (state == 0) {
    background(21, 100, 215);
    textAlign(CENTER, CENTER);
    textSize(28);
    fill(0);
    text("Catch the Orb!", width/2, height/2 - 40);
    textSize(18);
    text("Arrow keys to move | T = trails", width/2, height/2);
    text("Press ENTER to Start", width/2, height/2 + 40);
    return;
  }


  if (state == 2) {
    background(8, 143, 143);
    textAlign(CENTER, CENTER);
    textSize(28);
    fill(0);
    text("Time's Up!", width/2, height/2 - 30);
    textSize(20);
    text("Final Score: " + score, width/2, height/2 + 10);
    textSize(16);
    text("Press R to Restart", width/2, height/2 + 50);
    return;
  }




  if (!trails) {
    background( 34, 67, 182);
  } else {
    noStroke();
    fill(255, 35);
    rect(0, 0, width, height);
  }


  int elapsed = (millis() - startTime) / 1000;
  int left = duration - elapsed;
  if (left <= 0) {
    state = 2;
    return;
  }

  if (keyPressed) 
  {
    if (keyCode == RIGHT) px += step;
    if (keyCode == LEFT)  px -= step;
    if (keyCode == DOWN)  py += step;
    if (keyCode == UP)    py -= step;
  }
  px = constrain(px, pr, width - pr);
  py = constrain(py, pr, height - pr);

  ox += oxs;
  oy += oys;
  if (ox > width - or_ || ox < or_)  oxs *= -1;
  if (oy > height - or_ || oy < or_) oys *= -1;

  
  hx = hx + (px - hx) * ease;
  hy = hy + (py - hy) * ease;

  
  float d = dist(px, py, ox, oy);
  if (d < pr + or_) 
  {
    score++;
     oxs *= 1.1;
     oys *= 1.1;
    
     ox = random(or_, width - or_);
     oy = random(or_, height - or_);
  }

  
  fill(255, 255, 0);
  noStroke();
  ellipse(ox, oy, or_*2, or_*2);

  
  fill(80, 200, 120);
  ellipse(hx, hy, 16, 16);

  fill(60, 120, 200);
  ellipse(px, py, pr*2, pr*2);

  fill(0);
  textAlign(LEFT, TOP);
  textSize(16);
  text("Score: " + score, 600, 20);
  text("Time: " + left, 596, 45);
  text("T = Trails: " + (trails ? "ON" : "OFF"), 560, 70);
}


void keyPressed() 
{
  if (state == 0 && keyCode == ENTER) 
  
  {
    resetGame();
    startTime = millis();
    state = 1;
  }
  
  if (state == 1 && (key == 't' || key == 'T')) 
  
  {
    trails = !trails;
  }
 
  if (state == 2 && (key == 'r' || key == 'R')) 
  {
    state = 0;
  }
  
}
