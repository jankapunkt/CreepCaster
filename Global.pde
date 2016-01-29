/**

This class manages all visible objects and their interaction, rendering and so on.

**/
public class ObjManager
{
  //------------------------------------------------------//
  //VARIABLES
  
  private Vector<Movable> list; 
  private QuadTree quad;
  
  protected boolean debugQuad = false;
  
  //number of current collisions
  public int collitions=0;
  
  //------------------------------------------------------//
  //CONSTRUCTION
  /** constructor **/
  public ObjManager()
  {
     quad = new QuadTree(0, new Rectangle(0,0,1000,600));
     list = new Vector<Movable>();
  }
  
  //------------------------------------------------------//
  //PUBLIC
  
  /** adds a movable to the list **/
  public void add(Movable m){ list.add(m); }

  
  
  /** renders all movables in the list **/
  public void display()
  {
      for(int i=0;i<list.size();i++)
      {        
        Movable m = list.get(i);
        m.display();
      }
      if(debugQuad)quad.display();
  }
  
  
  /** updates collision of all objects **/
  public void update(double delta)
  {
      int count=0;
      quad.clear(); //clear quadtree
      for(int i=0;i<list.size();i++)
      {        
        Movable m = list.get(i);
       // m.update(delta);
        m.follow(mousePos, delta);
        m.hit(false);
        quad.insert(m);
        count++;
      }

      List<Movable> returnObjects = new ArrayList<Movable>();
      for(int i=0;i<list.size();i++)
      {
        returnObjects.clear();
        Movable current = list.get(i);
        quad.retrieve(returnObjects, current);
        for(int j=0;j<returnObjects.size();j++)
        {
            Movable movable = returnObjects.get(j);
            if (current.equals(movable))continue;
            boolean hit=false;
            PVector [] intersection = new PVector[0];
            if (current.type == 1)
            {
                  hit = circHitCirc(current.getX(), current.getY(), current.getWidth()/2, movable.getX(), movable.getY(), movable.getWidth()/2);
            }
            if (current.type == 2)
            {
                  intersection = circHitLine(movable.getX(), movable.getY(), movable.getWidth()/2, current.getX(), current.getY(), current.getX()+current.getWidth(), current.getY()+current.getHeight());
            }
            
            if(hit || intersection != null && intersection.length > 0)
            {
                current.hit(hit);
                movable.hit(hit); 
                current.collide(movable, intersection, delta);
                movable.collide(current, intersection, delta);
            }

            
            
            
            if(current.mouseOver)
            {
              strokeWeight(1);
              stroke(0,255,0);
              line(current.getX(), current.getY(),movable.getX(), movable.getY());  
            }
              
        count++;    
        }
      }
      collitions = count;
  }
  
  /** sets if the quadtree is rendered **/
  public void debugQuad(boolean value){ debugQuad=value; }
}