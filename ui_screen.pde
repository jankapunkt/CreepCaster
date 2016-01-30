

public boolean displayUI = false;
public boolean displayPauseUI = false;
public boolean displtartScreen = false;
public boolean displayEndScreen = false;


public PImage AVATAR_LEFT;
public PImage AVATAR_RIGHT;

PImage red;
PImage blue;


public PImage attackerCreepImage;
public PImage defenderCreepImage;

public CastMatrix castMatrix;

//init iu stuff here
public void loadUI()
{
  castMatrix = new CastMatrix(SCREEN_WIDTH/2 -90 ,SCREEN_HEIGHT - 250, 40,50);
  AVATAR_LEFT  = loadImage("shaman.png");
  AVATAR_RIGHT = loadImage("meh.png");
  attackerCreepImage = loadImage("creeps/attacker/keulen_creep_1.png");
}

//do all the main rendering here
public void displayUI()
{
    noStroke();
    fill(0,0,0,120);
    rect(0,450,1200,150);
    castMatrix.update();
    
    tint(255, 200);
    image(AVATAR_LEFT, 10,SCREEN_HEIGHT-140, 128,128);
    image(AVATAR_RIGHT, SCREEN_WIDTH-138,SCREEN_HEIGHT-140, 128,128);
    tint(255, 255);
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