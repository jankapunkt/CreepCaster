//---------------------------------------------------------//
// MAIN DECLARATIONS, SETUP AND DRAW
//---------------------------------------------------------//

//---------------------  UI VARS -------------------------//
public final int SCREEN_WIDTH  = 1200;
public final int SCREEN_HEIGHT = 600;

public PFont baseFont;

//---------------------  LOGIC -------------------------//
public ObjManager manager;
public final PVector mousePos = new PVector(SCREEN_WIDTH , SCREEN_HEIGHT/2);

//---------------------  FPS AND DELTA -------------------------//
public long lastLoopTime = System.nanoTime();
public long lastFpsTime=0;
public int fps = 0;
public final int TARGET_FPS = 60;
public final long OPTIMAL_TIME = 1000000000 / TARGET_FPS;  



//---------------------  SETUP -------------------------//
void setup()
{
  size(1200,600,P2D);
  //frameRate(60);
  manager = new ObjManager();

  baseFont = loadFont("CourierNewPSMT-48.vlw");
  textFont(baseFont);
  

}


//---------------------  RENDERING -------------------------//
void draw()
{
  if(!isRunning)return;
  double delta = getDelta();
  manager.update(delta); 
  render();
  debug();
  try{Thread.sleep( (lastLoopTime-System.nanoTime() + OPTIMAL_TIME)/1000000 );}catch(Exception e){} //update 
}


//render all global manager entities
private void render()
{
  background(180);
  manager.display();
}


/** gets the delta value for this fps rate **/
private double getDelta()
{
  
  // work out how long its been since the last update, this
  // will be used to calculate how far the entities should
  // move this loop
  long now = System.nanoTime();
  long updateLength = now - lastLoopTime;
  lastLoopTime = now;
  double delta = updateLength / (OPTIMAL_TIME);

  // update the frame counter
  lastFpsTime += updateLength;
  fps++;
  
  // update our FPS counter if a second has passed since
  // we last recorded
  if (lastFpsTime >= 1000000000)
  {
     //System.out.println("(FPS: "+fps+")");
     lastFpsTime = 0;
     fps = 0;
  }
  return delta;
}