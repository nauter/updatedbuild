import penner.easing.*;
import com.bigbrowncupboard.util.*;
import com.bigbrowncupboard.app.*;
import com.bigbrowncupboard.animate.*;
import com.bigbrowncupboard.ui.*;
import java.awt.Rectangle;
import java.util.Map;
import controlP5.*;
import cvc.CVClient;
import cvc.events.TrackingEvent;
import cvc.blobs.TrackingBlob;
import processing.video.*;
import java.text.DecimalFormat;
import beads.*;

AudioContext ac;

ArrayList<RectangleF> screenRects;
ArrayList<Rectangle> screenRects_;
// Size of each cell in the grid, ratio of window size to video size
float videoScale_h = 426;
float videoScale_v = 360;
// Number of columns and rows in our system
float cols, rows;

CVClient cvc;
PVector c_pos = new PVector();
PVector prev_avg_pos = new PVector();
boolean CVC_DEBUG_RENDER = true;
boolean DEBUG_PLAYHEAD = true;

boolean region1 = false;
boolean region2 = false;
boolean region3 = false;
boolean region4 = false;
boolean region5 = false;
boolean region6 = false;
boolean isObjectInRegion1;
boolean isObjectInRegion2;
boolean isObjectInRegion3;
boolean isObjectInRegion4;
boolean isObjectInRegion5;
boolean isObjectInRegion6;

void setup() {
  size(1280, 720);

    ac = new AudioContext();
    
    
    //will implement later
    
    //WavePlayer wp = new WavePlayer(ac, 100, Buffer.SINE);
    //Gain g = new Gain(ac, 1,0.0);
    //g.addInput(wp);
    //ac.out.addInput(g);
    
    
    ac.start();
  // Initialize columns and rows
  cols = width/videoScale_h;
  rows = height/videoScale_v;
  
  screenRects = new ArrayList<RectangleF>();
  screenRects_ = new ArrayList<Rectangle>();
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      float x = i*videoScale_h;
      float y = j*videoScale_v;
      fill(255);
      stroke(0);
      //rect(x, y, videoScale_h, videoScale_v);
      screenRects.add(new RectangleF(x, y, videoScale_h, videoScale_v));
      screenRects_.add(new Rectangle((int)x, (int)y, (int)videoScale_h, (int)videoScale_v));
    }
  }
  
  
  cvc = new CVClient(this);
  cvc.setMinimalLogging(); // Dont show so much in the console  
  cvc.init(); // initialise CVC 
  cvc.registerEvents(this); // register for the blob tracking events, your code must have methods updateTrackingBlobs & removeTrackingBlobs   
    // Setup VideoTracker server connection and connect
  cvc.setTrackingServer("149.171.248.244", 11001); // ip, port
  cvc.showControlPanel(10, height-165);
  
}
void draw() {
  //background(0); 
  // FPS display  
  //text(frameRate, 2,10);
 
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      float x = i*videoScale_h;
      float y = j*videoScale_v;
      fill(255);
      stroke(0);
      rect(x, y, videoScale_h, videoScale_v);
      //screenRects.add(new RectangleF(x, y, videoScale_h, videoScale_v));
      //println(x, y, videoScale_h, videoScale_v);
    }
  }
  
  cvc.update();
    
  if(CVC_DEBUG_RENDER) { 
    cvc.render(0,0);
    cvc.drawImage(5, 5, 160, 120); // debug show copy of the image
  }
  String txt_fps = String.format(getClass().getName() + ", fps: "+ frameRate);
  surface.setTitle(txt_fps);
}
  
  void removeTrackingBlobs( TrackingEvent event ) {
  // event.removed_blob_ids ArrayList of ints of the ids of blobs removed.
  // You can use this to remove your own blobs if you have created some

}

  void updateTrackingBlobs(TrackingEvent event) {
  
  pushStyle();

 // Loop through all the Tracking blobs found in event.update_blobs


  for(Map.Entry<Integer,TrackingBlob> entry : event.updated_blobs.entrySet()) {  // This is how we loop thru a ConcurrentHashMap (which CVC uses to be thread safe)    
      TrackingBlob blob = entry.getValue(); // See notes below on methods to access TrackingBlob   
      
  isObjectInRegion1=blob.getRect().intersects(screenRects.get(0));
  isObjectInRegion2=blob.getRect().intersects(screenRects.get(1));
  isObjectInRegion3=blob.getRect().intersects(screenRects.get(2));
  isObjectInRegion4=blob.getRect().intersects(screenRects.get(3));
  isObjectInRegion5=blob.getRect().intersects(screenRects.get(4));
  isObjectInRegion6=blob.getRect().intersects(screenRects.get(5));
       
      if (isObjectInRegion1 && !region1){
         println("region1");
           String filename = dataPath("fireball.wav");
               SamplePlayer sp = new SamplePlayer(ac, SampleManager.sample(filename));
               ac.out.addInput(sp);
         region1 = true;
       }
       
       else if (!isObjectInRegion1 && region1 == true){
           region1 = false;
       }
       
      if (isObjectInRegion2 && !region2){
         println("region2");
           String filename = dataPath("fireball.wav");
               SamplePlayer sp = new SamplePlayer(ac, SampleManager.sample(filename));
               ac.out.addInput(sp);
         region2 = true;
       }
       
       else if (!isObjectInRegion2 && region2 == true){
           region2 = false;
       }
       
      if (isObjectInRegion3 && !region3){
         println("region3");
           String filename = dataPath("fireball.wav");
               SamplePlayer sp = new SamplePlayer(ac, SampleManager.sample(filename));
               ac.out.addInput(sp);
         region3 = true;
       }
       
       else if (!isObjectInRegion3 && region3 == true){
           region3 = false;
       }  
       
      if (isObjectInRegion4 && !region4){
         println("region4");
           String filename = dataPath("fireball.wav");
               SamplePlayer sp = new SamplePlayer(ac, SampleManager.sample(filename));
               ac.out.addInput(sp);
         region4 = true;
       }
       
       else if (!isObjectInRegion4 && region4 == true){
           region4 = false;
       }       
       
      if (isObjectInRegion5 && !region5){
         println("region5");
           String filename = dataPath("fireball.wav");
               SamplePlayer sp = new SamplePlayer(ac, SampleManager.sample(filename));
               ac.out.addInput(sp);
         region5 = true;
       }
       
       else if (!isObjectInRegion5 && region5 == true){
           region5 = false;
       }      
       
      if (isObjectInRegion6 && !region6){
         println("region6");
           String filename = dataPath("fireball.wav");
               SamplePlayer sp = new SamplePlayer(ac, SampleManager.sample(filename));
               ac.out.addInput(sp);         
         region6 = true;
       }
       
       else if (!isObjectInRegion6 && region6 == true){
           region6 = false;
       }
       
    }
  
  popStyle(); 
} 
 
