//main particle settings
int particles_num = 20;
float[] px, py;
float[] direction;
float speed = 5.0;
float particle_size = 4.0;

//background star settings
int bgStars_num = 200;
float[] bg_Px, bg_Py;
boolean[] bg_Visible;
int flash_interval = 60; //frames between flash updates

void setup() {
  size(1920, 1080);
  colorMode(HSB, 360, 100, 100);
  
  //initialize main particles
  px = new float[particles_num];
  py = new float[particles_num];
  direction = new float[particles_num];
  for (int i = 0; i < particles_num; i++) {
    px[i] = random(width);
    py[i] = random(height);
    direction[i] = random(TWO_PI);
  }
  
  //initialize background stars
  bg_Px = new float[bgStars_num];
  bg_Py = new float[bgStars_num];
  bg_Visible = new boolean[bgStars_num];
  for (int j = 0; j < bgStars_num; j++) {
    bg_Px[j] = random(width);
    bg_Py[j] = random(height);
    bg_Visible[j] = true;
  }
}

void draw() {
  //fade the background slightly for a trailing effect
  noStroke();
  fill(0, 10);
  rect(0, 0, width, height);
  
  //update and draw stars and particles
  updateBackgroundStars();
  drawBackgroundStars();
  updateMainParticles();
  drawMainParticles();
}

//function to update background stars
void updateBackgroundStars() {
  for (int j = 0; j < bgStars_num; j++) {
    //check every flash_interval frames
    if (frameCount % flash_interval == 0) {
      if (random(1) < 0.5) { //50% chance to toggle visibility
        bg_Visible[j] = !bg_Visible[j];
        if (!bg_Visible[j]) { //if turning invisible, reposition
          bg_Px[j] = random(width);
          bg_Py[j] = random(height);
        }
      }
    }
  }
}

//function to draw background stars
void drawBackgroundStars() {
  strokeWeight(1.6);
  stroke(0, 0, 100);
  for (int j = 0; j < bgStars_num; j++) {
    if (bg_Visible[j]) {
      point(bg_Px[j], bg_Py[j]);
    }
  }
}

//function to update main particles
void updateMainParticles() {
  for (int i = 0; i < particles_num; i++) {
    //move particle based on direction and speed
    px[i] += sin(direction[i]) * speed;
    py[i] += sin(direction[i]) * speed;
    
    //wrap around canvas edges
    if (px[i] < 0) {
      px[i] += width;
    }
    if (px[i] > width) {
      px[i] -= width;
    }
    if (py[i] < 0) {
      py[i] += height;
    }
    if (py[i] > height) {
      py[i] -= height;
    }
  }
}

//function to draw main particles
void drawMainParticles() {
  strokeWeight(particle_size);
  for (int i = 0; i < particles_num; i++) {
    //color based on x-position for a pattern
    float hue = map(px[i], 0, width, 0, 360);
    stroke(hue, 100, 100);
    point(px[i], py[i]);
  }
}
