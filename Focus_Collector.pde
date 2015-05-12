/*Amy Friedman Copyright 2015
Credit to Jorge Cardoso for eyetribe library
Credit to Philipp Seifried for heatmap processing file
Special Thanks to Golan Levin

The program shows 5 different images over time and
collects gaze points from the eye tribe as one looks
at the images used. The gaze points are save to a 
 .tsv file. You have to manually change the name
for each new participant I was unable to figure that 
part out
At end of viewing image sequence it plays back the images 
with your eyetracking data in heatmap, scatterplot and scatterlineplot
*/
import org.jorgecardoso.processing.eyetribe.*;
import com.theeyetribe.client.data.*;
import java.util.Collections;

PVector point;
EyeTribe eyeTribe;
//ArrayList<PVector> tracking;

PImage heatmapBrush; // radial gradient used as a brush. Only the blue channel is used.
PImage heatmapColors; // single line bmp containing the color gradient for the finished heatmap, from cold to hot
PImage gradientMap; // canvas for the intermediate map
PImage heatmap; // canvas for the heatmap
PImage clickmap; // canvas for the clickmap
float maxValue = 0; // variable storing the current maximum value in the gradientMap

PrintWriter recordData;
PImage img1, img2, img3, img4, img5, img6, img7;
float picnum,picdig=0;
float timediff;


int savedTime, savedDiff;
int totalTime = 2000;
int number =1;
ArrayList<Datapoint> dataCollected; //need for table

boolean sketchFullScreen() {
  return true;
  //return false;
}

void setup() {
  savedTime = millis();
  savedDiff = millis();
  size(displayWidth, displayHeight);
  dataCollected = new ArrayList<Datapoint>(); // our intention to fill this ArrayList with datapoint objects

  //size(800, 600);
  img1 = loadImage("1.jpg");
  img2 = loadImage("2.jpg");
  img3 = loadImage("3.jpg");
  img4 = loadImage("4.jpg");
  img5 = loadImage("5.jpg");
//  img1 = loadImage("tyro.jpg");
//  img2 = loadImage("scene.jpg");
//  img3 = loadImage("brp.jpg");
//  img4 = loadImage("images.jpeg");
//  img5 = loadImage("toy.jpg");
  img6 = loadImage("heatmapBrush.png");
  img7 = loadImage("heatmapColors.png");
  
     // create empty canvases:
  gradientMap = createImage(displayWidth, displayHeight, ARGB);
  heatmap = createImage(displayWidth, displayHeight, ARGB);
  // load pixel arrays for all relevant images
  gradientMap.loadPixels();
  for (int i=0; i<gradientMap.pixels.length; i++) {
    gradientMap.pixels[i] = 0;
  }
  heatmap.loadPixels();
  img6.loadPixels();
  img7.loadPixels();
  
  noCursor();
 smooth();
 point = new PVector();
 eyeTribe = new EyeTribe(this);
 
 // Create a new file in the sketch directory 
 recordData = createWriter("part24.tsv");
 recordData.println("X Coordinate" + "\t" + "Y Coordinate" + "\t" + "Time Spent" + "\t" + "Image Viewed");
 
 
}

