
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
void mouseClicked(){}

//spawns a new circle
void spawn(int type, int creepType)
{
 
 Creep m;
 if(creepType==1)
 {
   m = new AttackerCreep(1);
   m.setImage(attackerCreepImage);
 }
 else if(creepType==2)
 {
   m = new DefenderCreep(1);
    m.setImage(red);
 }
 else if(creepType==3)
 {
   m = new HealerCreep(1);
    m.setImage(red);
 }
 else
 {
  m = new Creep(1);
  m.setImage(attackerCreepImage);
 }


 if(type==1)
 {
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