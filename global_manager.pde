//========================================================================================
//
//
//    OBJECT MANAGER
//
//
//========================================================================================

/**
This class manages all visible objects and their interaction, rendering and so on.
**/
public class ObjManager
{
  //------------------------------------------------------//
  //VARIABLES
  
  private List<Movable> list;
  private List<Movable> removes;
  private QuadTree quad;
  
  protected boolean debugQuad = false;
  
  //number of current collisions
  public int collitions=0;
  
  //------------------------------------------------------//
  //CONSTRUCTION
  /** constructor **/
  public ObjManager()
  {
     quad = new QuadTree(0, new Rectangle(0,0,SCREEN_WIDTH,SCREEN_HEIGHT));
     list = new ArrayList<Movable>();
     removes = new ArrayList<Movable>();
  }
  
  //------------------------------------------------------//
  //PUBLIC
  
  /** adds a movable to the list **/
  public void add(Movable m)
  {
  //  m.index = list.size();
    list.add(m); 
  }

  public void removeMovable(int index)
  {
     list.remove(index);
  }
  
  /** renders all movables in the list **/
  public void display()
  {
      for(int i=0;i<list.size();i++)
      {        
        Movable m = list.get(i);
        m.display();
      }
      if(debugQuad)
        quad.display();
  }
  
  
  /** updates collision of all objects **/
  public void update(double delta)
  {
      int count=0;
      quad.clear(); //clear quadtree
      removes.clear();
      int size = list.size();
      for(int i=size-1;i>0;i--)
      {        
        Movable m = list.get(i);
        if (m.removable)
        {
           m.dispose();
           list.remove(m);
           m=null;
           continue;
        }
          if(m.index==1)
            m.follow(leftGoal, delta);
          if(m.index==2)
            m.follow(rightGoal, delta);

          quad.insert(m);
          count++;
      }

      List<Movable> returnObjects = new ArrayList<Movable>();
      size = list.size();
      for(int i=0;i<size;i++)
      {
        returnObjects.clear();
        Movable current = list.get(i);
        quad.retrieve(returnObjects, current);
        for(int j=0;j<returnObjects.size();j++)
        {
            Movable movable = returnObjects.get(j);
            if (current.equals(movable) || movable.isDead)
              continue;
            boolean hit=false;
            PVector [] intersection = new PVector[0];
            
            hit = circHitCirc(current.getX(), current.getY(), current.getWidth()/2, movable.getX(), movable.getY(), movable.getWidth()/2);           
            if(hit || intersection != null && intersection.length > 0)
            {
                if ((current.index == 2 && movable.type == -2) || (current.type == -2 && movable.index == 2)) 
                {
                     ai_points++;
                }else if ((current.index == 1 && movable.type == -1)|| (current.type == -1 && movable.index == 1)) 
                {
                     player_points++;
                }else{
                    current.hit(movable);
                    movable.hit(current);
                    current.collide(movable, intersection, delta);
                    movable.collide(current, intersection, delta);
                }
            }
              
        count++;    
        }
      }
      collitions = count;

  }
  
  /** sets if the quadtree is rendered **/
  public void debugQuad(boolean value){ debugQuad=value; }
}