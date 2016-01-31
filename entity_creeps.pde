//------------------------------------------------------------------------------
// here we will do all our creep implementations
//------------------------------------------------------------------------------


//creep       0
//attacker    1
//defender    2
//healer      3
//golem       4
//sprinter    5

/** this will  be extended by all creep character classes **/
public class Creep extends MovableCircle
{
  protected PImage _creepIm;
  protected int deadCount=0;
  //constructor
  public Creep(int id)
  {
    super(id);
  } // empty

  public void setImage(PImage bufferedImage)
  {
    _creepIm = bufferedImage;
  }

  @Override
    public void display() //display image instead of circle
  {
    pushMatrix();
    if (index==1)
      stroke(255);
    else
      stroke(100, 220, 0);

    translate(pos.x, pos.y);
    if (index==2)
      scale(-1, 1);
    fill(mouseOver ? 20 : fill);
    ellipse(0, 16, size, size/2);
    if (!isDead)
      image(_creepIm, -16, -16);
    else
    {
      tint(255, 50);
      image(_creepIm, -16-deadCount/2, -16-deadCount/2, 32+deadCount, 32+deadCount);
      tint(255, 255);
      deadCount+=4;
    }
    popMatrix();
    if (deadCount>100)
    {
      removable=true;
    }
  }

  @Override
    public void hit(Movable target) {
    if (target == null) return;

    if (target.index != this.index)
      target.hp-=atk;
    if (hp <= 0) {
      this.isDead = true;
      deadFx.trigger();
    }
  }
}



public class AttackerCreep extends Creep
{
  public AttackerCreep(int id)
  {
    super(id); 
    atk = 50;
    hp  = 20;
  }
}

public class DefenderCreep extends Creep
{
  public DefenderCreep(int id)
  {
    super(id);
    hp = 250;
    atk = 5;
  }
}

public class HealerCreep extends Creep
{
  public HealerCreep(int id)
  {
    super(id); 
    hp = 50;
    atk =30;
  }

  @Override
    public void hit(Movable target) {
    if (target == null) return;

    if (target.index == this.index)
      target.hp+=atk;
    if (hp <= 0) {
      this.isDead = true;
      deadFx.trigger();
    }
  }
}

public class GolemCreep extends Creep
{
  public GolemCreep(int id)
  {
    super(id); 
    setSize(64);
    hp = 300;
    atk= 100;
    speed = 0.6;
  }
}


public class SprinterCreep extends Creep
{
  public SprinterCreep(int id)
  {
    super(id); 
    hp=10;
    atk=0;
    speed = 4;
  }
}