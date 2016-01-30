//------------------------------------------------------------------------------
// here we will do all our creep implementations
//------------------------------------------------------------------------------





/** this will  be extended by all creep character classes **/
public class Creep extends MovableCircle
{
   protected PImage _creepIm;

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
        translate(pos.x, pos.y);
        image(_creepIm, 0,0);
      popMatrix();
   }
   
   @Override
   public void hit(Movable target){
     if (target == null) return;
   
     if (target.index != this.index)
         target.hp-=atk;
     if (hp <= 0){
         this.isDead = true;
     }
   }
}



public class AttackerCreep extends Creep
{
    public AttackerCreep(int id)
    {
       super(id); 
       atk = 100;
    }
}

public class DefenderCreep extends Creep
{
    public DefenderCreep(int id)
    {
       super(id);
       hp = 250;
       atk = 8; 
    }
}

public class HealerCreep extends Creep
{
    public HealerCreep(int id)
    {
       super(id); 
    }
}

public class GolemCreep extends Creep
{
    public GolemCreep(int id)
    {
       super(id); 
    }
}