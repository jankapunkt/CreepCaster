
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
        spawn(2);
        break;
   }
}


protected boolean mouseClicked = false;

//runs if mouse was clicked
void mouseClicked()
{
}

//spawns a new circle
void spawn(int type)
{
 
 Creep m = new Creep(1);

 if(type==1)
 {
    m.setImage(red);
   spawnFx.trigger();
   m.setPos(0, random(0,SCREEN_HEIGHT), 0);
 }
 if(type==2)
 {
    m.setImage(blue);
   m.setPos(SCREEN_WIDTH, random(0,SCREEN_HEIGHT), 0);
 }
 m.index = type;
 manager.add(m);
}