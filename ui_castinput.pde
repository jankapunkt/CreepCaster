//------------------------------------------------------------------------------
// this is where the casting input class is implemented
// this class will be used to draw your casting pattern
// which elads to spawn a new creep
//------------------------------------------------------------------------------

class CastMatrix
{
  public int posx, posy;
  public CastRect[] casts;
  private int buffer = -1;
  private ArrayList<Integer> sequence;
  
  public CastMatrix(int posx, int posy, int space, int size)
  {
    clearSequence();
    casts = new CastRect[9];
    for (int i=0;i<3;i++)
        casts[i] = new CastRect(posx + (i*2*space), posy, size);

    for (int i=3;i<6;i++)
        casts[i] = new CastRect(posx + ((i-3)*2*space), posy+ 2*space, size);

    for (int i=6;i<9;i++)
        casts[i] = new CastRect(posx + ((i-6)*2*space), posy + 4*space, size);
    
  }
  
  public void clearSequence()
  {
     sequence =  new ArrayList<Integer>();
  }
  
 
  
  public void update()
  {
     if(!mousePressed)clearSequence();
     for (int i=0;i<casts.length;i++)
     { 
       if(casts[i].hit()&&i!=buffer)
       {
           buffer = i;
           sequence.add(i);
       }
       casts[i].display();
     }
     if(CastingChecker.checkSequence(sequence)!=-1)
     {
       spawn(1);  
       clearSequence();
     }
     
   }
  
  
}

class CastRect
{
   public boolean hit;
   public int posx, posy, w, h;
   
   public CastRect(int posx, int posy, int size)
   {
     this.posx = posx;
     this.posy = posy;
     this.w = this.h = size;
   }
   
   public boolean hit()
   {
       this.hit = mousePressed &&  dotInSquare(mouseX, mouseY, posx, posy, w, h);
       return hit;
   }
   
   public void display()
   {
      pushMatrix();
        translate(posx, posy);
        if(hit)
          fill(255,0,0,150);
        else
          fill(255,255,255,150);
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

   
   public static int checkSequence(ArrayList<Integer> input)
   {
     
      return input.size()>=3 ? 0 : -1;
   }
}