void draw(){
  
  background(0);
  
   // Calculate how much time has passed
  int passedTime = millis() - savedTime;
  
  if (passedTime > 3000) { // Has two seconds passed? show first image
    image(img1, 0, 0, width, height);
     picnum=1;
  }
 if (passedTime > (5000)) { //add in black screen
   fill(0);
   rect(0,0,width,height);
   picnum=0;
 }
  if (passedTime > (5500)) { //show second image
    image(img2, 0, 0, width, height);
    picnum=2;
  }
   if (passedTime > (7500)) { //add in black screen
   fill(0);
   rect(0,0,width,height);
   picnum=0;
 }
  if (passedTime > (8000)) { //show third image
    image(img3, 0, 0, width, height);
    picnum=3;
  }
   if (passedTime > (10000)) { //add in black screen
   fill(0);
   rect(0,0,width,height);
   picnum=0;
 }
  if (passedTime > (10500)) { // show fourth image
    image(img4, 0, 0, width, height);
    picnum=4;
  }
   if (passedTime > (12500)) { //add in black screen
   fill(0);
   rect(0,0,width,height);
   picnum=0;
 }
  if (passedTime > (13000)) { //show fifth image
    image(img5, 0, 0, width, height);
    picnum=5;
  }
 if (passedTime > (15000)) { //add in black screen
 picnum=0;
   fill(0);
   rect(0,0,width,height);
   recordData.flush();  // Writes the remaining data to the file
   recordData.close();  // Finishes the file
   //exit();  // Stops the program
 }
 if (passedTime >16000){

   savedDiff = millis();
   float timepassed = millis() - savedDiff;
    fill(255);
   rect(0,0,width,height);
   //show the image 
   picdig=1;
   scatterPlot(img1, timepassed);
   linedscatterPlot(img1);
   heatmap(img1);
   transparency(img1);
   
 }

 if (passedTime >19000){

   savedDiff = millis();
   float timepassed = millis() - savedDiff;
    fill(255);
   rect(0,0,width,height);
   //show the image 
   picdig=2;
   scatterPlot(img2,timepassed);
   linedscatterPlot(img2);
   heatmap(img2);
   transparency(img2);
 }
 
  if (passedTime >22000){

    savedDiff = millis();
    float timepassed = millis() - savedDiff;
     fill(255);
   rect(0,0,width,height);
   //show the image 
   picdig=3;
   scatterPlot(img3, timepassed);
   linedscatterPlot(img3);
   heatmap(img3);
   transparency(img3);
 }
 
  if (passedTime >25000){

    savedDiff = millis();
    float timepassed = millis() - savedDiff;
     fill(255);
   rect(0,0,width,height);
   //show the image 
   picdig=4;
   scatterPlot(img4,timepassed);
   linedscatterPlot(img4);
   heatmap(img4);
   transparency(img4);
 }
 
  if (passedTime >28000){

    savedDiff = millis();
    float timepassed = millis() - savedDiff;
     fill(255);
   rect(0,0,width,height);
   //show the image 
   picdig=5;
   scatterPlot(img5, timepassed);
   linedscatterPlot(img5);
   heatmap(img5);
   transparency(img5);
 }
 
 if (passedTime>31000){
   fill(0);
   rect(0,0,width,height);
 }
   
   timediff= millis()-savedDiff;
   // Datapoint data = new Datapoint(point.x,point.y,timediff, picnum);
   if (picnum!=0){
    recordData.println(point.x + "\t" + point.y + "\t" + timediff + "\t" + picnum);
     dataCollected.add(new Datapoint(point.x, point.y, timediff, picnum));
    savedDiff=millis();
    println(point.x);
    
  }
}


void onGazeUpdate(PVector gaze, PVector leftEye_, PVector rightEye_, GazeData data) {
//println(eyeTribe.isTracking() + " " + eyeTribe.isTrackingGaze() + " " + eyeTribe.isTrackingEyes() + " " + data.stateToString());
  if ( gaze != null ) {
    point = gaze;
//    tracking.add(point.get());
//    if (tracking.size() > 500 ) {
//      tracking.remove(0);
//    }
//    //println(point);
  }
//  leftEye = leftEye_;
//  rightEye = rightEye_;
}

void trackerStateChanged(String state) {
  println("Tracker state: " + state);
}

void keyPressed() {
  if (key == ' ') {
    savedTime = millis();
    savedDiff=millis();
    number = number +1;
    recordData = createWriter("part"+number+".tsv");
}
  if (key == 's'){
    recordData.flush();  // Writes the remaining data to the file
    recordData.close();  // Finishes the file
    exit();  // Stops the program
  }
}


