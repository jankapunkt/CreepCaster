import java.util.Vector;
import java.util.List;
import java.util.Iterator;


/** 
  quadtree implementation, 
  follows the java tree implementation
**/
public class QuadTree implements IDisplayable
{
  public int MAX_OBJECTS = 2; //max objects per quad before splitting
  public boolean debug=false;
  
  private int level;               //current level
  private List<Movable> objects;   //all objects in the current tree node
  private Rectangle bounds;
  private QuadTree[] nodes;
 
  

  public QuadTree(int pLevel, Rectangle pBounds)
  {
    level = pLevel;
    objects = new Vector();
    bounds = pBounds;
    nodes = new QuadTree[4];
  }

  public void clear()
  {
    objects.clear();
    for (int i=0; i<nodes.length; i++)
    {
      if (nodes[i] == null)continue;
      nodes[i].clear();
      nodes[i] = null;
    }
  }

  private void split()
  {
    int subWidth  = (int)(bounds.getWidth() / 2);
    int subHeight = (int)(bounds.getHeigh() / 2);
    int x = (int)(bounds.getX());
    int y = (int)(bounds.getY());

    //top left
    nodes[0] = new QuadTree(level+1, new Rectangle(x + subWidth, y, subWidth, subHeight));
    
    //top right
    nodes[1] = new QuadTree(level+1, new Rectangle(x, y, subWidth, subHeight));
    
    //bottom left
    nodes[2] = new QuadTree(level+1, new Rectangle(x, y + subHeight, subWidth, subHeight));
    
    //bottom right
    nodes[3] = new QuadTree(level+1, new Rectangle(x + subWidth, y + subHeight, subWidth, subHeight));
  }

  public boolean insert(Movable movable)
  {
    //ignore points that do not belong to this quadTree, just include full circles
    if (!bounds.containsFull(movable.getX(),movable.getY(),movable.getWidth()/2)) return false;
    
    //while max size not reached, continue adding
    if(objects.size() < MAX_OBJECTS) 
    {
      objects.add(movable);
      return true;
    }
    
    //split if size is reached and child is null
    if (nodes[0] == null) this.split();
    
    //store object in children
    if (nodes[0].insert(movable) || nodes[1].insert(movable) || nodes[2].insert(movable) || nodes[3].insert(movable))
    {
      objects.remove(movable);
      return true;
    }
    
    //fallback
    objects.add(movable);
    return true;
  }

  public void retrieve(List returnObjects, Movable movable)
  {
    //abort, if node is not in this sector
    if (!bounds.contains(movable.getX(), movable.getY(), movable.getWidth()/2)) return;
    
    //copy all nodes
    int i=0;
    while(i<objects.size())
    {
       Movable m = objects.get(i++);
       if (returnObjects.contains(m))continue; //skip doubles
       returnObjects.add(m);
    }
    
    //if in sector, retrieve from children
    if (nodes[0] == null)
    {
      return;
    }
    nodes[0].retrieve(returnObjects, movable);
    nodes[1].retrieve(returnObjects, movable);
    nodes[2].retrieve(returnObjects, movable);
    nodes[3].retrieve(returnObjects, movable);
  }
  
  public void display()
  {
      
    for (int i=0; i<nodes.length; i++)
    {
      if (nodes[i]!=null)
      {
        nodes[i].debug=true;
        nodes[i].display();
      }
    }
    pushMatrix();
      translate(bounds.getX(), bounds.getY());
      stroke(255, 0, 0);
      noFill();
      rect(0, 0, bounds.getWidth(), bounds.getHeigh());
    popMatrix();
    }
  }


//=======================================================================//
public class Rectangle implements IDisplayable, ILocatable
{
  protected float posx, posy, wid, hei;
  protected boolean isHit=false;  
  public Rectangle()
  {
    posx = 0;
    posy = 0;
    wid  = 0;
    hei  = 0;
  }

  public Rectangle(float x, float y, float w, float h)
  {
    posx = x;
    posy = y;
    wid  = w;
    hei  = h;
  }

  public float getX() { return posx; }
  public float getY() { return posy; }
  
  public float getWidth() { return wid; }
  public float getHeigh() { return hei; }

  public boolean contains(float x, float y, float r)
  {
    if (x + r < posx || y + r < posy)return false;
    if (x - r > posx + wid || y - r > posy + hei)return false;
    return true;
  }
  
  public boolean containsFull(float x, float y, float r)
  {
    if (x - r < posx || y - r < posy)return false;
    if (x + r > posx + wid || y + r > posy + hei)return false;
    return true;
  }
  
  public void hit(boolean value)
  {
      isHit = value; 
  }
  
  public void display()
  {
    pushMatrix();
      translate(posx, posy);
      stroke(255, 0, 0);
      if(isHit)
        fill(255,0,0,100);
      else
        noFill();   
      rect(0, 0, wid, hei);
    popMatrix();
  }
}