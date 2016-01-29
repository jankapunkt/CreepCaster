public class ObjManager
{
  private Vector<Movable> list; 
  private QuadTree quad;
  
  protected boolean debugQuad = false;
  public int collitions=0;
  
  public ObjManager()
  {
     quad = new QuadTree(0, new Rectangle(0,0,1000,600));
     list = new Vector<Movable>();
  }
  
  public void add(Movable m){ list.add(m); }

  public void debugQuad(boolean value){ debugQuad=value; }
  
  public void display()
  {
      for(int i=0;i<list.size();i++)
      {        
        Movable m = list.get(i);
        m.display();
      }
      if(debugQuad)quad.display();
  }
  
  public void update(double delta)
  {
      
      int count=0;
      //clear quadtree
      quad.clear();
      for(int i=0;i<list.size();i++)
      {        
        Movable m = list.get(i);
       // m.update(delta);
        m.follow(mousePos.set(mouseX, mouseY), delta);
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
}



protected boolean mouseClicked = false;
void mouseClicked()
{
   mouseClicked = true; 
}