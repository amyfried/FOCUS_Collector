
void scatterPlot(PImage pic, float time){
  tint(255, 126);
  image(pic, 0, 0, width/2, height/2);
  noTint();
   //only shows 1 participant, how to show it for all the participants
  for (int i = 0; i < dataCollected.size(); i++) {
  Datapoint curr = dataCollected.get(i);
   if(i > 0){      //if the current index is greather than 0
   if (curr.picture == picdig){
    
     fill(#D42DDE);
     //if (curr.time < time){
     float x = map(curr.xpos, 0, width, 0, width/2);
     float y = map(curr.ypos, 0, height, 0, height/2);
             ellipse(x,y,20,20); 
        //     savedDiff = millis();
      //    }  
   }
        }      
    }
}

void linedscatterPlot(PImage pic){
  tint(255, 126);
  image(pic, 0, height/2, width/2, height/2);
  noTint();
  for (int i = 0; i < dataCollected.size(); i++) {
  Datapoint curr = dataCollected.get(i);
   if(i > 0){      //if the current index is greather than 0
     Datapoint prev = dataCollected.get(i-1);           //we can access the previous
   if (curr.picture == picdig){
    float x = map(curr.xpos, 0, width, 0, width/2);
    float px = map(prev.xpos, 0, width, 0, width/2);
    float y = map(curr.ypos, 0, height, height/2, height);
    float py = map(prev.ypos, 0, height, height/2, height);
      //if(dist(curr.xpos,curr.ypos,prev.xpos,prev.ypos) < 20) {//check the distance, if it's within a certain threshold     
        stroke(0,0,255);
        strokeWeight(1);
        line(x,y,px,py);
        stroke(0);
        fill(#CE8F0F);
        ellipse(x,y,10,10);
                //draw the line
        }
      }
    }
}

void heatmap(PImage pic){
  // draw the background image in the upper right corner and transparently blend the heatmap on top of it
for (Datapoint data : dataCollected){
  if (data.picture == picdig){
 // render the heatmapBrush into the gradientMap:
    drawToGradient(int(data.xpos), int( data.ypos));
    // update the heatmap from the updated gradientMap:
    updateHeatmap(); 
    //tint(255,255,255,192);
    image(pic, width/2,height/2,width/2,height/2);
    tint(255,255,255,150);
    image(heatmap, width/2,height/2,width/2,height/2);
    noTint();   
  }
}
}

void drawToGradient(int x, int y)
{//Rendering code that blits the heatmapBrush onto the gradientMap, centered at the specified pixel and drawn with additive blending
  // find the top left corner coordinates on the target image
  int startX = x-img6.width/2;
  int startY = y-img6.height/2;

  for (int py = 0; py < img6.height; py++)
  {
    for (int px = 0; px < img6.width; px++) 
    {
      // for every pixel in the heatmapBrush:
      // find the corresponding coordinates on the gradient map:
      int hmX = startX+px;
      int hmY = startY+py;
      /*
      The next if-clause checks if we're out of bounds and skips to the next pixel if so. 
      Note that you'd typically optimize by performing clipping outside of the for loops!
      */
      if (hmX < 0 || hmY < 0 || hmX >= gradientMap.width || hmY >= gradientMap.height)
      { continue;}
      
      // get the color of the heatmapBrush image at the current pixel.
      int col = img6.pixels[py*img6.width+px]; // The py*heatmapBrush.width+px part would normally also be optimized by just incrementing the index.
      col = col & 0xff; // This eliminates any part of the heatmapBrush outside of the blue color channel (0xff is the same as 0x0000ff)
      
      // find the corresponding pixel image on the gradient map:
      int gmIndex = hmY*gradientMap.width+hmX;
      
      if (gradientMap.pixels[gmIndex] < 0xffffff-col) // sanity check to make sure the gradient map isn't "saturated" at this pixel. This would take some 65535 clicks on the same pixel to happen. :)
      {
        gradientMap.pixels[gmIndex] += col; // additive blending in our 24-bit world: just add one value to the other.
        if (gradientMap.pixels[gmIndex] > maxValue) // We're keeping track of the maximum pixel value on the gradient map, so that the heatmap image can display relative click densities (scroll down to updateHeatmap() for more)
        {
          maxValue = gradientMap.pixels[gmIndex];
        }
      }
    }
  }
  gradientMap.updatePixels();
}

void updateHeatmap()
{ //Updates the heatmap from the gradient map.
  // for all pixels in the gradient:
  for (int i=0; i<gradientMap.pixels.length; i++)
  {
    // get the pixel's value. Note that we're not extracting any channels, we're just treating the pixel value as one big integer.
    // cast to float is done to avoid integer division when dividing by the maximum value.
    float gmValue = gradientMap.pixels[i];
    
    // color map the value. gmValue/maxValue normalizes the pixel from 0...1, the rest is just mapping to an index in the heatmapColors data.
    int colIndex = (int) ((gmValue/maxValue)*(img7.pixels.length-1));
    int col = img7.pixels[colIndex];

    // update the heatmap at the corresponding position
    heatmap.pixels[i] = col;
  }
  // load the updated pixel data into the PImage.
  heatmap.updatePixels();
}

void transparency(PImage pic){
  
}
