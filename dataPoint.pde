class Datapoint { 
  float xpos, ypos, time, picture; 
  Datapoint (float x, float y, float t, float p) {  
    xpos = x;
    ypos = y; 
    time = t; 
    picture = p;
  } 
  void update() { 
    //recordData out of information
    recordData.println(xpos + "\t" + ypos + "\t" + time + "\t" + picture);

//    ypos += speed; 
//    if (ypos > height) { 
//      ypos = 0; 
//    } 
//    line(0, ypos, width, ypos); 
//  } 
}
}
