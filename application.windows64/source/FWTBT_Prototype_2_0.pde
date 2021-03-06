import ddf.minim.*;

boolean spawnedPlatform = false;
MovingPlatform movingPlatform;
Laser laser;
ArrayList<SlipperyTile> slipperyTiles = new ArrayList<SlipperyTile>();
Boss boss;

//------Classes------
Menu menu;
Player player;
Debug debug;
CheckPointManager checkPointManager;
BoxManager boxManager;
Camera camera;
Input input = new Input();
PowerUpManager powerUpManager;
GameManager gameManager;
Highscore highscore;
Introscherm introScherm = new Introscherm();

//------ArrayList stuff------
ArrayList<Anchor> anchors = new ArrayList<Anchor>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Currency> coins = new ArrayList<Currency>();
ArrayList<Magnet> magnet = new ArrayList<Magnet>();
ArrayList<Bullets> bullet = new ArrayList<Bullets>();
ArrayList<Particles> particle = new ArrayList<Particles>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
//------Image stuff------
PImage map;
PImage foregroundImage;

PImage biskitGames;

PImage background;

//All types of boxes
PImage tileBox;
PImage boxLinks;
PImage boxOmhoog;
PImage boxOmlaag;
PImage boxRechts;
PImage boxCornerLinksBoven;
PImage boxCornerLinksOnder;
PImage boxCornerRechtsBoven;
PImage boxCornerRechtsOnder;
PImage boxCornerPointRechtsBoven;
PImage boxCornerPointRechtsOnder;
PImage boxCornerPointLinksBoven;
PImage boxCornerPointLinksOnder;


PImage box2CornerBoven;
PImage box2CornerOnder;
PImage box2CornerLinks;
PImage box2CornerRechts;
PImage box2CornerRechtsBovenLinksOnder;
PImage box2CornerRechtsOnderLinksBoven;

PImage box2LaagVerticaal;
PImage box2LaagZijwaards;

PImage box3CornerNietLinksBoven;
PImage box3CornerNietLinksOnder;
PImage box3CornerNietRechtsBoven;
PImage box3CornerNietRechtsOnder;
PImage box4Corner;

PImage box3PointDown;
PImage box3PointUp;
PImage box3PointLeft;
PImage box3PointRight;

PImage boxCornerRechtsOnderLaagLinks;
PImage boxCornerRechtsBovenLaagOnder;
PImage boxCornerRechtsOnderLaagBoven;
PImage boxCornerLinksOnderLaagBoven;
PImage boxCornerLinksBovenLaagRechts;
PImage boxCornerLinksBovenLaagOnder;
PImage box2CornerLinksOnderRechtsOnderLaagBoven;

PImage boxCornerLinksBovenLaagRechtsLaagOnder;
PImage boxCornerLinksOnderLaagRechtsLaagBoven;
PImage boxCornerRechtsBovenLaaglinksLaagOnder;
PImage boxCornerRechtsOnderLaaglinksLaagBoven;
// End of boxes
PImage secret;
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
PImage deathOrb;
PImage switch0;
PImage switch1;
PImage water0;
PImage underwater0;
PImage underwater1;
PImage magnetTex;
PImage grappleTex;
PImage wireStart;
PImage wireHeel;
PImage wireHeel2;
PImage wireCompleet;
PImage wireStartBroken;
PImage wireHeelBroken;
PImage wireHeel2Broken;
PImage wireCompleetBroken;

PImage[] bolts;
PImage[] goldenBolts;
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
PImage uiScreenEmpty;
PImage uiScreenOverlay;
PImage uiScreen2;
PImage uiScreen2Overlay;
PImage uiScreenGreen;
PImage uiScreenOverlayGreen;
PImage uiScreen2Green;
PImage uiScreen2OverlayGreen;
PImage uiScreen3;
PImage uiScreen3Overlay;
PImage uiScreen4;
PImage uiScreen4Overlay;

PImage rocketArmCooldown;
PImage rocketArmCooldownOverlay;
PImage rocketArmNotEquiped;
PImage rocketArmReady;

PImage rocketJumpCooldown;
PImage rocketJumpCooldownOverlay;
PImage rocketJumpNotEquiped;
PImage rocketJumpReady;

//introschreen
PImage[] introIdleScreen;
PImage[] intro;

//player animation
PImage[] grappleGrounded;
PImage[] grappleMidAir;

//boss animation
PImage bossSprite;
PImage[] idle;
PImage[] charge;
PImage[] blueCharge;
PImage[] chargeImpact;
PImage[] stunned;
PImage[] death;
PImage[] laserCharge;
PImage[] laserFire;

//fire animation
PImage[] fireAnimation;
PImage[] teslaCoil;

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
boolean cameraTracking = true;
boolean pauseWorld = false;
boolean displayIntro = true;
int currentLevel;

float[] volume = new float[5];

String playerName = "";

boolean isTypingName;

float boxSize = 40;

//------Highscore stuff------



//------Sounds------
Minim minim;
AudioPlayer click;
AudioPlayer click2;
AudioPlayer mainMusic;
AudioPlayer levelmusic;
AudioPlayer levelmusic1;
AudioPlayer levelmusic2;
AudioPlayer bossLevelMusic;
AudioPlayer jumpsound;
AudioPlayer walkingsound;
AudioPlayer interactionsound;
AudioPlayer laserFireSound;
AudioPlayer bossImpact;
AudioPlayer bossExplotions;
AudioPlayer[] bolt;
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
  if(input.isU && menu.mainmenuShown)
  {
    //reset menu stuff want errors
    //geen error als je in het main menu zit en op u drukt
    //........
    playerName = "";
    displayIntro = true;
  }


  counter += deltaTime;
  if (counter >= loadingTime)
  {  
     
    if(isMenu)
    {
      image(background,width/2,height/2,width, height);
      if(displayIntro)
      {
        introScherm.updateIntro();
        introScherm.drawIntro();
      }
      else 
      {
        if(isTypingName)
        {

          menu.showPlayerName();
        }
        menu.draw();
        debug.drawDebug();      
      }
    }
    else
    {
      if(input.isP){menu.menuState = 1; menu.createLevelSelect();isMenu = true;mainMusic.rewind();mainMusic.play();if(levelmusic != null)levelmusic.pause();gameManager = new GameManager();}
      
      if(cameraTracking)
      {
        camera.UpdateX();
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
      for (int i = 0; i < lasers.size(); ++i) {
        if(lasers.get(i) !=null)
        lasers.get(i).updateLaser();
      }

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

      debug.drawDebug();

      if(boss!=null)
      {
        boss.bossUpdate();
        boss.bossDraw();
      }

      powerUpManager.DrawIcons();


      for (int i = 0; i < lasers.size(); ++i) {
         if(lasers.get(i) !=null)
        lasers.get(i).drawLaser();
      }

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

  if(isTypingName)
    menu.registerName();  
}

void keyReleased()
{
  input.KeyDown(keyCode, false);
}
