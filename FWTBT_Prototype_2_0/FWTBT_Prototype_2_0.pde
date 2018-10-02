//------Classes------
Menu menu;

//------Image stuff------
PImage map;

//------Font stuff------
PFont font;
//------Variables------
float lastTime,deltaTime;
boolean isMenu;

//------Keys------
boolean isUp,isDown,isRight,isLeft,isSpace;

void setup()
{
  size(1280,720,P2D);
  rectMode(CENTER);
  imageMode(CENTER);
  ellipseMode(CENTER);
  background(0);
  extraSetup();
  
}

void draw()
{
  //------Time------
  deltaTime = (millis() - lastTime) / 1000; //Calculates the diffrence in time between frames
  lastTime = millis();
  
  //------Background Stuff------
  background(0);
  
  //------Gamestate------
  if(isMenu)
  {
    menu.draw();
  }
  else
  {
  
  }
  
}

 boolean SetMove(int k, boolean b)
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
    case 32:
      return isSpace = b;
    default:
      return b;
    }
  }
  
void keyPressed()
{
  SetMove(keyCode, true);
}

void keyReleased()
{
  SetMove(keyCode, false);
}