void keyPressed() {
  
  // Toggle the CVC debug rendering
  if(key == 'D' || key == 'd') CVC_DEBUG_RENDER = !CVC_DEBUG_RENDER; 
  if(key == 'F' || key == 'f') DEBUG_PLAYHEAD = !DEBUG_PLAYHEAD; 
  if(key == 'C' || key == 'c') cvc.toggleControlPanel();
  
}




/*

  Useful public methods of the cvc.blobs.TrackingBlob class
  
  RectangleF getRect() // bounding box of blob
  float getArea() // of rect
  
  PVector getPos() // location of centroid
  PVector getDecPos() // a normalised position vector 0..1  
  
  int getID()
  
  boolean hasOutlines()
  float[] getOutlines() // array of [x,y,x,y,x,y...] coordinates  
  int getOutlinesCount()  
  
  long getAge(){ // how old in milliseconds this blob is  
  long getStagnation(){ // how long it has been still
  
  float getXSpeed() // X velocity
  float getYSpeed() // the Y velocity
  float getMotionSpeed()
  float getMotionAccel()
   
  boolean isMoving()
    
  int getState() // possible values: TracingBlob.ADDED, TracingBlob.ACCELERATING, TracingBlob.DECELERATING, TracingBlob.STOPPED, TracingBlob.REMOVED

  String getStateString() // small readable version of the state: 
  
  1175~
  
*/
