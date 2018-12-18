class Input
{
  boolean isUp,isDown,isRight,isLeft,isSpace,isP,isK,isL,isR;
  
  boolean KeyDown(int k, boolean b)
  {
    switch(k)
    {
    case UP:
      return isUp = b;
    case DOWN:
      return isDown = b;
    case LEFT:
      return isLeft = b;
    case RIGHT:
      return isRight = b;
    case 'Z':
      return isK = b;
    case 'X':
      return isL = b;
    case 'R':
      return isR= b;
    case 32:
      return isSpace = b;
    case 'P':
      return isP = b; 
    case 27:
      key = 0;
      return isP = b;     
    default:
      return b;
    }
  }
}
