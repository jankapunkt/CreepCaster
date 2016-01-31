

public boolean displayUI = false;
public boolean displayPauseUI = false;
public boolean displtartScreen = false;
public boolean displayEndScreen = false;


public PImage AVATAR_LEFT;
public PImage AVATAR_RIGHT;

public float levelTime = 0;

public PImage basicCreepImage;
public PImage attackerCreepImage;
public PImage defenderCreepImage;
public PImage golemCreepImage;
public PImage healerCreepImage;
public PImage sprinterCreepImage;


public CastMatrix castMatrix;

//init iu stuff here
public void loadUI()
{
  castMatrix = new CastMatrix(SCREEN_WIDTH/2 -90 ,SCREEN_HEIGHT - 130, 40,50);
  AVATAR_LEFT  = loadImage("shaman.png");
  AVATAR_RIGHT = loadImage("meh.png");
  
  basicCreepImage    = loadImage("creeps/creepDummy.png");
  attackerCreepImage = loadImage("creeps/attacker/keulen_creep_1.png");
  defenderCreepImage = loadImage("creeps/Blue.png");
  healerCreepImage   = loadImage("creeps/Red.png");
  golemCreepImage    = loadImage("creeps/golem.png");
  sprinterCreepImage = loadImage("creeps/healer/heiler_creep_grün_01.png");
}


//do all the main rendering here
public void displayUI()
{
    //casting matrix
    noStroke();
    fill(0,0,0,120);
    rect(0,450,1200,150);
    castMatrix.update();
    
    levelTime = System.nanoTime() / 10000;
    stroke(255);
    textSize(12);
    text("t="+Float.toString(levelTime),200,SCREEN_WIDTH-100);
    
    //avatars
    tint(255, 200);
    image(AVATAR_LEFT, 10,SCREEN_HEIGHT-140, 128,128);
    image(AVATAR_RIGHT, SCREEN_WIDTH-138,SCREEN_HEIGHT-140, 128,128);
    tint(255, 255);
    pushMatrix();
    stroke(255);
    fill(255);
    textSize(60);
    text("you "+ Integer.toString(player_points),200,SCREEN_HEIGHT-100);
    text("meh "+ Integer.toString(ai_points),SCREEN_WIDTH-400,SCREEN_HEIGHT-100);
    popMatrix();
}


public void renderGoals()
{
    noStroke();
   pushMatrix();
     translate(leftGoal.x, leftGoal.y);
     fill(255,255,255,160);
     ellipse(0,0,80,60);
   popMatrix();
   pushMatrix();
     translate(rightGoal.x, rightGoal.y);
     fill(100,200,0,160);
     ellipse(0,0,80,60);
   popMatrix();
}


//this displays the pause UI
//e.g. a settings menu
public void displayPauseUI()
{
  
}


public void displayStartScreen()
{
  
}

public void displayEndScreen()
{
  
  
}


//draws debug information on screen
void debug(double delta)
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
    text("dt " + Double.toString(delta),320,20);
  popMatrix();
}