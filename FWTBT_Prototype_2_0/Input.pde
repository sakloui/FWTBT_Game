class Input
{
  boolean isUp,isDown,isRight,isLeft,isSpace,isP,isK,isL;
  
  boolean KeyDown(int k, boolean b)
  {
    switch(k)
    {
    case 'W':
    case UP:
      return isUp = b;
    case 'S':
    case DOWN:
      return isDown = b;
    case 'A':
    case LEFT:
      return isLeft = b;
    case 'D':
    case RIGHT:
      return isRight = b;
    case 'K':
      return isK = b;
    case 'L':
      return isL = b;
    case 32:
      return isSpace = b;
    case 'P':
      return isP = b;      
    default:
      return b;
    }
  }
}
