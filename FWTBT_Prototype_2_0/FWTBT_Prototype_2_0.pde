import ddf.minim.*;


//------Classes------
Menu menu;
Player player;
BoxManager boxManager;
Camera camera;
//------Image stuff------
PImage map;
PImage foregroundImage;

PImage background;

PImage tileBox;
PImage tileSteelPillar;
PImage tileSmallPlatformTopRight;
PImage tileSmallPlatformPillarRight;
PImage tileSmallPlatformTopLeft;
PImage tileSmallPlatformPillarLeft;
PImage tileMiniPlatformTop;
PImage steelPlatformLeft;
PImage steelPlatformMiddle;
PImage steelPlatformRight;
PImage steelPlatformMiddle2;
PImage hookMiddle;
PImage hookTop;

//------Font stuff------
PFont font;

//------Variables------
float lastTime,deltaTime;
boolean isMenu;
int currentLevel;

float[] volume = new float[5];


float boxSize = 40;



//------Sounds------
Minim minim;
AudioPlayer click;
AudioPlayer click2;
AudioPlayer mainMusic;
AudioPlayer levelmusic;
AudioPlayer jumpsound;
AudioPlayer walkingsound;
AudioPlayer interactionsound;

//------Keys------
boolean isUp,isDown,isRight,isLeft,isSpace,isP;

void setup()
{
  size(1280,720,P2D);
  rectMode(CENTER);
  imageMode(CENTER);
  ellipseMode(CENTER);
  background(0);


  for(int i = 0; i < volume.length; i++) {
    volume[i] = 23;
  }

  extraSetup();

  player= new Player();
  camera = new Camera();

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
    if(isP){isMenu = true;mainMusic.rewind();mainMusic.play();if(levelmusic != null)levelmusic.pause();}
    image(background,width/2,height/2);

    if (boxManager.rows > 32){
      camera.UpdateX();
    }
    if (boxManager.columns > 18){
      camera.UpdateY();
    }

    player.Update();
    boxManager.Update();




    //----------Draws----------
    boxManager.DrawBoxes();
    player.Draw();
    boxManager.DrawForeground();

  }

}


void updateGrid()
{
  for(int i = 0; i < boxManager.columns; i++)
  {
    
    for(int j = 0; j < boxManager.rows; j++)
    {
      if(foregroundImage != null)
      {
        if(boxManager.foreground[j][i].foreCollides == 4){
          boxManager.foreground[j][i].foreCollides = 0;
        }
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
