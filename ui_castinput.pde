//------------------------------------------------------------------------------
// this is where the casting input class is implemented
// this class will be used to draw your casting pattern
// which elads to spawn a new creep
//------------------------------------------------------------------------------

class CastMatrix
{
  
}

class CastRect
{
   public boolean hit;
   public int posx, posy, w, h;
   
   public CastRect(){}
   
   public boolean hit()
   {
       this.hit = dotInSquare(mouseX, mouseY, posx, posy, w, h);
       return hit;
   }
   
   public void display()
   {
      pushMatrix();
        translate(posx, posy);
        fill(255);
        rect(0,0,w,h);
      popMatrix();
   }
}



//========================================================================================
//
//    RITUAL CASTING CHECKER
//
//========================================================================================
import java.util.Arrays;


static class CastingChecker
{
   protected static int[] seq_healer   = {0,1,2,3,5,6,7,8};
   protected static int[] seq_defender = {0,4,8,6,2};
   protected static int[] seq_attacker = {0,1,2,4,6,7,8};

   public static final int HEALER   = 0;
   public static final int DEFENDER = 1;
   public static final int ATTACKER = 2;

   
   public static int checkSequence(int[] input)
   {
      if (Arrays.equals(input, seq_healer))
        return 0;
      if (Arrays.equals(input, seq_defender))
        return 1;
      if (Arrays.equals(input, seq_attacker))
        return 2;
      return -1;
   }
}