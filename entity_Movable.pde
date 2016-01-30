//------------------------------------------------------------------------------
// Base classes for movable entities which can do moving, rendering, collision
//------------------------------------------------------------------------------


public class MovableCircle extends Movable //CIRCLE IS BOUNDING BOX
{
   protected float size;
   protected color fill;
   
   public boolean selected    =false;
   public boolean drag        =false;
   public boolean moving      =false;
   public boolean targetReached=false;
   
   protected PVector target;
   
   protected final float speed = 0.4;
   
   protected color selectedColor = color(50,200,20);
   

   
   public  MovableCircle(int _id)
   {
      super();
      id = Float.toString(_id);
      size = 32;
      fill = color(0,0,0,130);
      type=1;
   }
   
   public void setSize(float s){ size = s; }
   
   public float getRad(){ return size/2; }
   
   @Override
   public float getWidth(){ return size; }
   
   @Override
   public float getHeight(){ return size; }
   
   @Override
   public void hit(Movable target)
   {
      isHit = true;
      
   }

   /** renders this movable to the screen **/
   public void display()
   {
      pushMatrix();
        translate(pos.x, pos.y);
        stroke(selected ? selectedColor : 0);
        strokeWeight(1);
        fill(mouseOver ? 20 : fill);
        ellipse(0,0,size,size);
      popMatrix();
   }
   
   
   /** updates internal values before rendeing **/
   public void update(double delta)
   {  
      hitMouse();
      //if(selected && !mouseOver && mouseClicked && !targetReached)
      //{
      //   target = new PVector(mouseX, mouseY);
      //}
      if(target!=null)
      {
         follow(target, delta);
         
         if(target.dist(pos)<1)
         {
           target=null;
         }
      }
      //PVector rand = new PVector(random(-1,1),random(-1,1));
      //if(!isHit)walk(rand);
      //PVector grav = new PVector(0,0.981);
      //grav.normalize();
      //grav.mult(0.981);
      
      //if(!isHit)pos.add(grav);
   }
   
   public void walk(PVector dir, double delta)
   {
       dir.normalize();
       dir.mult((float)(speed*delta));
       pos.add(dir);
   }
   
   public void follow(PVector target, double delta)
   {
      PVector dir = PVector.sub(target,pos);         //direction
      walk(dir, delta);
   }

   @Override
   public void collide(Movable target, PVector[] intersection, double delta)
   {
      if(target.type == 1)
      {
        float dx = target.pos.x - pos.x;
        float dy = target.pos.y - pos.y;
        
        float minDist = (width/2)+target.getWidth()/2;
        
        float angle = atan2(dy, dx);
        float targetX = pos.x + cos(angle) * minDist;
        float targetY = pos.y + sin(angle) * minDist;
        float ax = (targetX - target.pos.x) * 5;
        float ay = (targetY - target.pos.y) * 5;
        
         walk(new PVector(-ax,-ay), delta);
         
      }
      if(target.type == 2 && intersection != null && intersection.length>0)
      {
          float dx = intersection[0].x - pos.x;
          float dy = intersection[0].y - pos.y;
          
          float minDist = (width/2)+target.getWidth()/2;
          
          float angle = atan2(dy, dx);
          float targetX = pos.x + cos(angle) * minDist;
          float targetY = pos.y + sin(angle) * minDist;
          float ax = (targetX - intersection[0].x) * 5;
          float ay = (targetY - intersection[0].y) * 5;
          fill = color(0,255,0);
          PVector col = new PVector(-ax,-ay);
          col.normalize();
          col.mult(5);
          pos.add(col);
      }
      isHit = false;
   }
   
   public boolean hitMouse()
   {
     if ((pos.x - mouseX) * (pos.x - mouseX) + (pos.y - mouseY) * (pos.y - mouseY) <= ((size/2) * (size/2)))
     {
        fill = color(255,0,0);
        mouseOver = true;
        if (mouseClicked)
        {
            selected = !selected;
        }
     }else{
        mouseOver = false;  
     }
     return mouseOver;
   }
}


public class MovableLine extends Movable implements IDisplayable
{
    protected float w,h;
    protected color fill;
    public PVector pos2;
    public MovableLine()
    {
      super();
      id = "line";
      fill = color(255,0,200);
      type=2;
      pos2 = new PVector(0,0,0);
    }
   

   
   public void setWidth(float wid)
   {
      w = wid;
      pos2.x = pos.x+w;
   }
   
   public void setHeight(float hei)
   {
      h = hei; 
      pos2.y = pos.y+h;
   }
   
   @Override
   public float getWidth(){ return w; }
   
   @Override
   public float getHeight(){ return h; }
   
   @Override
   public void display()
   {
      pushMatrix();
        translate(pos.x,pos.y);
        strokeWeight(2);
        stroke(fill);
        line(0,0,w,h);
      popMatrix();
   }
}



//===========================================================
//
// MOVABLE
//
//===========================================================


abstract class Movable implements IDisplayable,IDisposable
{
  protected PVector pos;
  protected PVector dir;
  protected PVector vel;
  
  protected float spd;
  protected float rot;
  
  public boolean mouseOver;
  public boolean isHit;
  public boolean isDead;
  public boolean removable;
  
  public int index;
  public String id;
  public int type=0;
  
     //Creep stats
   public int hp = 100;
   public int atk = 10;
  
  public Movable()
  {
    pos = new PVector(0.0,0.0,0.0);
    dir = new PVector(0.0,0.0,0.0);
    vel = new PVector(0.0,0.0,0.0);
    spd = 1;
    rot = 1;
  }
  
  public void setPos(float x, float y, float z)
  {
     pos.x = x;
     pos.y = y;
     pos.z = z;
  }
  
  public void dispose()
  {
    pos = null;
    dir = null;
    vel = null;
  }
  
  public float getX(){ return pos.x; }
  public float getY(){ return pos.y; }
  public float getZ(){ return pos.z; }
  
  
  public float getWidth() {return 0;}
  public float getHeight(){return 0;}
  
  public void hit(Movable target){}
  
  public void rot(double r){}
  
  public void update(double delta){}
  public void follow(PVector target, double delta){}
  
  @Override
  public boolean equals(Object o)
  {
    return o!=null && (o instanceof Movable) && o==this && ((Movable)o).id == this.id;
  }
  
     
  public void collide(Movable target, PVector [] intersections, double delta){}
  
  public void display(){}
}