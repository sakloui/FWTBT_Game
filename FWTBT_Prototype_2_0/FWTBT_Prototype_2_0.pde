import ddf.minim.*;

boolean spawnedPlatform = false;
MovingPlatform movingPlatform;

//------Classes------
Menu menu;
Player player;
BoxManager boxManager;
Camera camera;
Input input = new Input();
PowerUpManager powerUpManager;
GameManager gameManager;
Highscore highscore;

//------ArrayList stuff------
ArrayList<Anchor> anchors = new ArrayList<Anchor>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Currency> coins = new ArrayList<Currency>();
ArrayList<Magnet> magnet = new ArrayList<Magnet>();

//------Image stuff------
PImage map;
PImage foregroundImage;

PImage biskitGames;

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
PImage overgrownLeft;
PImage overgrownMiddle;
PImage overgrownRight;
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

//------Highscore stuff------



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

  highscore = new Highscore();
}

void draw()
{
  //------Time------
  deltaTime = (millis() - lastTime) / 1000; //Calculates the diffrence in time between frames
  lastTime = millis();

  //------Background Stuff------
    background(0); 

  //------Gamestate------

  if(input.isUp && !spawnedPlatform)
  {
    movingPlatform = new MovingPlatform(new PVector(width/2, height-100), 200, 20, width/2 - 300, width/2 + 300, true);
    spawnedPlatform = true;
  }

  counter += deltaTime;
  if (counter >= loadingTime)
  {  
     
    if(isMenu)
    {
      menu.draw();
    }
    else
    {
      if(input.isP){menu.menuState = 1; menu.createLevelSelect();isMenu = true;mainMusic.rewind();mainMusic.play();if(levelmusic != null)levelmusic.pause();gameManager = new GameManager();}
      image(background,width/2,height/2);

      if (boxManager.rows > 32){
        camera.UpdateX();
      }
      if (boxManager.columns > 18){
        camera.UpdateY();
      }

      player.Update();
      if(spawnedPlatform)
      {
        movingPlatform.updateMovingPlatform();
      }
      boxManager.Update();
      powerUpManager.Update();  
      for (int i = 0; i < enemies.size(); ++i) {
        if(enemies.get(i) !=null)
        enemies.get(i).Update();
      }

      highscore.updateScore();      
      gameManager.Update();
      for(Magnet mag: magnet){
        mag.Update();
      }




      //----------Draws---------- 

      boxManager.DrawBoxes();

      gameManager.drawCurrency();
      for (int i = 0; i < enemies.size(); ++i) {
        if(enemies.get(i) !=null)
        enemies.get(i).Draw();
      }           

      boxManager.DrawForeground();

      player.Draw();


      gameManager.Draw();

      for(Magnet mag: magnet){
        mag.Draw();
      }

      for (int i = 0; i < anchors.size(); i++)
      {
        anchors.get(i).Draw();
      }
      
      powerUpManager.Draw();    

      if(spawnedPlatform)
      {
        movingPlatform.drawMovingPlatform();
      }
    }
  }
  else
  {
    //draw loading text
    pushMatrix();
    textSize(48);
    image(biskitGames, width/2, height/2-150,200,200);
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
