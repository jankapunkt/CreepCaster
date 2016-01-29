
boolean debQuad   = false;
boolean isRunning = true;

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
  spawn();
}

void spawn()
{
 MovableCircle m = new MovableCircle(1);
 m.setPos(mouseX, mouseY, 0);
 manager.add(m);
}