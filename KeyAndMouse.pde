
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

//runs if mouse was clicked
void mouseClicked()
{
  spawn();
}

//spawns a new circle
void spawn()
{
 MovableCircle m = new MovableCircle(1);
 m.setPos(0, random(0,SCREEN_HEIGHT), 0);
 manager.add(m);
}