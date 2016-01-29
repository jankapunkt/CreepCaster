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

boolean debQuad = false;
boolean isRunning=false;