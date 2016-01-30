//------------------------------------------------------------------------------
// here we will do all our creep implementations
//------------------------------------------------------------------------------

/** this will  be extended by all creep character classes **/
public class Creep extends MovableCircle
{
   //variables, health, isdead and so on
  
   //constructor
   public Creep(int id)
   {
     super(id);
   } // empty
   
}


public class AttackerCreep extends Creep
{
    public AttackerCreep(int id)
    {
       super(id); 
    }
}

public class DefenderCreep extends Creep
{
    public DefenderCreep(int id)
    {
       super(id); 
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