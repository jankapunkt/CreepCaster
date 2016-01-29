public static boolean dotInCirc(float x, float y, float cx, float cy, float rad)
{
    return ((x - cx) * (x - cx) + (y - cy) * (y - cy)) <= (rad*rad);
}

public static boolean circHitCirc(float x1, float y1, float r1, float x2, float y2, float r2)
{
    return ((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)) <= ((r1+r2) * (r1+r2));
}

/*to get points see: http://mathworld.wolfram.com/Circle-LineIntersection.html */
public static PVector[] circHitLine(float cx,float cy, float rad, float x1, float y1, float x2, float y2)
{
  //println(cx +"/"+cy+"/"+rad+" => "+ x1+"/"+y1 +" "+x2+"/"+y2);
  
  float bax = x2 - x1;
  float bay = y2 - y1;
  float cax = cx - x1;
  float cay = cy - y1;
  
  float a    = (bax * bax) + (bay * bay);
  float bby2 = (bax * cax) + (bay * cay);
  float c    = (cax * cax) + (cay * cay) - (rad*rad);
  
  float pby2 = bby2 / a;
  float q    = c / a;
  float disc = pby2 * pby2 - q;
  
  if (disc < 0)return null;
  // if disc == 0 ... dealt with later
  float tmpSqrt = sqrt(disc);
  float abScalingFactor1 = -pby2 + tmpSqrt;
  float abScalingFactor2 = -pby2 - tmpSqrt;

  PVector p1 = new PVector(x1 - bax * abScalingFactor1, y1- bay * abScalingFactor1);
  if (disc == 0) 
  { // abScalingFactor1 == abScalingFactor2
   return new PVector[]{p1};
  }
  PVector p2 = new PVector(x1 - bax * abScalingFactor2, x1 - bay * abScalingFactor2);
  return new PVector[]{p1,p2};
}


protected static int sgn(float val)
{
   return val < 0 ? -1 : 1; 
}

public static boolean circFullInBox(float x1, float y1, float r, float bx1, float by1, float bw, float bh)
{
    if (x1 - r < bx1 || y1 - r < by1)return false;
    if (x1 + r > bx1 + bw || y1 + r > by1 + bh)return false;
    
    return true;
}

public static boolean circInBox(float x1, float y1, float r, float bx1, float by1, float bw, float bh)
{
    if (x1 + r < bx1 || y1 + r < by1)return false;
    if (x1 - r > bx1 + bw || y1 - r > by1 + bh)return false;
    return true;
}