import ddf.minim.*;


//------Classes------
Menu menu;
Player player;
BoxManager boxManager;
//------Image stuff------
PImage map;
PImage tile;
PImage background;
//------Font stuff------
PFont font;

//------Variables------
float lastTime,deltaTime;
boolean isMenu;
int currentLevel;

int amount = 32;
float boxSize = 40;



//------Sounds------
Minim minim;
Minim minim2;
AudioPlayer click;
AudioPlayer click2;
AudioPlayer mainMusic;
//------Keys------
boolean isUp,isDown,isRight,isLeft,isSpace,isP;

void setup()
{
  size(1280,720,P2D);
  rectMode(CENTER);
  imageMode(CENTER);
  ellipseMode(CENTER);
  background(0);
  extraSetup();

  player= new Player();

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
    if(isP){isMenu = true;mainMusic.rewind();mainMusic.play();}
    image(background,width/2,height/2);

    player.Update();
    boxManager.Update();


    //----------Draws----------
    boxManager.DrawBoxes();
    player.Draw();

  }

}


void updateGrid()
{
  for(int i = 0; i < boxManager.rows; i++)
  {
    for(int j = 0; j < boxManager.columns; j++)
    {
      if(boxManager.boxes[i][j].collides == 9){
        boxManager.boxes[i][j].collides = 0;
      }
    }
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
    case 'P':
      return isP = b;
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
