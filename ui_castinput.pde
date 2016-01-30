//------------------------------------------------------------------------------
// this is where the casting input class is implemented
// this class will be used to draw your casting pattern
// which elads to spawn a new creep
//------------------------------------------------------------------------------

class CastMatrix
{
  public int posx, posy;
  public CastRect[] casts;
  public int[] counters;
  private int buffer = -1;


  public CastMatrix(int posx, int posy, int space, int size)
  {
    casts = new CastRect[6];
    for (int i=0; i<3; i++)
      casts[i] = new CastRect(posx + (i*2*space), posy, size);

    for (int i=3; i<6; i++)
      casts[i] = new CastRect(posx + ((i-3)*2*space), posy+ 2*space, size);

    this.posx = posx;
    this.posy = posy;
    
    counters = new int[6];
    counters[0] = -1;
    counters[1] = 50;
    counters[2] = 30;
    counters[3] = 20;
    counters[4] = 10;
    counters[5] = 5;
    
  }

  public void update()
  {
    for (int i=0; i<casts.length; i++)
    { 
      casts[i].display(i, counters[i]);
    }
  }

  public void hit()
  {
    for (int i=0; i<casts.length; i++)
    {
      if (casts[i].hit() && counters[i]!=0)
      {
          spawn(1, i);
          counters[i]--;
      }
    }
  }
}

class CastRect
{
  public boolean hit, locked;
  public int posx, posy, w, h;


  public CastRect(int posx, int posy, int size)
  {
    this.posx = posx;
    this.posy = posy;
    this.w = this.h = size;
  }

  public boolean hit()
  {
    this.hit = dotInSquare(mouseX, mouseY, posx, posy, w, h);
    return hit;
  }

  public void display(int index, int counter)
  {
    pushMatrix();
    translate(posx, posy);
    if (dotInSquare(mouseX, mouseY, posx, posy, w, h))
      tint(255, 255);
    else
      tint(255, 160);
    
    switch (index)
    {
       case 0:
         image(basicCreepImage, 0,0, 32, 32);
       break;
       case 1:
         image(attackerCreepImage, 0,0, 32, 32);
       break;
       case 2:
         image(defenderCreepImage, 0,0, 32, 32);
       break;
       case 3:
         image(healerCreepImage, 0,0, 32, 32);
       break;
       case 4:
         image(golemCreepImage, 0,0, 32, 32);
       break;
       case 5:
         image(sprinterCreepImage, 0,0, 32, 32);
       break;
    }
      fill(255);
      stroke(255);
      textSize(18);
      if(counter>-1)
        text(Integer.toString(counter),36,14);
      else
        text("*",36,14);
    popMatrix();
  }
}


//spawns a new circle
void spawn(int type, int creepType)
{

  Creep m;
  if (creepType==0)
  {
    m = new Creep(type);
    m.setImage(basicCreepImage);
  }else if (creepType==1){
    m = new AttackerCreep(type);
    m.setImage(attackerCreepImage);
  } else if (creepType==2){
    m = new DefenderCreep(type);
    m.setImage(defenderCreepImage);
  } else if (creepType==3){
    m = new HealerCreep(type);
    m.setImage(healerCreepImage);
  } else if(creepType==4){
    m = new GolemCreep(type);
    m.setImage(golemCreepImage);
  } else if (creepType == 5){
    m = new SprinterCreep(type);
    m.setImage(sprinterCreepImage);
  } else {
    m = new Creep(type);
    m.setImage(basicCreepImage);
  }
  
  if (type==1)
  {
    spawnFx.trigger();
    m.setPos(0, random(0, SCREEN_HEIGHT), 0);
  }
  if (type==2)
  {
    m.setPos(SCREEN_WIDTH, random(0, SCREEN_HEIGHT), 0);
  }
  m.index = type;
  manager.add(m);
}


//========================================================================================
//
//    RITUAL CASTING CHECKER
//
//========================================================================================
import java.util.Arrays;


static class CastingChecker
{
  protected static int[] seq_healer   = {0, 1, 2, 3, 5, 6, 7, 8};
  protected static int[] seq_defender = {0, 4, 8, 6, 2};
  protected static int[] seq_attacker = {0, 1, 2, 4, 6, 7, 8};

  public static final int HEALER   = 0;
  public static final int DEFENDER = 1;
  public static final int ATTACKER = 2;


  public static int checkSequence(ArrayList<Integer> input)
  {
    int sum =0;
    for (int i : input)
      sum+=i;
    if (sum==3)return 0;
    if (sum>= 3 && sum <= 10) return 1;
    if (sum>10)return 2;
    return -1;
  }
}