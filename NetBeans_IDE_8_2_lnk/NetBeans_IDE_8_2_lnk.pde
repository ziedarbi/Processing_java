import processing.video.*;
import gab.opencv.*;

Capture video;
OpenCV opencv;

PImage prevFrame;
//PVector[] points;
int index=0;
float threshold = 150;
//
int Mx = 0;
int My = 0;
int ave = 0;
//
int ballX = width/8;
int ballY = height/8;
//


int rsp = 5;

ArrayList<PVector> points = new ArrayList(); //Déclaration d’une liste de vecteurs

/// start mon projet 
void setup() {
  size(320, 240);
  video = new Capture(this, width, height, 30);
  video.start();
  prevFrame = createImage(video.width, video.height, RGB);
}

void draw() {
  //opencv.loadImage(video) ;
  //opencv.detect() ;

  // for (int i = 0; i < points.length; i++) {
  //  poss(points[i].x, points[i].y, points[i], points[i]);
  // }




  if (video.available()) {

    prevFrame.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height); 
    prevFrame.updatePixels();
    video.read();
  }

  loadPixels();
  video.loadPixels();
  prevFrame.loadPixels();

  Mx = 0;
  My = 0;
  ave = 0;


  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {

      int loc = x + y*video.width;            
      color current = video.pixels[loc];      
      color previous = prevFrame.pixels[loc]; 


      float r1 = red(current); 
      float g1 = green(current); 
      float b1 = blue(current);
      ///
      float r2 = red(previous); 
      float g2 = green(previous); 
      float b2 = blue(previous);
      ///
      float diff = dist(r1, g1, b1, r2, g2, b2);


      if (diff > threshold) { 
        pixels[loc] = video.pixels[loc];
        Mx += x;
        My += y;
        ave++;
      } else {

        pixels[loc] = video.pixels[loc];
      }
    }
  }
  fill(255);
  rect(0, 0, width, height);
  if (ave != 0) { 
    Mx = Mx/ave;
    My = My/ave;
  }
  if (Mx > ballX + rsp/2 && Mx > 50) {
    ballX+= rsp;
  } else if (Mx < ballX - rsp/2 && Mx > 50) {
    ballX-= rsp;
  }
  if (My > ballY + rsp/2 && My > 50) {
    ballY+= rsp;
  } else if (My < ballY - rsp/2 && My > 50) {
    ballY-= rsp;
  }

  updatePixels();
  noStroke();
  fill(0, 0, 255);
  ellipse(ballX, ballY, 20, 20); // 
  ///////////////////////////////////////

  points.add(new PVector(ballX, ballY)); // sauvgarde des points vecteur
  stroke(0, 255, 0); // je le donne un coleur vert
  strokeWeight(10.0);

  for (int i = 0; i < points.size()-1; i++) {
    line(points.get(i).x, points.get(i).y, points.get(i+1).x, points.get(i+1).y); // traçage de line ici

  


    //////////////////////////////////////
  }
  
  /// condition pour supprimé la mémoire de linge 
    if 
    (points.size() > 80) { // si la taille de la liste depace 40 
      points.remove(0); //alors supprimé la mémoire des points 
    }
}
