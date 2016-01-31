

public int ai_points = 0;
public int player_points=0;

float ai_level = 0;
double ai_step = 0;
final int AI_MAX_STEP = 15;

public void updateAi(double delta)
{
  ai_step += delta;
  ai_level += frameRate>0? 1/(frameRate*50) : 1/3000;
  println(ai_level);
  if (ai_step >= AI_MAX_STEP)
  {
    int spwn = (int)random(0,ai_level);
    spawn(2,spwn);
    ai_step = 0;
  }  
}