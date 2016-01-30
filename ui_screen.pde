

public boolean displayUI = false;
public boolean displayPauseUI = false;
public boolean displayStartScreen = false;
public boolean displayEndScreen = false;

//init iu stuff here
public void loadUI()
{
  
}

//do all the main rendering here
public void displayUI()
{
    noStroke();
    fill(0,0,0,120);
    rect(0,450,1200,150);
    
    
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