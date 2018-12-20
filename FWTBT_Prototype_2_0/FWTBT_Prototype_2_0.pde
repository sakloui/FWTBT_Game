import ddf.minim.*;

boolean spawnedPlatform = false;
MovingPlatform movingPlatform;
Laser laser;
ArrayList<SlipperyTile> slipperyTiles = new ArrayList<SlipperyTile>();
Boss boss;

//------Classes------
Menu menu;
Player player;
CheckPointManager checkPointManager;
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
ArrayList<Bullets> bullet = new ArrayList<Bullets>();
ArrayList<Particles> particle = new ArrayList<Particles>();
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
PImage exitDoor;
PImage enterDoor;
PImage ladder;

PImage wireStart;
PImage wireHeel;
PImage wireHeel2;
PImage wireCompleet;
PImage wireStartBroken;
PImage wireHeelBroken;
PImage wireHeel2Broken;
PImage wireCompleetBroken;

PImage[] basicEnemy;
PImage[] electricOrb;
PImage[] electricOrbPurple;

PImage tutorialA;
PImage tutorialD;
PImage tutorialW;
PImage tutorialDeath;
PImage tutorialLadderW;
PImage tutorialLadderS;
PImage tutorialX;
PImage tutorialZ;
PImage tutorialK;
PImage tutorialL;
PImage tutorialSecret;
PImage tutorialEnd;

PImage uiScreen;
PImage uiScreenOverlay;
PImage uiScreen2;
PImage uiScreen2Overlay;
PImage uiScreenGreen;
PImage uiScreenOverlayGreen;
PImage uiScreen2Green;
PImage uiScreen2OverlayGreen;
PImage uiScreen3;
PImage uiScreen4;


//------Font stuff------
PFont font;
PFont pixelFont;

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

  noStroke();

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
      

      if (boxManager.rows > 32){
        camera.UpdateX();
      }
      if (boxManager.columns > 18){
        camera.UpdateY();
      }

      image(background,width/2,height/2,width, height);
      fill(255,255,255,25);
      rect(width/2,height/2,width,height);

      player.Update();
      if(spawnedPlatform)
      {
        //movingPlatform.updateMovingPlatform();
        laser.updateLaser();

        player.onOil = false;

        for(int i = 0; i < 10; i++)
        {
          slipperyTiles.get(i).updateSlipperyTile();

          if(slipperyTiles.get(i).underPlayer)
            player.onOil = true;
        }
      }      
      boxManager.Update();
      powerUpManager.Update();  
      for (int i = 0; i < enemies.size(); ++i) {
        if(enemies.get(i) !=null)
        enemies.get(i).Update();
      }

      for (int i = 0; i < bullet.size(); ++i) {
        if(bullet.get(i) !=null)
        bullet.get(i).Update();
      }      

      for (int i = 0; i < particle.size(); ++i) {
        if(particle.size() > 100)
          particle.remove(0);
        if(particle.get(i) !=null)
          particle.get(i).Update();
      }      

      checkPointManager.updateCheckPointManager();

      menu.update();
      highscore.updateScore();      
      gameManager.Update();
      for(Magnet mag: magnet){
        mag.Update();
      }

      //----------Draws---------- 

      boxManager.DrawBoxes();
      

      for (int i = 0; i < bullet.size(); ++i) {
        if(bullet.get(i) !=null)
        bullet.get(i).Draw();
      }     

      for (int i = 0; i < particle.size(); ++i) {
        if(particle.get(i) !=null)
        particle.get(i).Draw();
      }      

      for(Magnet mag: magnet){
        mag.Draw();
      }

      for (int i = 0; i < anchors.size(); i++)
      {
        anchors.get(i).Draw();
      }
      
   
      gameManager.drawCurrency();
      for (int i = 0; i < enemies.size(); ++i) {
        if(enemies.get(i) !=null)
        enemies.get(i).Draw();
      }  

      checkPointManager.drawCheckPointManager();

      powerUpManager.DrawPowerUps();

      boxManager.DrawForeground();



      player.Draw();

      if(boss!=null)
      {
        boss.bossUpdate();
        boss.bossDraw();
      }

      powerUpManager.DrawIcons();


      gameManager.Draw();

      if(spawnedPlatform)
      {
        //movingPlatform.drawMovingPlatform();
        laser.drawLaser();
        for(int i = 0; i < 10; i++)
        {
          slipperyTiles.get(i).drawSlipperyTile();
        }
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




void keyPressed()
{
  input.KeyDown(keyCode, true);
}

void keyReleased()
{
  input.KeyDown(keyCode, false);
}
