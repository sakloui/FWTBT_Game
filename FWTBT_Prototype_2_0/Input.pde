class Input
{
  boolean isUp,isDown,isRight,isLeft,isSpace,isP,isK,isL,isR,isU;
  boolean enabled = true;

  boolean KeyDown(int k, boolean b)
  {
    if(enabled)
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
      case 32:
        return isSpace = b;
      case 'P':
        return isP = b; 
      case 27:
        key = 0;
        return isP = b;  
      case 'R':
        return isR = b;   
      case 'U':
        return isU = b;
      default:
        return b;
      }
    }
    else
      isUp = false;
      isDown = false; 
      isRight = false; 
      isLeft = false; 
      isSpace = false; 
      isP = false; 
      isK = false; 
      isL = false; 
      isR = false;
      return false;
  }
}
