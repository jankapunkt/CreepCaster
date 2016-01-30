
boolean debQuad   = false;
boolean isRunning = true;

//runs if a key was pressed
void keyPressed()
{
  switch(key)
  {
  case 'd':
    debQuad = !debQuad;
    manager.debugQuad(debQuad);
    break;
  case 'p':
    if (isRunning)noLoop();
    if (!isRunning)loop();
    isRunning = !isRunning;
    break;
  case ENTER:
    break;
  }
}


protected boolean mouseClicked = false;


void mouseClicked()
{
   castMatrix.hit(); 
}