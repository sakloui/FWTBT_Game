import ddf.minim.*;


//------Classes------
Menu menu;
Player player;
BoxManager boxManager;
Camera camera;
Input input = new Input();
PowerUpManager powerUpManager;
Enemy enemy;
GameManager gameManager;

//------ArrayList stuff------
ArrayList<Anchor> anchors = new ArrayList<Anchor>();

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
State currentState;

float lastTime;
float deltaTime;

float counter = 0;
float loadingTime = 5f;

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

  menu = new Menu();

}

void draw()
{
  //------Time------
  deltaTime = (millis() - lastTime) / 1000; //Calculates the diffrence in time between frames
  lastTime = millis();

  //------Background Stuff------
    background(0); 

  //------Gamestate------

  counter += deltaTime;
  if (counter >= loadingTime)
  {  
     
    if(isMenu)
    {
      menu.draw();
    }
    else
    {
      if(input.isP){isMenu = true;mainMusic.rewind();mainMusic.play();if(levelmusic != null)levelmusic.pause();}
      image(background,width/2,height/2);

      if (boxManager.rows > 32){
        camera.UpdateX();
      }
      if (boxManager.columns > 18){
        camera.UpdateY();
      }

      player.Update();
      boxManager.Update();
      powerUpManager.Update();  
      if(enemy !=null)
      enemy.Update();
      gameManager.Update();




      //----------Draws----------
      boxManager.DrawBoxes();
      boxManager.DrawForeground();
      player.Draw();
      if(enemy !=null)      
      enemy.Draw();
      gameManager.Draw();
      for (int i = 0; i < anchors.size(); i++)
      {
        anchors.get(i).Draw();
      }
      
      powerUpManager.Draw();    
    }
  }
  else
  {
    //draw loading text
    pushMatrix();
    textSize(48);
    text("Loading...", width/2, height/2);
    popMatrix();
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

void keyPressed()
{
  input.KeyDown(keyCode, true);
}

void keyReleased()
{
  input.KeyDown(keyCode, false);
}
