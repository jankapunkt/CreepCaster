

private ObjManager manager;

private PFont baseFont;

     
void setup()
{
  size(1000,600,P2D);
  //frameRate(60);
  manager = new ObjManager();
  for (int i=0;i<1;i++)
  {
     MovableCircle c = new MovableCircle(i);
     c.setPos(random(100,900),random(100,500),0);
     manager.add(c);
  }
  MovableLine l = new MovableLine();
    l.setPos(20,20,0);
    l.setWidth(0);
    l.setHeight(560);
  manager.add(l);
  MovableLine r = new MovableLine();
    r.setPos(960,20,0);
    r.setWidth(0);
    r.setHeight(560);
  manager.add(r);
  MovableLine t = new MovableLine();
    t.setPos(20,20,0);
    t.setWidth(960);
    t.setHeight(0);
  manager.add(t);
  MovableLine b = new MovableLine();
    b.setPos(0,560,0);
    b.setWidth(1000);
    b.setHeight(0);
  manager.add(b);
  
  
  baseFont = loadFont("CourierNewPSMT-48.vlw");
  textFont(baseFont);
  

}

long lastLoopTime = System.nanoTime();
long lastFpsTime=0;
int fps = 0;
final int TARGET_FPS = 60;
final long OPTIMAL_TIME = 1000000000 / TARGET_FPS;  

void draw()
{
  if(!isRunning)return;
  
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
  updates(delta);
  render();
  mouseClicked=false;
  debug();
  try{Thread.sleep( (lastLoopTime-System.nanoTime() + OPTIMAL_TIME)/1000000 );}catch(Exception e){}
}

private void updates(double delta)
{
   manager.update(delta); 
}

private void render()
{
  background(180);
  
  manager.display();
}


void debug()
{
  pushMatrix();
    noStroke();
    fill(60,60,60,160);
    rect(0,0,1000,30);
    fill(255);
    stroke(255);
    textSize(12);
    text("FR "+ Float.toString(frameRate),20,20);
    text("C " + Integer.toString(manager.collitions),120,20);
    text("mx " + Float.toString(mouseX),180,20);
    text("my " + Float.toString(mouseY),240,20);
  popMatrix();
}