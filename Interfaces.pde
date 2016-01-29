public interface IDisplayable
{
   void display(); 
}

public interface IDisposable
{
   void dispose(); 
}

public interface ILocatable
{
   float getX();
   float getY();
}

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