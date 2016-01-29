
/** all displayable objects **/
public interface IDisplayable
{
   void display(); 
}


/** all disposable objects **/
public interface IDisposable
{
   void dispose(); 
}

/** locatable by others **/
public interface ILocatable
{
   float getX();
   float getY();
}

/** AI, maybe usable later **/
public interface IEmotionalState
{
  void idle();
  void aware();
  void intrigued();
  void alert();
  void aggressive();
  void fleeing();
  void dead();
}