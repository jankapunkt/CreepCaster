public void spawn_enemy()
{
   spawn(2,-1); 
}

double ai_step = 0;
final int AI_MAX_STEP = 25;

public void setupAi()
{
   
}

public void updateAi(double delta)
{
  ai_step += delta;
  if (ai_step >= AI_MAX_STEP)
  {
    spawn_enemy();
    ai_step = 0;
  }
  
}