class Input
{
  boolean isUp, isDown, isLeft, isRight, isK, isL;

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
    default:
      return b;
    }
  }
}
