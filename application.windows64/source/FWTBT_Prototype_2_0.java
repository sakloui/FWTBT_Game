import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class FWTBT_Prototype_2_0 extends PApplet {



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

public void setup()
{
  
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

public void draw()
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




public void keyPressed()
{
  input.KeyDown(keyCode, true);

  if(isTypingName)
    menu.registerName();  
}

public void keyReleased()
{
  input.KeyDown(keyCode, false);
}
class Anchor
{
  
  // This stores and draws the position of the anchor, the position is used in the RocketArm class to check if it's close to the grapple hook. 
  
  PVector position;
  int size = 40;
  int anchorColor = color(100, 255, 255);
  
  Anchor(PVector pos)
  {
    position = pos.copy();
  }
  
  public void Draw()
  {
    pushMatrix();
    translate(position.x  - camera.shiftX, position.y - camera.shiftY);
    fill(anchorColor);
    image(grappleTex,0,0, size, size);
    popMatrix();
  }
}
class Background
{
  // This class name is a bit misleading as it's actually just a ellipse spawner.
  // This is for the time being, incase it does get into the release here's how it works:
  // In the Menu class in the updateMenu method a timer is used to create a new Background class.

  PVector position = new PVector(0,0);
  float size;
  float speed;
  float alpha;
  Background()
  {
    // In here all variables except X position get randomized, this causes the ellipses to differ in size, speed, position and alpha.
    position.y = random(0,height);
    size = random(5,40);
    position.x = 0-size/2;
    speed = random(0.5f,2);
    alpha = random(50,220);
  }
  public void Update()
  {
    //

    position.x += speed;
    alpha -= random(0,0.3f);
    if(alpha <= 0 || position.x - size/2> width)
    	menu.back.remove(this);
  }
  
  public void Draw()
  {
    fill(210,190,200,alpha);
    ellipse(position.x, position.y, size, size);
  }	
}
class Boss
{
  PVector position;
  PVector spawnPosition;

  float aggroRange;
  float attackRange;
  float bossSize;










  float health;
  float maxHealth;
  float healthOffset;

  int currentDirection;
  float currentImage;
  float animationSpeed = 0.25f;

  boolean movingRight = false;
  boolean hasDied = false;
  boolean deleted;
  boolean first = true;

  PVector explosionPosition = new PVector(0, 0);
  float bossTimeDeath;
  float bossDeathDuration = 3f;

  float positionChangeCounter;
  float positionChangeTimer = 0.25f;

  final int LEFT = 0, RIGHT = 1;

  State currentState;

  Boss(PVector pos)
  {
    //set position
    spawnPosition = pos.copy();
    position = spawnPosition.copy();
    //set aggro- and attack range
    //set facing direction
    bossSize = 120f;
    maxHealth = 120f;
    health = maxHealth;

    bossLevelMusic.setGain(-40 + volume[0]);
    bossLevelMusic.rewind();
    bossLevelMusic.play();
    this.SetState(new BossIdleState(this));
  }


  public void bossUpdate()
  {


    if(deleted)
      return;

    if(hasDied)
    {
      death();
      if(first)
      {
        first = false;
        bossExplotions.rewind();
        bossExplotions.play();
      }
    }
    else 
    {
      //set the direction the boss is facing
      if (position.x - player.position.x < 0)
        currentDirection = 1;
      else
        currentDirection = 0;

      this.currentState.OnTick();

      checkPlayerCollision();

      healthOffset = -(maxHealth - health) / 2;  
    }
  }

  public void bossDraw()
  {
    if(deleted)
      return;

    this.currentState.OnDraw();

    if(health != 0)
      drawHealth();
    else {
      drawDeath();
    }
  }

  public void takeDamage(float damage)
  {
    health -= damage;
    bossImpact.rewind();
    bossImpact.play();    
    if(health <= 0)
    {
      health = 0;

      hasDied = true;
      explosionPosition = new PVector(boss.position.x - random(-75, 75), boss.position.y - random(-75, 75));
    }
  }

  public void checkPlayerCollision()
  {
    if((boss.position.x-player.position.x) * (boss.position.x-player.position.x) + 
      (player.position.y-boss.position.y) * (player.position.y-boss.position.y)
      <= (60+30) * (60+30))
    {
      menu.currentSel = 0;
      menu.createDied();
      menu.menuState = 0;
      isMenu = true;
    }
  }

  public void death()
  {
    currentImage = (currentImage + animationSpeed) % death.length;

    bossTimeDeath += deltaTime;
    positionChangeCounter += deltaTime;
    if(positionChangeCounter >= positionChangeTimer)
    {
      explosionPosition = new PVector(boss.position.x - random(-75, 75), boss.position.y - random(-25, 75));
      positionChangeCounter = 0f;
    }
    if(bossTimeDeath >= bossDeathDuration)
    {
      deleted = true;
      //boxManager.boxes[2][16].collides = 4;
      boxManager.boxes[2][16].type = exitDoor;
    }
  }

  public void drawHealth()
  {
    pushMatrix();
    translate(boss.position.x, boss.position.y - 100);
    noStroke();
    fill(255, 0, 0);
    rect(0, 0, maxHealth, 30);
    fill(0, 255, 0);
    rect(healthOffset, 0, health, 30);
    popMatrix();
  }

  public void drawDeath()
  {
    image(death[PApplet.parseInt(currentImage)], explosionPosition.x, explosionPosition.y);
  }

  public void SetState(State state)
  {
    if (currentState != null)
    {
      currentState.OnStateExit();
    }

    currentState = state;

    if (currentState != null)
    {
      currentState.OnStateEnter();
    }
  }
}
class BossAttackState extends State
{
  Boss boss;

  float animationSpeed;
  float currentFrame;
  int maxImage;
  final int chargeLength;
  final int blueChargeLength;
  final int chargeImpactLength;
  final int stunnedLength;
  final int shieldLength;

  PVector lookRotation;
  float rotation;

  float lockOnTime = 0.5f;
  float lockOnProgress;

  float stunDuration = 0.7f;
  float timeStunned;
  
  float chargeSpeed = 400;
  
  float grappleDamage = 10f;


  PVector targetPos = new PVector(0, 0);
  PVector beforeChargePosition = new PVector(0, 0);
  
  boolean lockedOnPlayer = false;
  boolean hasCharged = false;
  boolean returnToIdle = false;

  BossAttackState(Boss boss)
  {
    this.boss = boss;
    chargeLength = charge.length;
    blueChargeLength = blueCharge.length;
    chargeImpactLength = chargeImpact.length;
    stunnedLength = stunned.length;
    shieldLength = idle.length;
  }

  public void OnStateEnter()
  {
    //animation
    animationSpeed = 0.15f;
    currentFrame = 0;

    lockOnProgress = 0;
    lockedOnPlayer = false;

    lookRotation = new PVector(0, -1);

    returnToIdle = false;
    beforeChargePosition = boss.position.copy();

    powerUpManager.fuelCount = 99999;
  }

  public void OnTick()
  {












    if (!lockedOnPlayer)
    {
      lockOnPlayer();
    } else {
      if (!returnToIdle && !hasCharged)
      {
        chargeAtPlayer();
        checkMapBounds();
      } else if(hasCharged)
      {
        stunned();
        checkGrappleCollision();
      }
      else
      {
        returnToIdlePosition();
      }
    }




  }

  public void lockOnPlayer()
  {
    lockOnProgress += deltaTime;
    targetPos = player.position.copy().sub(boss.position.copy());
    targetPos.normalize();
    rotation = PI + (atan2(targetPos.y,targetPos.x) - atan2(lookRotation.y,lookRotation.x));

    if ( lockOnProgress >= lockOnTime)
    {
      targetPos = player.position.copy().sub(boss.position.copy());
      if(player.velocity.x > 0)
        targetPos.x += random(350);
      else if(player.velocity.x < 0)
        targetPos.x -= random(350);
      targetPos.normalize();
      
      rotation = PI + (atan2(targetPos.y,targetPos.x) - atan2(lookRotation.y,lookRotation.x));

      lockedOnPlayer = true;
    }
  }

  public void stunned()
  {
    stunDuration = ceil(boss.health/30);
    if(stunDuration <= 0)
      stunDuration = 1;
    timeStunned += deltaTime;
    
    if ( timeStunned >= stunDuration)
    {
      hasCharged = false;
      returnToIdle = true;
    }
  }

  public void checkGrappleCollision()
  {
    RocketArm rocketArm = powerUpManager.rocketArm;
    if((boss.position.x-rocketArm.position.x) * (boss.position.x-rocketArm.position.x) + 
      (rocketArm.position.y-boss.position.y) * (rocketArm.position.y-boss.position.y)
      <= (60+1) * (60+1))
    {
      //return grapple

      if(!rocketArm.returnGrapple && rocketArm.grapple)
      {
        rocketArm.grapple = false;
        rocketArm.targetPos.x *= -1;
        rocketArm.returnGrapple = true;  

        boss.takeDamage(grappleDamage);
      }
    }
  }

  public void chargeAtPlayer()
  {
    boss.position.x += targetPos.x * chargeSpeed * deltaTime;
    boss.position.y += targetPos.y * chargeSpeed * deltaTime;
  }

  public void checkMapBounds()
  {
    if (boss.position.x + boss.bossSize/2 >= width - 40||boss.position.x - boss.bossSize/2 <= 0 + 40 )
    {
      hasCharged = true;
      currentFrame = 0f;
      bossImpact.rewind();
      bossImpact.play();
    }
    if (boss.position.y + boss.bossSize/2 >= height - 40||boss.position.y - boss.bossSize/2 <= 0f + 40 )
    {
      hasCharged = true;
      currentFrame = 0f;
      bossImpact.rewind();
      bossImpact.play();
    }
  }

  public void returnToIdlePosition()
  {
    boss.position.x -= targetPos.x * chargeSpeed * deltaTime;
    boss.position.y -= targetPos.y * chargeSpeed * deltaTime;
    if (boss.position.y <= boss.spawnPosition.y)
    {
      boss.position.y = boss.spawnPosition.y;
      boss.SetState(new BossIdleState(this.boss));
    }
  }

  public void OnDraw()
  {
    currentFrame = (currentFrame + animationSpeed);

    //draw attacking boss
    pushMatrix();
    translate(boss.position.x - camera.shiftX, boss.position.y - camera.shiftY);

    rotate(rotation);

    if(!lockedOnPlayer)
      image(charge[PApplet.parseInt(currentFrame % chargeLength)], 0, 0);
    else if(returnToIdle)
      image(idle[PApplet.parseInt(currentFrame % shieldLength)], 0, 0);
    else if(!hasCharged)
      image(blueCharge[PApplet.parseInt(currentFrame % blueChargeLength)], 0, 0);

    else if(!returnToIdle)
    {
      image(stunned[PApplet.parseInt(currentFrame % stunnedLength)], 0, 0);
      rotate(0);
      if(!boss.hasDied && currentFrame < stunnedLength)
        image(chargeImpact[PApplet.parseInt(currentFrame % chargeImpactLength)], 0, boss.bossSize/4/*targetPos.y * boss.bossSize/4*/);
    }
    popMatrix();
  }

  public void OnStateExit()
  {

  }
}
class BossIdleState extends State
{
  Boss boss;

  float animationSpeed;
  float currentFrame;
  float bossMoveSpeed = 200;
  float playerAggroRange = 5;
  boolean movingRight;
  float moveLimit = 480;

  float laserCooldown = 3f;
  float laserCooldownCounter;

  BossIdleState(Boss boss)
  {
    this.boss = boss;
  }

  public void OnStateEnter()
  {
    animationSpeed = 0.25f;
    currentFrame = 0;

    if (boss != null)
      movingRight = boss.movingRight;
  }

  public void OnTick()
  {
    currentFrame = (currentFrame + animationSpeed) % 6;

    laserCooldown();

    if (movingRight)
    {
      boss.position.x = boss.position.x + bossMoveSpeed * deltaTime;
      if (boss.position.x >= boss.spawnPosition.x + moveLimit)
      {
        movingRight = false;
      }
    } else
    {
      boss.position.x = boss.position.x - bossMoveSpeed * deltaTime;
      if ( boss.position.x <= boss.spawnPosition.x - moveLimit)
      {
        movingRight = true;
      }
    }

    //if player is within boss aggro range
    if (abs(player.position.x - boss.position.x) <= playerAggroRange) {
      boss.SetState(new BossAttackState(this.boss));
    }
  }

  public void laserCooldown()
  {
    laserCooldownCounter += deltaTime;
    if (laserCooldownCounter >= laserCooldown)
    {
      laserCooldownCounter = 0f;
      boss.SetState(new BossLaserState(this.boss));
    }
  }

  public void OnDraw()
  {
    //draw idle animation
    pushMatrix();
    
    translate(boss.position.x - camera.shiftX, boss.position.y - camera.shiftY);
    
    image(idle[PApplet.parseInt(currentFrame)], 0, 0);
    
    popMatrix();
  }

  public void OnStateExit()
  {
    boss.movingRight = movingRight;
  }
}
class BossLaserState extends State
{
  //superclass reference
  Boss boss;

  //animation
  float animationSpeed;
  float currentFrame;

  float timeShootingLaser;
  float laserShootDuration = 6f;

  //lock on
  float lockOnTime = 1.5f;
  float lockOnProgress;
  boolean lockedOnPlayer;

  //laser
  PVector laserPlayerTrackPos;
  PVector laserEndPos;
  float laserFollowSpeed;
  int laserColor = color(175, 175, 175);
  float laserSize;
  float backLaserSize;
  boolean expanding;

  //colision
  float intersectionX, intersectionY;
  float laserHitDistance;
  PVector closestIntersection;
  boolean laserHit;

  BossLaserState(Boss boss)
  {
    this.boss = boss;
  }

  public void OnStateEnter()
  {
    animationSpeed = 0.2f;
    currentFrame = 0f;

    lockOnProgress = 0f;
    lockedOnPlayer = false;

    expanding = false;

    laserSize = 10f;
    backLaserSize = 15f;

    closestIntersection = new PVector(player.position.x, player.position.y);

    laserPlayerTrackPos = player.position.copy();

    laserEndPos = laserPlayerTrackPos.copy().sub(boss.position.copy());
    laserEndPos.normalize();
    laserEndPos.setMag(1200);
    laserEndPos.add(boss.position.copy());
  }

  public void OnTick()
  {
    if(!lockedOnPlayer)
      currentFrame = (currentFrame + animationSpeed) % 8;
    else
      currentFrame = (currentFrame + animationSpeed) % 3;

    laserTimer();

    changeLaserSize();

    //shoot laser
    if (!lockedOnPlayer)
    {
      lockOnPlayer();
      checkLaserCollision();
    } 
    else 
    {
      updateLaserPosition(5f);
      checkLaserCollision();
    }

    //after laser attack return to idle state
  }

  public void changeLaserSize()
  {
    float laserGrowthSpeed = 1.5f;
    float backLaserGrowthSpeed = 3f;

    if(expanding)
    {
      laserSize += laserGrowthSpeed;
      backLaserSize += backLaserGrowthSpeed;
    }
    else
    {
      laserSize -= laserGrowthSpeed;
      backLaserSize -= backLaserGrowthSpeed;
    }
    
    if(laserSize > 12.5f)
      expanding = false;
    else if(laserSize < 7.5f)
      expanding = true;
  }

  public void laserTimer()
  {
    timeShootingLaser += deltaTime;
    if (timeShootingLaser >= laserShootDuration)
    {
      boss.SetState(new BossIdleState(this.boss));
    }
  }

  public void lockOnPlayer()
  {
    //handle timer for locking on the player
    lockOnProgress += deltaTime;
    if ( lockOnProgress >= lockOnTime)
    {
      laserColor = color(255, 0, 0);
      lockedOnPlayer = true;
      currentFrame = 0;
      laserFireSound.rewind();
      laserFireSound.play();
    }

    updateLaserPosition(4f);
  }

  public void updateLaserPosition(float laserSpeed)
  {
    laserFollowSpeed = laserSpeed;
    laserPlayerTrackPos.x = lerp(laserPlayerTrackPos.x, player.position.x, laserFollowSpeed * deltaTime);
    laserPlayerTrackPos.y = lerp(laserPlayerTrackPos.y, player.position.y, laserFollowSpeed * deltaTime);

    laserEndPos = laserPlayerTrackPos.copy().sub(boss.position.copy());
    laserEndPos.normalize();
    laserEndPos.setMag(1200);
    laserEndPos.add(boss.position.copy());
  }

  public void checkLaserCollision()
  {
    laserHitDistance = MAX_FLOAT;
    checkBoxCollision();
    if(lockedOnPlayer)
      checkPlayerCollision();
  }

  public void checkBoxCollision()
  {
    for(int i = 0; i < boxManager.rows; i++)
    {
      for(int j = 0; j < boxManager.columns; j++)
      {
        if(boxManager.boxes[i][j].collides == 1)
        {
          //check if the laser hits a block that collides
          laserHit = lineRect(laserEndPos.x, laserEndPos.y, boss.position.x, boss.position.y, 
                boxManager.boxes[i][j].position.x-20f, boxManager.boxes[i][j].position.y-20f, 40f, 40f);
          
          if(laserHit)
            saveClosestIntersection();
        }
      }
    }
  }

  public void checkPlayerCollision()
  {
    if(lineRect(closestIntersection.x, closestIntersection.y, boss.position.x, boss.position.y, 
                player.position.x-15f, player.position.y-15f, 30f, 50f))
    {
      menu.currentSel = 0;
      menu.createDied();
      menu.menuState = 0;
      isMenu = true;
    }
  }

  public void saveClosestIntersection()
  {
    //check if the block that is hit is closer than the previously hit block(s)
    if(boss.position.dist(new PVector(intersectionX, intersectionY)) < laserHitDistance)
    {
      //save the new closest intersection point
      closestIntersection = new PVector(intersectionX, intersectionY);
      //save the new closest laserHitDistance
      laserHitDistance = boss.position.dist(closestIntersection);
    }
  }

  // LINE/RECTANGLE
  public boolean lineRect(float x1, float y1, float x2, float y2, float rx, float ry, float rw, float rh) 
  {
    boolean checkingBoxCollision;
    if(rh == 40)
      checkingBoxCollision = true;
    else
      checkingBoxCollision = false;

    //when checking collision with a new box reset the intersection 
    //variables to a very high number
    intersectionX = MAX_FLOAT;
    intersectionY = MAX_FLOAT;

    // check if the line has hit any of the rectangle's sides
    // uses the Line/Line function below
    boolean top =    lineLine(x1,y1,x2,y2, rx,ry, rx+rw,ry);
    if(checkingBoxCollision)
      saveClosestIntersection();
    boolean left =   lineLine(x1,y1,x2,y2, rx,ry,rx, ry+rh);
    if(checkingBoxCollision)
      saveClosestIntersection();
    boolean right =  lineLine(x1,y1,x2,y2, rx+rw,ry, rx+rw,ry+rh);

    if(top || left || right)
      return true;

    return false;
  }

  // LINE/LINE
  public boolean lineLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) 
  {
    // calculate the direction of the lines
    float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

    // if uA and uB are between 0-1, lines are colliding
    if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) 
    {
      //if the intersection with the current side of the rect is closer to the laser origin
      //than the previously saved intersection, store these coordinates as the new closest intersection
      if(x1 + (uA * (x2-x1)) < intersectionX && y1 + (uA * (y2-y1)) < intersectionY)
      {
        if(boss.position.dist(new PVector(x1 + (uA * (x2-x1)), y1 + (uA * (y2-y1)))) < laserHitDistance)
        {
          intersectionX = x1 + (uA * (x2-x1));
          intersectionY = y1 + (uA * (y2-y1));    
        }
      }

      return true;
    }
    return false;
  }

  public void OnDraw()
  {
    //draw movement animation
    pushMatrix();

    translate(boss.position.x/* - camera.shiftX*/, boss.position.y/* - camera.shiftY*/);

    if(!lockedOnPlayer)
      image(laserCharge[PApplet.parseInt(currentFrame)], 0, 0);
    else
      image(laserFire[PApplet.parseInt(currentFrame)], 0, 0);

    popMatrix();
    
    stroke(laserColor);
    
    //draw Laser
    strokeWeight(laserSize);
    line(boss.position.x, boss.position.y, closestIntersection.x, closestIntersection.y);
    
    stroke(laserColor, 100);
    strokeWeight(backLaserSize);
    line(boss.position.x, boss.position.y, closestIntersection.x, closestIntersection.y);
  }

  public void OnStateExit()
  {
  }
}
class BossMoveState extends State
{
  float animationSpeed;
  float currentFrame;

  public void OnStateEnter()
  {
    animationSpeed = 0.05f;
    currentFrame = 0;
  }

  public void OnTick()
  {
    currentFrame = (currentFrame + animationSpeed) % 2;

    //move boss

    //if player is within attack range
    //SetState(new BossAttackState());
  }

  public void OnDraw()
  {
    //draw movement animation
    pushMatrix();
    translate(boss.position.x/* - camera.shiftX*/, boss.position.y/* - camera.shiftY*/);
    image(bossSprite, 0, 0);
    if (boss.currentDirection == boss.RIGHT)
    {
      //image(boss.run[int(currentFrame)], 0, 0);
    } else if (boss.currentDirection == boss.LEFT)
    {
      pushMatrix();
      scale(-1.0f, 1.0f);
      //image(boss.run[int(currentFrame)], 0, 0);
      popMatrix();
    }
    popMatrix();
  }

  public void OnStateExit()
  {
  }
}
class Box extends Rectangle
{

  //----------Box properties----------
  float size;
  int groundColor = color(255);

  //----------Position----------
  PVector position;
  float top, bottom, right, left;
  float yOffset = 0;
  float xOffset = 0;

  float animationSpeed = 0.19f;
  float currentImage;

  //----------Other----------
  int collides;
  int foreCollides;
  int dist = 20;
  PImage type;
  PImage subtype = tileBox;

  float timer = random(100,1000);

  boolean switched = false;

  Box(PVector position, float size, boolean foreground,int collide)
  {
    this.name = "Box";
    this.position = position.copy();
    this.size = size;
    this.rectWidth = size;
    this.rectHeight = size;
    if(!foreground)
    collides = collide;
    else foreCollides = collide;
    SetPosValues();
    if(collides == 3){player.position.x = position.x;player.position.y = position.y-15;}
    if(!foreground)
      createBox();
    else
      createForegroundBox();
  }


  public void SetPosValues()
  {
    //save the top, bottom, left and right positions for collision detection
    top = position.y - size/2;
    bottom = top + size;
    right = position.x + size/2;
    left = right - size;
  }

  //all protected methods are from the Rectangle super class
  //these are used for collision detection
  protected String getName() {
    return name;
  }

  protected float getX()
  {
    return position.x;
  }

  protected float getY()
  {
    return position.y;
  }

  protected float getSize() {
    return size;
  }

  protected float getTop() {
    return top;
  }

  protected float getBottom() {
    return bottom;
  }

  protected float getLeft() {
    return left;
  }

  protected float getRight() {
    return right;
  }
  protected int getCollides() {
    return collides;
  }  
  protected Box getBox() {
    return this;
  }    



  public void CheckCollision()
  {
    //if the player is within a box
    if(position.x + size/2 > player.position.x - player.playerWidth/2 &&
       position.x - size/2 < player.position.x + player.playerWidth/2 &&
       position.y + size/2 > player.position.y - player.playerHeight/2 &&
       position.y - size/2 < player.position.y + player.playerHeight/2)
       {
          //handle collision in the player class, pass *this* (instance of the box class) to the method
          //the method uses the protected methods to above to get the box position variables
          player.GetCollisionDirection(this);
       }

  }
  public void CheckCollisionTop()
  {
    if(position.x + 10 > player.position.x - player.playerWidth/2 &&
       position.x - 10 < player.position.x + player.playerWidth/2 &&
       position.y + 10 > player.position.y - player.playerHeight/2 &&
       position.y - size/2 < player.position.y + player.playerHeight/2)
       {

          //handle collision in the player class, pass *this* (instance of the box class) to the method
          //the method uses the protected methods to above to get the box position variables
          player.GetCollisionDirection(this);
       }

  }
  public void CheckLadderCollision()
  {
    if(input.isUp || input.isDown || player.isClimbing)
      if(position.x + size/2 > player.position.x - player.playerWidth/2 &&
         position.x - size/2 < player.position.x + player.playerWidth/2 &&
         position.y + size/2 > player.position.y - player.playerHeight/2 &&
         position.y - size/2 < player.position.y + player.playerHeight/2)
         {
           player.isClimbing = true;
         }
  }    
  public void CheckCollisionInvis()
  {
    if(position.x + size/2 > player.position.x - player.playerWidth*1.5f &&
       position.x - size/2 < player.position.x + player.playerWidth*1.5f &&
       position.y + size/2 > player.position.y - player.playerHeight &&
       position.y - size/2 < player.position.y + player.playerHeight)
       {
        if(foreCollides == 2){
         // println("oh");
          tint(255,100);
        }

       }
    else
    {
      if(foreCollides == 2){
         // println("oh");
         tint(255,255);
      }
    }

  }
  public void CheckCollisionSwitch()
  {
    if(position.x + size/2 > player.position.x - player.playerWidth/2 &&
       position.x - size/2 < player.position.x + player.playerWidth/2 &&
       position.y + size/2 > player.position.y - player.playerHeight/2 &&
       position.y - size/2 < player.position.y + player.playerHeight/2)
    {    
      if(collides == 8 && !switched){
        switched = true;
        type = switch1;
        loop:
        for (int j = 0; j < boxManager.columns; j++)
        {
          for (int i = 0; i < boxManager.rows; i++)
          { 
            if(boxManager.foreground[i][j].foreCollides == 4)
            {  
              boxManager.currentGrid = j;
              println(boxManager.currentGrid);
              break loop;
            }   
          }
        }    
        
        boxManager.updateGridTrue = true;
        interactionsound.rewind();
        interactionsound.play();  
        boxManager.focusWater();      
      }
    }    
  }

  public void CheckCollisionNext()
  {
    if(position.x + 80/2 > player.position.x - player.playerWidth/2 &&
       position.x - 80/2 < player.position.x + player.playerWidth/2 &&
       position.y + 80/2 > player.position.y - player.playerHeight/2 &&
       position.y - 80/2 < player.position.y + player.playerHeight/2)
       {
          if(type == exitDoor)
          {
            menu.currentSel = 0;
            menu.createEndLevel();
            menu.menuState = 0;
            isMenu = true;
            highscore.checkHighscore();
          }
       }
  }

  public void killPlayer()
  {
    if(position.x + size/2 > player.position.x - player.playerWidth/2 &&
       position.x - size/2 < player.position.x + player.playerWidth/2 &&
       position.y + size/2 > player.position.y - player.playerHeight/2 &&
       position.y - size/2 < player.position.y + player.playerHeight/2)
    {    
      menu.currentSel = 0;
      menu.createDied();
      menu.menuState = 0;
      isMenu = true;
      gameManager.currencyValues[3]++;
    }        
  }

  public void createBox()
  {
    if (collides != 0)
    {
      switch(collides)
      {
        case 1:
          type = tileBox;
          break;
        case 2:
          type = deathOrb;
          break;
        case 3:
          type =enterDoor;
          yOffset = -20;
          size = 80;          
          break;
        case 4:
          type = exitDoor;
          yOffset = -20;
          size = 80;
          break;
        case 5:
          type = tileSteelPillar;
          break;            
        // case 7:
        //   fill(150,150,150);
        //   rect(0, 0, size, size);
        //   break;
        case 8:
          type = switch0;
          break;

        case 10:
          type =tileSmallPlatformTopRight; 
          break;
        case 11:
          type =tileSmallPlatformPillarRight; 
          break;
        case 12:
          type = tileSmallPlatformTopLeft; 
          break;
        case 13:
          type = tileSmallPlatformPillarLeft; 
          break;
        case 14:
          type = tileMiniPlatformTop; 
          break;
        case 15:
          type = steelPlatformLeft;
          break;
        case 16:
          type = steelPlatformMiddle;
          break;
        case 17:
          type = steelPlatformRight;
          break;          
        case 18:
          type = steelPlatformMiddle2;
          break; 
        case 19:
          type = tileSteelPillar;
          break;    
        case 20:
          type = hookMiddle;
          break;    
        case 21:
          type = hookTop;
          break;  
        case 24:
          type = tutorialA;
          size = 80;
          break;
        case 25:
          type = tutorialD;
          size = 80;
          break;
        case 26:
          type = tutorialLadderW;
          size = 80;
          break;
        case 27:
          type = tutorialW;
          size = 80;
          break;
        case 28:
          type = tutorialK;
          size = 80;
          break;
        case 29:
          type = tutorialL;
          size = 80;
          break;
        case 30:
          type = tutorialX;
          size = 80;
          break;
        case 31:
          type = tutorialZ;
          size = 80;
          break;
        case 32:
          type = tutorialLadderS;
          size = 80;
          break;                                                  
        case 33:
          type = tutorialDeath;
          size = 80;
          break;
        case 34:
          type = tutorialSecret;
          size = 80;
          break;
        case 35:
          type = tutorialEnd;
          size = 80;
          break;                      
        // case 34:
        //   image(wireStart;
        //   break;  
        case 36:
          type = wireHeel;
          break;  
        case 37:
          type = wireHeel2;
          break;
        case 38:
          type = wireCompleet;
          break;  
        case 39:
          type = wireStartBroken;
          break;  
        case 40:
          type = wireHeelBroken;
          break;
        case 41:
          type = wireHeel2Broken;
          break;          
        case 42:
          type = wireCompleetBroken;
          break;
        case 50:
          fill(groundColor);
          rect(0,0,size,size);
          break;                                                                                                                              
        }        
    } 
  }
public void createForegroundBox()
  {
    if (foreCollides != 0)
    {
      switch(foreCollides)
      {
        case 2:
          type = tileBox;
          break;
        case 3:
          type = water0; 
          break;  
        case 4:
          type = water0;
          break; 
        case 5:
          type = overgrownLeft;
          break;
        case 6:
          type = overgrownMiddle;
          break;
        case 7:
          type = overgrownRight;
          break; 
        case 8:
          type = ladder;
          //CheckLadderCollision();
          break;    


      }               
    } 
  } 

  public void Draw()
  {
    if (type != null)
    {
      if (foreCollides == 2)
        CheckCollisionInvis();  

      pushMatrix();
      stroke(0);
      strokeWeight(2);
      noStroke();      

      translate(position.x  - camera.shiftX, position.y  - camera.shiftY);
      if (type == tileBox || type == water0)
        image(subtype, xOffset, yOffset, size, size);
      else if (type == deathOrb) {
        currentImage = (currentImage + animationSpeed) % electricOrbPurple.length;
        image(electricOrbPurple[PApplet.parseInt(currentImage)], xOffset, yOffset,size,size);
      }
      else
        image(type, xOffset, yOffset, size, size);
      noTint();
      popMatrix();


      if (type == deathOrb || type == water0)
          killPlayer();
      if (type == exitDoor)
          CheckCollisionNext();
      if (type == switch0)
          CheckCollisionSwitch();
    }
  }

}
class BoxManager
{
  //----------Properties----------
  float boxSize = 40;
  int rows = 32;
  int columns = 18;
  int level;

  //----------Arrays and lists----------
  Box[][] boxes = new Box[rows][columns];
  Box[][] foreground = new Box[rows][columns];
  
  //----------Surrounding boxes----------
  ArrayList<Box> over = new ArrayList<Box>();
  ArrayList<Box> foreOver = new ArrayList<Box>();
  ArrayList<Box> surrounding = new ArrayList<Box>();
  Box bottomBox;
  Box bottomRightBox;
  Box bottomLeftBox;

  //----------Current player location----------
  int[] xTile = new int[6];
  int[] yTile = new int[6];
  int xBottom, yBottom;
  int[] xEnemyTile = new int[50];
  int[] yEnemyTile = new int[50];  

  Box boxTop;
  Box boxBottom;
  Box boxRight;
  Box boxLeft;
  Box boxTopLeft;
  Box boxTopRight;
  Box boxBottomLeft;
  Box boxBottomRight;

  //----------Other----------
  boolean updateGridTrue;
  boolean updateCameraFocus;
  boolean returnCam = false;
  float prog = 0;
  int currentGrid;
  int updateTime = 4;

  BoxManager(int level)
  {    //enemy = new Enemy(width/2, height-60);
    counter = 0;
    loadingTime = 1;
    gameManager.resetValues();
    powerUpManager = new PowerUpManager();
    this.level = level;

    //Clear arraylists
    anchors.clear();  
    enemies.clear();
    coins.clear();
    magnet.clear();
    bullet.clear();
    particle.clear();
    lasers.clear();
    boss = null;
    checkPointManager.checkPoints.clear();
    checkPointManager.amountOfCheckPoints = 0;

    if(levelmusic != null)
      levelmusic.pause();

    map = loadImage("level"+level+".png");
    foregroundImage = loadImage("foreground"+level+".png");

    if(map == null)
    {
      menu.level.selectedLevel--;
      isMenu = true;
      mainMusic.rewind();
      mainMusic.play();
      if(levelmusic != null)
      levelmusic.pause();
      return;
    }

    rows = map.width;
    columns = map.height;

    player.velocity = new PVector(0, 0);

    //fill 2 dimensional array with Box-objects
    boxes = new Box[rows][columns];
    foreground = new Box[rows][columns];
    camera.shiftX = 0;
    camera.shiftY = 0;
    if(levelmusic != null && currentLevel != 9)
    levelmusic.loop();
        
    //select the boxes that the tileBox collides with
    PlaceCollisionBoxes();  
    CheckSurroundingBoxes();

    checkPointManager.restoreCheckPoints();

    if(gameManager.furthestCheckPoint > 0){
      player.position.x = checkPointManager.checkPoints.get(gameManager.furthestCheckPoint-1).position.x;
      player.position.y = checkPointManager.checkPoints.get(gameManager.furthestCheckPoint-1).position.y;
    }    
  }

  public void PlaceCollisionBoxes()
  {



    
for(int i = 0; i < rows; i++)
      {
        for(int j = 0; j < columns; j++)
        {
          int coll = 0;
          int p = i + (j * rows);
          if(map.pixels[p] == color(0,0,0)){
            coll = 1;
          }
          else if(map.pixels[p] == color(255,100,0)){
            coll = 2;
          }
          else if(map.pixels[p] == color(0,255,0)){
            coll = 3;
          }
          else if(map.pixels[p] == color(255,255,0)){
            coll = 4;
          }
          //steel pillar col 
          else if(map.pixels[p] == color(0,0,1)){
            coll = 5;
          }          
          else if(map.pixels[p] == color(255,255,100)){
            coll = 8;
          }
          //small platform top right
          else if(map.pixels[p] == color(0,5,0)){
            coll = 10;
          }
          //small platform pillar right
          else if(map.pixels[p] == color(0,10,0)){
            coll = 11;
          }
          //small platform top left
          else if(map.pixels[p] == color(5,0,0)){
            coll = 12;
          }
          //small platform pillar right
          else if(map.pixels[p] == color(10,0,0)){
            coll = 13;
          }
          //mini platform top
          else if(map.pixels[p] == color(0,0,5)){
            coll = 14;
          }
          //steel platform left
          else if(map.pixels[p] == color(20,10,0)){
            coll = 15;
          }
          //steel platform middle
          else if(map.pixels[p] == color(25,0,0)){
            coll = 16;
            int rand = ceil(random(0, 5));
            if(rand == 5)
            {
              foregroundImage.pixels[p] = color(0,25,0);
              foregroundImage.pixels[p+1] = color(0,30,0);
              foregroundImage.pixels[p-1] = color(0,20,0);
            }
          }
          //steel platform right
          else if(map.pixels[p] == color(20,0,10)){
            coll = 17;
          }
          //steel platform middle 2
          else if(map.pixels[p] == color(30,0,0)){
            coll = 18;
          }
          //steel pillar
          else if(map.pixels[p] == color(20,0,0)){
            coll = 19;
          }
          //hook middle
          else if(map.pixels[p] == color(100,0,0)){
            coll = 20;
          }
          //hook top
          else if(map.pixels[p] == color(110,0,0)){
            coll = 21;
          }

          //Invisible hitboxes enemy
          else if(map.pixels[p] == color(220,0,0)){
            coll = 22;
          }
          //Ladder      
          //Tutorial stuff
          else if(map.pixels[p] == color(0,55,0)){
            coll = 24;
          }     

          else if(map.pixels[p] == color(0,60,0)){
            coll = 25;
          }     

          else if(map.pixels[p] == color(0,65,0)){
            coll = 26;
          }     

          else if(map.pixels[p] == color(0,70,0)){
            coll = 27;
          }     

          else if(map.pixels[p] == color(0,75,0)){
            coll = 28;
          }      

          else if(map.pixels[p] == color(0,80,0)){
            coll = 29;
          }    

          else if(map.pixels[p] == color(0,85,0)){
            coll = 30;
          }    

          else if(map.pixels[p] == color(0,90,0)){
            coll = 31;
          }    

          else if(map.pixels[p] == color(0,95,0)){
            coll = 32;
          }    

          else if(map.pixels[p] == color(0,100,0)){
            coll = 33;
          }   
          else if(map.pixels[p] == color(0,105,0)){
            coll = 34;
          } 
          else if(map.pixels[p] == color(0,110,0)){
            coll = 35;
          }           
          //Wires
          // else if(map.pixels[p] == color(255,100,0)){
          //   coll = 34;
          // }                       
          else if(map.pixels[p] == color(255,100,5)){
            coll = 36;
          }                       
          else if(map.pixels[p] == color(255,100,10)){
            coll = 37;
          }                       
          else if(map.pixels[p] == color(255,100,15)){
            coll = 38;
          }                       
          else if(map.pixels[p] == color(255,100,20)){
            coll = 39;
          }                       
          else if(map.pixels[p] == color(255,100,25)){
            coll = 40;
          }                       
          else if(map.pixels[p] == color(255,100,30)){
            coll = 41;
          }                       
          else if(map.pixels[p] == color(255,100,35)){
            coll = 42;
          }    


          //Powerup Spawns
          else if(map.pixels[p] == color(100,255,255)){
            anchors.add(new Anchor(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j)));
          }
          else if(map.pixels[p] == color(244,0,0)){
            powerUpManager.rocketArm = new RocketArm(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j));
          }         
          else if(map.pixels[p] == color(243,0,0)){
            powerUpManager.rocketJump = new RocketJump(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j));
          } 
          else if(map.pixels[p] == color(240,0,0)){
            powerUpManager.fuels.add(new Fuel(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j)));
          }
          else if(map.pixels[p] == color(241,0,0)){
            coins.add(new Currency(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j), "norm"));
          }    
          else if(map.pixels[p] == color(242,0,0)){
            coins.add(new Currency(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j), "gold"));
          }               

          //Enemy spawn         
          else if(map.pixels[p] == color(255,0,0)){
            enemies.add(new Enemy(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j,0));
          }         
          //shooting enemy
          else if(map.pixels[p] == color(250,0,0)){
            enemies.add(new Enemy(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j,1));
          }  
          //plant enemy
          else if(map.pixels[p] == color(251,0,0)){
            enemies.add(new Enemy(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j,2));
          }     
          //shooting plant enemy
          else if(map.pixels[p] == color(252,0,0)){
            enemies.add(new Enemy(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j,3));
          }                                                
          else if(map.pixels[p] == color(253,0,0)){
            enemies.add(new Enemy(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j,4));
          }                                                
          else if(map.pixels[p] == color(254,0,0)){
            enemies.add(new Enemy(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j,5));
          }                                                
          else if(map.pixels[p] == color(240,230,0)){
            //Laser(PVector pos, float minAngle, float maxAngle, float speed, float length, int dir)
            lasers.add(new Laser(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j), -180, 0, 75f, 200f, 1));
          }

          //Magnet down spawn
          else if(map.pixels[p] == color(152,152,152)){
            magnet.add(new Magnet(DOWN,new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j)));
          }
          //Magnet up spawn
          else if(map.pixels[p] == color(150,150,150)){
            magnet.add(new Magnet(UP,new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j)));
          }          
          //Magnet right spawn
          else if(map.pixels[p] == color(151,151,151)){
            magnet.add(new Magnet(RIGHT,new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j)));
          }
          //Magnet left spawn
          else if(map.pixels[p] == color(153,153,153)){
            magnet.add(new Magnet(LEFT,new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j)));
          }  
          else if(map.pixels[p] == color(225,0,0)){
            boss = new Boss(new PVector(width/2, height/2));
          }    
          else if(map.pixels[p] == color(0,200,0)){
            checkPointManager.checkPoints.add(new CheckPoint(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j), 1));
          }
          else if(map.pixels[p] == color(0,201,0)){
            checkPointManager.checkPoints.add(new CheckPoint(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j), 2));
          }
          else if(map.pixels[p] == color(0,202,0)){
            checkPointManager.checkPoints.add(new CheckPoint(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j), 3));
          }
          else if(map.pixels[p] == color(0,203,0)){
            checkPointManager.checkPoints.add(new CheckPoint(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j), 4));
          }
          else if(map.pixels[p] == color(0,204,0)){
            checkPointManager.checkPoints.add(new CheckPoint(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j), 5));
          }

          boxes[i][j] = new Box(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j), boxSize, false, coll);

        }
      }
  if(foregroundImage != null)
  {
    for(int i = 0; i < rows; i++)
    {
      for(int j = 0; j < columns; j++)
      {
        int coll = 0;
        int p = i + (j * rows);
        if(foregroundImage.pixels[p] == color(0,0,0)){
          coll = 1;
        }
        if(foregroundImage.pixels[p] == color(0,160,255)){
          coll = 2;
        }  
        if(foregroundImage.pixels[p] == color(0,0,255)){
          coll = 3;
        }           
        if(foregroundImage.pixels[p] == color(0,0,100)){
          coll = 4;
        }      
        if(foregroundImage.pixels[p] == color(0,20,0)){
          coll = 5;
        }   
        if(foregroundImage.pixels[p] == color(0,25,0)){
          coll = 6;
        }   
        if(foregroundImage.pixels[p] == color(0,30,0)){
          coll = 7;
        }        
        if(foregroundImage.pixels[p] == color(0,255,255)){
          coll = 8;
        }                                     
        foreground[i][j] = new Box(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j), boxSize, true, coll);
      }
    }
  }
  }  
  public void CheckSurroundingBoxes()
  {

    for(int i = 0; i < rows; i++)
    {
      for(int j = 0; j < columns; j++)
      {
        if (foreground[i][j].type == water0)
        {
          if ((foreground[i][j-1].type == water0 || boxes[i][j-1].type == tileBox))
              { 
                int r = round(random(0,4));
                if(r == 0)
                  foreground[i][j].subtype = underwater0;
                else
                  foreground[i][j].subtype = underwater1;
              }
          else
              foreground[i][j].subtype = water0;          
        }

        if (boxes[i][j].type == tileBox)
        {

          boxes[i][j].subtype = tileBox;

          if(i+1 >= rows && j+1 < columns && j-1 >= 0 &&
            (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
            (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
            (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox))
          {
            boxes[i][j].subtype = boxLinks;
            continue;
          }
          if(i-1 < 0 && j+1 < columns && j-1 >= 0 &&
            (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
            (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
            (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox))
          {
            boxes[i][j].subtype = boxRechts;
            continue;
          }          
          if(j-1 < 0 && i+1 < rows && i-1 >= 0 &&
            (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox) &&
            (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
            (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox))
          {
            boxes[i][j].subtype = boxOmlaag;
            continue;
          }    
          if(j+1 >= columns && i+1 < rows && i-1 >= 0 &&
            (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
            (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
            (boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox))
          {
            boxes[i][j].subtype = boxOmhoog;
            continue;
          }            
          if(i-1 < 0 && j+1 < columns && j-1 >= 0 &&
            (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
            (boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
            (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
            (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
            (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox))
          {
            boxes[i][j].subtype = box2CornerRechts;
            continue;
          } 

          if(i-1 < 0 && j+1 >= columns &&
            (boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
            (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
            (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox))
          {
            boxes[i][j].subtype = boxCornerPointRechtsBoven;
            continue;
          }     
          if(i-1 < 0 && j+1 < columns && j-1 >= 0 &&
            (boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
            (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
            (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox))
          {
            boxes[i][j].subtype = boxCornerPointRechtsBoven;
            continue;
          }               
          if(i+1 >= rows && j+1 >= columns &&
            (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
            (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
            (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox))
          {
            boxes[i][j].subtype = boxCornerPointLinksBoven;
            continue;
          }     
          if(i-1 < 0 && j+1 < columns && j-1 >= 0 &&
            (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
            (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
            (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox))
          {
            boxes[i][j].subtype = boxCornerPointRechtsOnder;
            continue;
          }     

          if(i+1 < rows && i-1 >= 0 && j+1 >= columns &&
            (boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
            (boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
            (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
            (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox))
          {
            boxes[i][j].subtype = boxCornerRechtsBoven;
            continue;
          }     
          if(i+1 < rows && i-1 >= 0 && j+1 >= columns &&
            (boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
            (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
            (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
            (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox))
          {
            boxes[i][j].subtype = boxCornerPointRechtsBoven;
            continue;
          }      
          if(i+1 < rows && i-1 >= 0 && j+1 >= columns &&
            (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
            (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
            (boxes[i+1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
            (boxes[i-1][j].type == tileBox || foreground[i+1][j].type == tileBox))
          {
            boxes[i][j].subtype = boxCornerPointLinksBoven;
            continue;
          }                      
          if(i+1 < rows && i-1 >= 0 && j+1 >= columns &&
            (boxes[i-1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
            (boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
            (boxes[i-1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
            (boxes[i+1][j].type == tileBox || foreground[i-1][j].type == tileBox))
          {
            boxes[i][j].subtype = boxCornerLinksBoven;
            continue;
          }              
          if(i+1 >= rows && j+1 >= columns &&
            (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
            (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
            (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox))
          {
            boxes[i][j].subtype = boxCornerPointLinksBoven;
            continue;
          }                                              
          if(i+1 >= rows && j+1 < columns && j-1 >= 0 &&
            (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox) &&
            (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
            (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
            (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
            (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox))
          {
            boxes[i][j].subtype = box2CornerLinks;
            continue;
          }                                             

          if(i+1 >= rows ||
            i-1 < 0 ||
            j+1 >= columns ||
            j-1 < 0)
          {
            continue;
          }
          //37 X
          if ((boxes[i+1][j+1].type == tileBox || foreground[i+1][j+1].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type == tileBox || foreground[i-1][j+1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j-1].type == tileBox || foreground[i+1][j-1].type == tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type == tileBox || foreground[i-1][j-1].type == tileBox))
                boxes[i][j].subtype = tileBox;
          if ((boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox) &&
              (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
              (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
              (boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox))
                boxes[i][j].subtype = tileBox;              
              //----------------------------------
          else if ((boxes[i+1][j-1].type == tileBox || foreground[i+1][j-1].type == tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                boxes[i][j].subtype = box3CornerNietRechtsBoven;
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type == tileBox || foreground[i-1][j-1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                boxes[i][j].subtype = box3CornerNietLinksBoven;
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type == tileBox || foreground[i+1][j+1].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                boxes[i][j].subtype = box3CornerNietRechtsOnder;        
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type == tileBox || foreground[i-1][j+1].type == tileBox))
                boxes[i][j].subtype = box3CornerNietLinksOnder; 
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                boxes[i][j].subtype = box4Corner;  
              //---------------------------------------
          else if ((boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                boxes[i][j].subtype = box2CornerLinksOnderRechtsOnderLaagBoven;               
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                boxes[i][j].subtype = boxCornerRechtsOnderLaagLinks; 
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox))
                boxes[i][j].subtype = boxCornerRechtsBovenLaagOnder; 
          else if ((boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox))
                boxes[i][j].subtype = boxCornerLinksBovenLaagOnder;               
          else if ((boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                boxes[i][j].subtype = boxCornerLinksOnderLaagBoven; 
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox))
                boxes[i][j].subtype = boxCornerLinksBovenLaagOnder; 
          else if ((boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox))
                boxes[i][j].subtype = boxCornerRechtsOnderLaagBoven;                                
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                boxes[i][j].subtype = boxCornerLinksBovenLaagRechts;   
               
              //-----------------------------------------
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox))
                boxes[i][j].subtype = boxCornerLinksBovenLaagRechtsLaagOnder; 
          else if ((boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                boxes[i][j].subtype = boxCornerLinksOnderLaagRechtsLaagBoven; 
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox))
                boxes[i][j].subtype = boxCornerRechtsBovenLaaglinksLaagOnder; 
          else if ((boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                boxes[i][j].subtype = boxCornerRechtsOnderLaaglinksLaagBoven;     
              //-------------------------------------------                                                                                                                                                                  
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
              (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                boxes[i][j].subtype = box3PointDown;  
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
              (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                boxes[i][j].subtype = box3PointUp;  
          else if ((boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                boxes[i][j].subtype = box3PointLeft;  
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox))
                boxes[i][j].subtype = box3PointRight;   
              //--------------------------------------------   
          else if ((boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox))
                boxes[i][j].subtype = box2LaagZijwaards;
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
              (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                boxes[i][j].subtype = box2LaagVerticaal;
              //--------------------------------------------  
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                boxes[i][j].subtype = box2CornerBoven;   
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                boxes[i][j].subtype = box2CornerOnder;   
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                boxes[i][j].subtype = box2CornerLinks;   
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                boxes[i][j].subtype = box2CornerRechts;   
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                boxes[i][j].subtype = box2CornerRechtsBovenLinksOnder;   
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                boxes[i][j].subtype = box2CornerRechtsOnderLinksBoven; 
              //--------------------------------------------
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                boxes[i][j].subtype = boxCornerPointLinksOnder; 
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                boxes[i][j].subtype = boxCornerPointLinksBoven; 
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                boxes[i][j].subtype = boxCornerPointRechtsOnder; 
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                boxes[i][j].subtype = boxCornerPointRechtsBoven;  
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox))
                boxes[i][j].subtype = boxCornerRechtsOnder; 
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                boxes[i][j].subtype = boxCornerRechtsBoven; 
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                boxes[i][j].subtype = boxCornerLinksOnder; 
          else if ((boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                boxes[i][j].subtype = boxCornerLinksBoven;    
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                boxes[i][j].subtype = boxRechts; 
          else if ((boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox))
                boxes[i][j].subtype = boxOmlaag; 
          else if ((boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox))
                boxes[i][j].subtype = boxOmhoog; 
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                boxes[i][j].subtype = boxLinks;                                                                                                                                                                                                                                                                                     
        }

        if (foreground[i][j].type == tileBox)
        {

          foreground[i][j].subtype = tileBox;

          if(i+1 >= rows && j+1 < columns && j-1 >= 0 &&
            (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
            (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
            (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox))
          {
            foreground[i][j].subtype = boxLinks;
            continue;
          }
          if(i-1 < 0 && j+1 < columns && j-1 >= 0 &&
            (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
            (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
            (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox))
          {
            foreground[i][j].subtype = boxRechts;
            continue;
          }          
          if(j-1 < 0 && i+1 < rows && i-1 >= 0 &&
            (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox) &&
            (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
            (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox))
          {
            foreground[i][j].subtype = boxOmlaag;
            continue;
          }    
          if(j+1 >= columns && i+1 < rows && i-1 >= 0 &&
            (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
            (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
            (boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox))
          {
            foreground[i][j].subtype = boxOmhoog;
            continue;
          }  
          if(i-1 < 0 && j+1 < columns && j-1 >= 0 &&
            (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
            (boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
            (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
            (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
            (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox))
          {
            foreground[i][j].subtype = box2CornerRechts;
            continue;
          } 
          if(i-1 < 0 && j+1 < columns && j-1 >= 0 &&
            (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
            (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
            (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
            (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox))
          {
            foreground[i][j].subtype = boxCornerPointRechtsOnder;
            continue;
          }               
          if(i-1 < 0 && j+1 < columns && j-1 >= 0 &&
            (boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
            (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
            (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
            (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox))
          {
            foreground[i][j].subtype = boxCornerPointRechtsBoven;
            continue;
          }                         
          if(i+1 >= rows && j+1 < columns && j-1 >= 0 &&
            (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox) &&
            (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
            (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
            (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
            (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox))
          {
            foreground[i][j].subtype = box2CornerLinks;
            continue;
          }                                             

          if(i+1 >= rows ||
            i-1 < 0 ||
            j+1 >= columns ||
            j-1 < 0)
          {
            continue;
          }
          //37 X
          if ((boxes[i+1][j+1].type == tileBox || foreground[i+1][j+1].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type == tileBox || foreground[i-1][j+1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j-1].type == tileBox || foreground[i+1][j-1].type == tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type == tileBox || foreground[i-1][j-1].type == tileBox))
                foreground[i][j].subtype = tileBox;
              //----------------------------------
          else if ((boxes[i+1][j-1].type == tileBox || foreground[i+1][j-1].type == tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                foreground[i][j].subtype = box3CornerNietRechtsBoven;
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type == tileBox || foreground[i-1][j-1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                foreground[i][j].subtype = box3CornerNietLinksBoven;
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type == tileBox || foreground[i+1][j+1].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                foreground[i][j].subtype = box3CornerNietRechtsOnder;        
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type == tileBox || foreground[i-1][j+1].type == tileBox))
                foreground[i][j].subtype = box3CornerNietLinksOnder; 
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                foreground[i][j].subtype = box4Corner;  
              //---------------------------------------
          else if ((boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                foreground[i][j].subtype = box2CornerLinksOnderRechtsOnderLaagBoven;               
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                foreground[i][j].subtype = boxCornerRechtsOnderLaagLinks; 
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox))
                foreground[i][j].subtype = boxCornerRechtsBovenLaagOnder; 
          else if ((boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox))
                foreground[i][j].subtype = boxCornerLinksBovenLaagOnder;               
          else if ((boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                foreground[i][j].subtype = boxCornerLinksOnderLaagBoven; 
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox))
                foreground[i][j].subtype = boxCornerLinksBovenLaagOnder; 
          else if ((boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox))
                foreground[i][j].subtype = boxCornerRechtsOnderLaagBoven;                                
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                foreground[i][j].subtype = boxCornerLinksBovenLaagRechts;   
               
              //-----------------------------------------
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox))
                foreground[i][j].subtype = boxCornerLinksBovenLaagRechtsLaagOnder; 
          else if ((boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                foreground[i][j].subtype = boxCornerLinksOnderLaagRechtsLaagBoven; 
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox))
                foreground[i][j].subtype = boxCornerRechtsBovenLaaglinksLaagOnder; 
          else if ((boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                foreground[i][j].subtype = boxCornerRechtsOnderLaaglinksLaagBoven;     
              //-------------------------------------------                                                                                                                                                                  
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
              (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                foreground[i][j].subtype = box3PointDown;  
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
              (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                foreground[i][j].subtype = box3PointUp;  
          else if ((boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                foreground[i][j].subtype = box3PointLeft;  
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox))
                foreground[i][j].subtype = box3PointRight;   
              //--------------------------------------------   
          else if ((boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox))
                foreground[i][j].subtype = box2LaagZijwaards;
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
              (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                foreground[i][j].subtype = box2LaagVerticaal;
              //--------------------------------------------  
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                foreground[i][j].subtype = box2CornerBoven;   
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                foreground[i][j].subtype = box2CornerOnder;   
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                foreground[i][j].subtype = box2CornerLinks;   
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                foreground[i][j].subtype = box2CornerRechts;   
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                foreground[i][j].subtype = box2CornerRechtsBovenLinksOnder;   
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                foreground[i][j].subtype = box2CornerRechtsOnderLinksBoven; 
              //--------------------------------------------
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                foreground[i][j].subtype = boxCornerPointLinksOnder; 
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                foreground[i][j].subtype = boxCornerPointLinksBoven; 
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                foreground[i][j].subtype = boxCornerPointRechtsOnder; 
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                foreground[i][j].subtype = boxCornerPointRechtsBoven;  
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j+1].type != tileBox && foreground[i+1][j+1].type != tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox))
                foreground[i][j].subtype = boxCornerRechtsOnder; 
          else if ((boxes[i+1][j-1].type != tileBox && foreground[i+1][j-1].type != tileBox) &&
              (boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                foreground[i][j].subtype = boxCornerRechtsBoven; 
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
              (boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox) &&
              (boxes[i-1][j+1].type != tileBox && foreground[i-1][j+1].type != tileBox))
                foreground[i][j].subtype = boxCornerLinksOnder; 
          else if ((boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i-1][j-1].type != tileBox && foreground[i-1][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                foreground[i][j].subtype = boxCornerLinksBoven;    
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i+1][j].type != tileBox && foreground[i+1][j].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                foreground[i][j].subtype = boxRechts; 
          else if ((boxes[i][j+1].type != tileBox && foreground[i][j+1].type != tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox))
                foreground[i][j].subtype = boxOmlaag; 
          else if ((boxes[i][j-1].type != tileBox && foreground[i][j-1].type != tileBox) &&
              (boxes[i+1][j].type == tileBox || foreground[i+1][j].type == tileBox) &&
              (boxes[i-1][j].type == tileBox || foreground[i-1][j].type == tileBox))
                foreground[i][j].subtype = boxOmhoog; 
          else if ((boxes[i][j-1].type == tileBox || foreground[i][j-1].type == tileBox) &&
              (boxes[i-1][j].type != tileBox && foreground[i-1][j].type != tileBox) &&
              (boxes[i][j+1].type == tileBox || foreground[i][j+1].type == tileBox))
                foreground[i][j].subtype = boxLinks;                                                                                                                                                                                                                                                                                                        
        }        
      }
    }
  }
  public void Update()
  {
    over = new ArrayList<Box>();
    surrounding = new ArrayList<Box>();
    foreOver = new ArrayList<Box>();
    CalculateCurrentTiles();
    SetOverCells();
    SetSurroundingCells();
    CheckEnemyCollision();    
    CheckCollisions();
    if(updateGridTrue)
      updateGrid();
    if(updateCameraFocus)
      updateFocus();

  }

  public void updateGrid()
  {
    if(updateTime == 0)
    {
      for(int j = 0; j < rows; j++)
      {
        if(foregroundImage != null)
        {
          if(foreground[j][currentGrid].foreCollides == 4){
            foreground[j][currentGrid].type = null;
          }
        }
      }
      currentGrid++;
      updateTime = 4;
    }
    updateTime--;


    if(currentGrid == columns -1)
    {
      updateGridTrue = false;
      currentGrid = 0;
    }
  }

  public void focusWater()
  {
    //Zoekt voor het eerste water blok die hij tegen komt, en zet vervolgens de coordinaten voor dat blok in een variabele die gebruikt wordt in updateFocus()
    if (rows <= 32 && columns <= 18) return;

    outerloop:
    for (int j = 0; j < columns; j++)
    {
      for (int i = 0; i < rows; i++)
      {
        if(foreground[i][j].foreCollides == 4)
        {
          if ((foreground[i][j].position.x - camera.shiftX) / width > (1 - camera.margin)){
            if(((foreground[i][j].position.x) / width - (1 - camera.margin)) * width < ((boxes[rows-1][0].position.x+boxSize/2)-width))
              camera.focusX = ((foreground[i][j].position.x) / width - (1 - camera.margin)) * width;
            else camera.focusX = ((boxes[rows-1][0].position.x+boxSize/2)-width);   
          }
          else
          {
            if(((foreground[i][j].position.x) / width - camera.margin) * width > 0)
              camera.focusX = ((foreground[i][j].position.x) / width -  camera.margin) * width;
            else camera.focusX = 0;              
          }

          if ((foreground[i][j].position.y - camera.shiftY) / height > (1 - camera.margin)){
            if(((foreground[i][j].position.y) / height - (1 - camera.margin)) * height < ((boxes[0][columns-1].position.y+boxSize/2)-height))
            camera.focusY = ((foreground[i][j].position.y) / height - (1 - camera.margin)) * height;
            else camera.focusY = ((boxes[0][columns-1].position.y+boxSize/2)-height);
          }
          else
          {
            if(((foreground[i][j].position.y) / height - camera.margin) * height > 0)
            camera.focusY = ((foreground[i][j].position.y) / height - camera.margin) * height;
            else camera.focusY = 0;
          }
            updateCameraFocus = true;
            input.enabled = false;
            player.velocity.x = 0;
            player.velocity.y = 0;
            cameraTracking = false;
            pauseWorld = true;
            break outerloop;
        }
      }
    }
  }

  public void updateFocus()
  {
    //WIP NOT DONE
    //Beweegt de camera richting de gegeven coordinaten

    camera.shiftX = lerp(camera.shiftX, camera.focusX, prog);
    camera.shiftY = lerp(camera.shiftY, camera.focusY, prog);
    if(prog < 1)
    {
      prog += 0.005f;
      //println(camera.shiftX +" "+ prog);      
    }
    else
    {
      updateCameraFocus = false;
      input.enabled = true;
      cameraTracking = true;
      pauseWorld = false;
    }


  }

  public void CalculateCurrentTiles()
  {
    //get the tiles where the corners of the player are located in
    float xPercentage, yPercentage;
    for (int i = 0; i < player.corners.length; i++)
    {
      xPercentage = player.corners[i].x / (width * ((float) rows / 32))  * 100;
      xTile[i] = floor(rows / 100f * xPercentage);     
      yPercentage = player.corners[i].y / (height * ((float) columns / 18)) * 100;
      yTile[i] = floor(columns / 100f * yPercentage);
    }
    //get the tiles underneath the player for groundCheck
    xPercentage = player.playerBottom.x / (width * ((float)rows / 32)) * 100;
    xBottom = floor(rows / 100f * xPercentage);
    yPercentage = player.playerBottom.y / (height * ((float) columns / 18)) * 100;
    yBottom = floor(columns / 100f * yPercentage);

    //get enemy tile position
    for (int i = 0; i < enemies.size(); ++i) {
      float xEnemyPercentage = enemies.get(i).x / (width * ((float) rows / 32)) * 100;
      xEnemyTile[i] = floor(rows / 100f * xEnemyPercentage);
      float yEnemyPercentage = enemies.get(i).y / (height * ((float) columns / 18)) * 100;
      yEnemyTile[i] = floor(columns / 100f * yEnemyPercentage);       
    }
   
  }

  public void SetOverCells()
  {
    //add the boxes the player is currently on top of to the over ArrayList
    for (int i = 0; i < 6; i++)
    {
      if (xTile[i] >= rows || xTile[i] <= 0);
      else if (yTile[i] >= columns || yTile[i] <= 0);
      else
      //if valid row and column
      {
        //store box in temporary box variable
        Box box = boxes[xTile[i]][yTile[i]];

        //if the box is not yet in the over ArrayList, add it
        if (!over.contains(box))
        {
          over.add(box);
        }
      }
    }
    for (int i = 0; i < 6; i++)
    {
      if (xTile[i] >= rows || xTile[i] <= 0);
      else if (yTile[i] >= columns || yTile[i] <= 0);
      else
      {
        Box box = foreground[xTile[i]][yTile[i]];

        if (!foreOver.contains(box))
        {
          foreOver.add(box);
        }
      }
    }    
  }

  public void SetSurroundingCells()
  {
    //get the boxes surrounding the player
    for (int i = 0; i < 6; i++)
    {
      //if grid cell is within the array of cells(boxes)
      if (xTile[i] >= rows || xTile[i] + 1 >= rows || xTile[i] <= 0 || xTile[i] - 1 < 0);
      else if (yTile[i] >= columns || yTile[i] + 1 >= columns || yTile[i] <= 0 || yTile[i] - 1 < 0);
      else
      {
        //set temporary box variables to the box surrounding player
         boxTop = boxes[xTile[i]][yTile[i]-1];
         boxBottom = boxes[xTile[i]][yTile[i]+1];
         boxRight = boxes[xTile[i]-1][yTile[i]];
         boxLeft = boxes[xTile[i]+1][yTile[i]];
         boxTopLeft = boxes[xTile[i]-1][yTile[i]-1];
         boxTopRight = boxes[xTile[i]+1][yTile[i]-1];
         boxBottomLeft = boxes[xTile[i]-1][yTile[i]+1];
         boxBottomRight = boxes[xTile[i]+1][yTile[i]+1];

        //if its not yet in the surrounding boxes ArrayList, add it
        if (!surrounding.contains(boxTop) && !over.contains(boxTop))
        {
          surrounding.add(boxTop);
        }
        if (!surrounding.contains(boxBottom) && !over.contains(boxBottom))
        {
          surrounding.add(boxBottom);
        }
        if (!surrounding.contains(boxRight) && !over.contains(boxRight))
        {
          surrounding.add(boxRight);
        }
        if (!surrounding.contains(boxLeft) && !over.contains(boxLeft))
        {
          surrounding.add(boxLeft);
        }

        if (!surrounding.contains(boxTopLeft) && !over.contains(boxTopLeft))
        {
          surrounding.add(boxTopLeft);
        }
        if (!surrounding.contains(boxTopRight) && !over.contains(boxTopRight))
        {
          surrounding.add(boxTopRight);
        }
        if (!surrounding.contains(boxBottomLeft) && !over.contains(boxBottomLeft))
        {
          surrounding.add(boxBottomLeft);
        }
        if (!surrounding.contains(boxBottomRight) && !over.contains(boxBottomRight))
        {
          surrounding.add(boxBottomRight);
        }
      }
    }
    if (xBottom + 1 >= rows || xBottom - 1 < 0);
    else if (yBottom + 1 >= columns || yBottom - 1 < 0);
    else
    {
      //set bottomBox to the boxes below the player
      bottomBox = boxes[xBottom][yBottom+1];
    }
  }

  public void SetGridColor()
  {
    // //background cells
    // for (int i = 0; i < rows; i++)
    // {
    //  for (int j = 0; j < columns; j++)
    //  {
    //    if(boxes[i][j].collides == 50)
    //    boxes[i][j].collides = 0;
    //  }
    // }

    // //over cells
    // for (int i = 0; i < over.size(); i++)
    // {
    //  if(over.get(i).collides == 0){
    //  over.get(i).collides = 50;
    //  over.get(i).groundColor = color(255);
    // }
    // }
  }

  public void CheckCollisions()
  {
    //check for collisions on the surrounding cells that the player can collide with
    for (int i = 0; i < surrounding.size(); i++)
    {
      //set the surrounding cells color
      surrounding.get(i).groundColor = color(150, 0, 150);
      //check for collisions
      // println(surrounding.get(i).collides);
      // println(surrounding.get(i).position.x + " " + player.position.x);      
      if (surrounding.get(i).collides == 1 ||
          surrounding.get(i).collides == 5 ||
          surrounding.get(i).collides == 15 ||
          surrounding.get(i).collides == 16 ||
          surrounding.get(i).collides == 17 ||
          surrounding.get(i).collides == 18)
        surrounding.get(i).CheckCollision();

      if (surrounding.get(i).collides == 12 ||
          surrounding.get(i).collides == 10 ||
          surrounding.get(i).collides == 14)
        surrounding.get(i).CheckCollisionTop();
    }
    for (int i = 0; i < foreOver.size(); ++i) {
      if (foreOver.get(i).foreCollides == 8)
      {
        foreOver.get(i).CheckLadderCollision();
        break;
      }
      else player.isClimbing = false;
    }
  }

  public void CheckEnemyCollision()
  {
    //check for collision left and right of the enemy
    //if there is a tiles that it collides with, it changes direction
    for (int i = 0; i < enemies.size(); ++i) {
      if(enemies.get(i) != null)
      {
        float enemyTileCenter = 20 + (xEnemyTile[i]) * 40;

        // if(i == 0)
        // println(enemyTileCenter + " " + xEnemyTile[0] + " " + yEnemyTile[0]);
          //check left and right tile
        if (!(xEnemyTile[i] <= 0 || xEnemyTile[i] >= rows - 1))
        {
          //set the boxes to check collision on
          enemies.get(i).boxesToCheck[0] = new PVector(xEnemyTile[i]-1, yEnemyTile[i]);
          enemies.get(i).boxesToCheck[1] = new PVector(xEnemyTile[i]+1, yEnemyTile[i]);           
        }   
      } 
    }

  }

  public void DrawBoxes()
  {
    for (int i = 0; i < rows; i++)
    {
      for (int j = 0; j < columns; j++)
      {
        boxes[i][j].Draw();
      }
    }

    // for (int i = 0; i < surrounding.size(); i++)
    // {
    //   surrounding.get(i).Draw();
    // }
  }
  public void DrawForeground()
  {
    if(foregroundImage != null)
    {
      for (int i = 0; i < rows; i++)
      {
        for (int j = 0; j < columns; j++)
        {
          foreground[i][j].Draw();
        }
      } 
    }       
  }
}
class Bullets
{
	int direction;
	PVector position;
	float speed = 400;
	float size = 10;
	float rotation;
	int despawnTime = 700;
	Bullets(PVector pos,int dir,float rot)
	{
		direction = dir;
		position = pos.copy();
		rotation = rot;
		if(dir == LEFT && degrees(rotation) <= 170 && degrees(rotation) >= 0)
			rotation = radians(170);
		if(dir == LEFT && degrees(rotation) >= -170 && degrees(rotation) <= 0)
			rotation = radians(-170);					
		if(dir == RIGHT && degrees(rotation) <= -10)
			rotation = radians(-10);
		if(dir == RIGHT && degrees(rotation) >= 10)
			rotation = radians(10);						


	}

	public void Update()
	{
		if(!pauseWorld)
		{
			position.x += cos(rotation)*(speed*deltaTime);
			position.y += sin(rotation)*(speed*deltaTime);
			checkOOB();
			CheckCollision();
			CheckKill();
			despawn();
		}
	}

	public void checkOOB()
	{
		if(position.x > (width*(boxManager.rows/32.0f)) || position.x < 0 || position.y > height*(boxManager.columns/18.0f) || position.y < 0)
		{
			bullet.remove(this);
		}
	}

	public void CheckCollision()
	{
   		for (int i = 0; i < boxManager.rows; i++)
	    {
	    	for (int j = 0; j < boxManager.columns; ++j) 
	    	{
			    if(position.x + size/2 > boxManager.boxes[i][j].position.x - boxManager.boxes[i][j].size/2 &&
			       position.x - size/2 < boxManager.boxes[i][j].position.x + boxManager.boxes[i][j].size/2 &&
			       position.y + size/2 > boxManager.boxes[i][j].position.y - boxManager.boxes[i][j].size/2 &&
			       position.y - size/2 < boxManager.boxes[i][j].position.y + boxManager.boxes[i][j].size/2)
			    {  	    		
			        if (boxManager.boxes[i][j].collides == 1 ||
			            boxManager.boxes[i][j].collides == 5 ||
			            boxManager.boxes[i][j].collides == 15 ||
			            boxManager.boxes[i][j].collides == 16 ||
			            boxManager.boxes[i][j].collides == 17 ||
			            boxManager.boxes[i][j].collides == 18)
			        {          
		      			bullet.remove(this);     
			        }
			    }
	        }
	    }
	}	
	public void CheckKill()
	{
	  if(position.x + size/2 > player.position.x - player.playerWidth/2 &&
	  position.x - size/2 < player.position.x + player.playerWidth/2 &&
	  position.y + size/2 > player.position.y - player.playerHeight/2 &&
	  position.y - size/2 < player.position.y + player.playerHeight/2)
	  {    
	    boxManager = new BoxManager(currentLevel);
	    gameManager.currencyValues[3]++;
	  }        
	}

	public void despawn()
	{
		if(despawnTime == 0)
		{
			bullet.remove(this);
		}
		else despawnTime--;
	}

	public void Draw()
	{
		pushMatrix();
		translate(position.x - camera.shiftX,position.y - camera.shiftY);
		fill(255,0,0);
		rect(0,0,size,size);
		popMatrix();
		noFill();
	}
}
class Buttons
{
  //------Position------
  private float x;
  private float y;
  private float r;
  private float rv;
  //------Object variables------
  String text;
  String type;
  boolean selected;
  boolean selectedLevel;
  
  //------Images-------
  private PImage buttonUp;
  private PImage buttonDown;
  private PImage logo;
  //------Color------
  private int rgb;
  
  Buttons(float x, float y, String text, String type ,int rgb)
  {
   this.x = x;
   this.y = y;
   this.text = text;
   this.rgb = rgb;
   this.type = type;
   buttonUp = loadImage("Menu/grey_button_up.png");
   buttonDown = loadImage("Menu/grey_button_down.png");
   //logo = loadImage("Menu/ForWhomTheBellTolls");
   r = 0;
   rv = 0.05f;
  }
  
  
  public void createButton()
  {
    pushMatrix();
    fill(rgb);
    if(type != "text")
    image(buttonUp,x,y);
    text(text,x,y);
    popMatrix();
  }
  public void update()
  {
    if(type == "button")
    {
      textAlign(CENTER, CENTER);
      if(selected)
      {
        pushMatrix();
        fill(rgb);
        image(buttonDown,x,y);    
        text(text,x,y+3);
        popMatrix();
      }
      else
      {
        pushMatrix();
        fill(rgb);
        image(buttonUp,x,y);
        text(text,x,y);
        popMatrix();
      }
    }
    if(type == "image")
    {
      pushMatrix();
      fill(rgb);
      translate(x,y+2);
      image(logo,0,0);
      textSize(28);
      popMatrix();
    }
    if(type == "text")
    {
      pushMatrix();
      fill(rgb);
      translate(x,y+2);
      text(text,0,0);
      popMatrix();
    }      
    if(type == "rotatingText")
    {
      pushMatrix();
      fill(rgb);
      textSize(28+(mainMusic.left.get(1)*5));
      translate(x,y+2);
      rotate(radians(r));
      text(text,0,0);
      textSize(28);
      popMatrix();
      if(r > 5)rv = -rv;
      if(r < -5)rv = -rv;
      r += rv;
    }
    if(type == "text")
    {
      pushMatrix();
      fill(rgb);
      translate(x,y+2);
      text(text,0,0);
      popMatrix();
    }       
  }
}
class Camera
{
  float shiftX;
  float shiftY;
  float margin;
  float shiftXOrigin;
  float shiftYOrigin;
  float focusX;
  float focusY;

  Camera(){
    shiftX = 0;
    shiftY = 0;
    shiftXOrigin = 0;
    shiftYOrigin = 0;
    focusX = 0;
    focusY = 0;    
    margin = 0.48f;
  }

  public void UpdateX(){
    if ((player.position.x - shiftX) / width > (1 - margin)){
      if(((player.position.x) / width - (1 - margin)) * width < ((boxManager.boxes[boxManager.rows-1][0].position.x+boxManager.boxSize/2)-width))
      shiftX = ((player.position.x) / width - (1 - margin)) * width;
      else shiftX = ((boxManager.boxes[boxManager.rows-1][0].position.x+boxManager.boxSize/2)-width);

    }
    if ((player.position.x + -shiftX) / width < margin){
      if(((player.position.x) / width -  margin) * width > 0)
      shiftX = ((player.position.x) / width -  margin) * width;
      else shiftX = 0;
    }

  }

  public void UpdateY(){
    if ((player.position.y - shiftY) / height > (1 - margin)){
      if(((player.position.y) / height - (1 - margin)) * height < ((boxManager.boxes[0][boxManager.columns-1].position.y+boxManager.boxSize/2)-height))
      shiftY = ((player.position.y) / height - (1 - margin)) * height;
      else shiftY = ((boxManager.boxes[0][boxManager.columns-1].position.y+boxManager.boxSize/2)-height);
    }
    if ((player.position.y + -shiftY) / height < margin){
      if(((player.position.y) / height - margin) * height > 0)
      shiftY = ((player.position.y) / height - margin) * height;
      else shiftY = 0;
    }
  }
}
class CheckPoint
{
	PVector position;
	float checkPointWidth, checkPointHeight;
	int checkPointColor;

	int checkPointIndex;
	boolean reachedCheckPoint;

	CheckPoint(PVector pos, int index)
	{
		position = pos;
		checkPointWidth = 40f;
		checkPointHeight = 60f;
		checkPointColor = color(150, 0, 0);
		reachedCheckPoint = false;

		checkPointIndex = index;
		checkPointManager.addCheckPoint();
	}

	public void updateCheckPoint()
	{
		println(checkPointIndex + ": " + reachedCheckPoint);
		if(this.position.x + checkPointWidth/2 > player.position.x - player.playerWidth/2 && 
	       this.position.x - checkPointWidth/2 < player.position.x + player.playerWidth/2 && 
	       this.position.y + checkPointHeight/2 > player.position.y - player.playerHeight/2 &&
	       this.position.y - checkPointHeight/2 < player.position.y + player.playerHeight/2)
	    {
	    	this.reachedCheckPoint = true;
	    	checkPointManager.checkPointReached(checkPointIndex);
	    }

	    if(reachedCheckPoint)
	    	checkPointColor = color(0, 200, 0);
	}

	public void drawCheckPoint()
	{
		pushMatrix();
		translate(position.x, position.y+10f);
		fill(checkPointColor);
		rect(0, 0, checkPointWidth, checkPointHeight);
		popMatrix();
	}
}
class CheckPointManager
{
	ArrayList<CheckPoint> checkPoints;
	//incremented by every checkpoint instantiated
	int amountOfCheckPoints;
	int currentCheckPoint;

	CheckPointManager()
	{
		checkPoints = new ArrayList<CheckPoint>();
		currentCheckPoint = 0;
	}

	public void addCheckPoint()
	{
		amountOfCheckPoints++;
	}

	public int getCurrentCheckPoint()
	{
		return currentCheckPoint;
	}

	public void updateCheckPointManager()
	{
		for(int i = 0; i < amountOfCheckPoints; i++)
		{
			CheckPoint checkPoint = checkPoints.get(i);
			checkPoint.updateCheckPoint();
		}
	}

	public void setPreviousCheckPointsReached()
	{
		for(int i = 0; i < currentCheckPoint; i++)
		{
			if(i+1 < currentCheckPoint && checkPoints.get(i).reachedCheckPoint == false)
			{
				//println("currentCheckPoint: "+currentCheckPoint);
				checkPoints.get(i).reachedCheckPoint = true;
			}
		}
		println();
	}

	public void restoreCheckPoints()
	{
		currentCheckPoint = gameManager.furthestCheckPoint;
		setPreviousCheckPointsReached();
	}

	public void checkPointReached(int checkPoint)
	{
		if(checkPoint > currentCheckPoint)
			currentCheckPoint = checkPoint;

		setPreviousCheckPointsReached();
	}

	public void drawCheckPointManager()
	{
		for(int i = 0; i < amountOfCheckPoints; i++)
		{
			checkPoints.get(i).drawCheckPoint();
		}
	}
}
class Currency
{
	PVector position;
	PImage[] currency;

	int currentCoins;
	int size;
	String type;

	int timer;
	int currentCoin;

	Currency(PVector pos, String type)
	{
		  this.type = type;
		  if(type == "norm")
		  	currency = bolts;
		  else if(type == "gold")
		  	currency = goldenBolts;
		  position = pos.copy();
		  size = currency[0].width;
	}

	public void checkCollision()
	{
	    if(position.x + size/2 > player.position.x - player.playerWidth/2 && 
	       position.x - size/2 < player.position.x + player.playerWidth/2 && 
	       position.y + size/2 > player.position.y - player.playerHeight/2 &&
	       position.y - size/2 < player.position.y + player.playerHeight/2)
	    {
	    	if(type == "norm")
	        	gameManager.currencyValues[0]++;
	        else if(type == "gold")
	        	gameManager.currencyValues[0] += 10;
	        int r = round(random(0,2));
	        bolt[r].rewind();
	        bolt[r].play();
	    	coins.remove(this);
	    }
	}

	public void Update()
	{
		checkCollision();
	}

	public void Draw()
	{	
		if(timer == 10)
		{
			timer = 0;
			currentCoin++;
			if(currentCoin > 6) currentCoin = 0;
		}
		else
			timer++;
		image(currency[currentCoin], position.x - camera.shiftX, position.y - camera.shiftY);
	}
}
class Debug
{
	StringList texts;
	StringList logs;
	ArrayList<Float> floatValues;
	ArrayList<Boolean> booleanValues;

	PVector textStartPos;
	float textLineOffset;
	float valueOffset;

	Debug()
	{
		texts = new StringList();
		logs = new StringList();
		floatValues = new ArrayList<Float>();
		booleanValues = new ArrayList<Boolean>();

		textStartPos = new PVector(35, 250);
		textLineOffset = 22f;
		valueOffset = 100f;
	}

	public void log(String text, boolean value)
	{
		String log;
		log = text + str(value);

		if(!texts.hasValue(text))
		{
			texts.append(text);
			logs.append(log);
		}
		else
		{
			for(int i = 0; i < texts.size(); i++)
			{
				if(texts.get(i) == text)
				{
					logs.set(i, log);
				}
			}
		}
	}

	public void log(String text, float value)
	{
		String log;
		log = text + str(value);

		if(!texts.hasValue(text))
		{
			texts.append(text);
			logs.append(log);
		}
		else
		{
			for(int i = 0; i < texts.size(); i++)
			{
				if(texts.get(i) == text)
				{
					logs.set(i, log);
				}
			}
		}
	}

	public void drawDebug()
	{
		pushMatrix();
		translate(textStartPos.x, textStartPos.y);
		textAlign(LEFT);

		for(int i = 0; i < logs.size(); i++)
		{
			text(logs.get(i), 0, textLineOffset * i);
		}

		textAlign(CENTER);
		popMatrix();
	}
}
class Enemy {
  float x, y;
  float radius;
  float vx;
  float top, bottom, left, right;
  float boxSize = 40f;
  PVector[] boxesToCheck = new PVector[2];

  int enemyType;
  int bulletTimer = 100;
  int cycle = 0;
  int timer = 0;

  Enemy(float spawnX, float spawnY, int type) 
  {
    radius = 20;
    x = spawnX;
    y = spawnY;
    vx = 1;
    boxesToCheck[0] = new PVector(0,0);
    boxesToCheck[1] = new PVector(0,0);   
    enemyType = type;
  }


  public void CheckKillCollision()
  {
    if (x + radius > player.position.x - player.playerWidth/2 && 
      x - radius < player.position.x + player.playerWidth/2 && 
      y + radius > player.position.y - player.playerHeight/2 &&
      y - radius < player.position.y + player.playerHeight/2)
    {
      menu.currentSel = 0;
      menu.createDied();
      menu.menuState = 0;
      isMenu = true;
      gameManager.currencyValues[3]++;
    }    
  }
  public void Update() 
  {
    if(!pauseWorld)
    {
      CheckCollision();
      if(enemyType == 1)
        CheckFire();

      top = y - radius; 
      bottom = y + radius;
      left = x - radius;
      right = x + radius;
      if(enemyType != 3 && enemyType != 4)
      {
        x = x + vx * 3f;
      }
      CheckKillCollision();
    }
  }

  public void Draw() 
  {
    fill(255, 100, 100);
    if(cycle == 3)
      cycle = 0;

    pushMatrix();
    translate(x - camera.shiftX, y - camera.shiftY);
    scale(vx, 1.0f);
    if(enemyType == 0)
      image(basicEnemy[cycle],0,0);
    else if(enemyType == 1)
    {
      image(electricOrb[cycle], 0, 0);  
    }
    else if (enemyType == 2) 
    {
      image(electricOrbPurple[cycle], 0, 0);
    }
    
    popMatrix();
    if(timer >= 5 && !pauseWorld)
    {
      cycle++;
      timer = 0;
    }
    timer++;
  }

  public void CheckFire()
  {
    if(bulletTimer == 0)
    {
      if(vx == 1 && x - player.position.x < 0)
      {
        bullet.add(new Bullets(new PVector(x,y),RIGHT,atan2(player.position.y - y,player.position.x - x)));
      }
      if(vx == -1 && x - player.position.x > 0)
      {
        bullet.add(new Bullets(new PVector(x,y),LEFT,atan2(player.position.y - y,player.position.x - x)));
      }
      bulletTimer = 100;
    }
    else bulletTimer--;
  }

  public void CheckCollision()
  {
    for (int i = 0; i < 2; i++)
    {
      if(boxManager.boxes != null)
      {
        Box box = boxManager.boxes[PApplet.parseInt(boxesToCheck[i].x)][PApplet.parseInt(boxesToCheck[i].y)];
        if(box != null)
          if (x + radius > (box.position.x - box.size/2) && 
            x - radius < (box.position.x + box.size/2) && 
            y + radius > (box.position.y - box.size/2) &&
            y - radius < (box.position.y + box.size/2))
          {
            if (box.collides == 1 ||
                box.collides == 5 ||
                box.collides == 15 ||
                box.collides == 16 ||
                box.collides == 17 ||
                box.collides == 18 ||
                box.collides == 22)
            {          
              vx *= -1f;      
            }
          }
      }
    }
  }
}
class Fire
{
	PVector position;
	boolean underPlayer;
	float size;

	float currentFrame;
	float animationSpeed;

	Fire(PVector pos)
	{
		position = pos;
		underPlayer = false;
		size = 40f;

		animationSpeed = 0.3f;
	}

	public void updateFire()
	{
		currentFrame = (currentFrame + animationSpeed) % 2;
	}

	public void drawFire()
	{
		pushMatrix();
		translate(position.x, position.y);
		rect(0, 0, size, size);
		popMatrix();
	}
}
class Fuel
{
  //----------Properties----------
  int size = 20;
  int fuelAmount = 25;

  //----------Position----------
  PVector position;
  
  //----------Animation----------
  PImage[] fuel;
  //currentFrame represents the specific image from the array that's being drawn
  float currentFrame;
  float animationSpeed = 0.1f;
  boolean increment;
  
  Fuel(PVector pos)
  {
    position = pos.copy();
    increment = true;
    SetupSprites();
  }
  
  public void SetupSprites()
  {
    fuel = new PImage[3];
    String fuelName;

    for (int i = 0; i < fuel.length; i++)
    {
      //load fuel sprites
      fuelName = "Fuel/Fuel" + i + ".png";
      fuel[i] = loadImage(fuelName);
      //fuel[i].resize(80, 0);
    }
  }
  
  public void Update()
  {
    CheckCollision();

    //determine which sprite should be loaded next
    if(currentFrame >= 2)
    {
      increment = false;
    }
    if(currentFrame <= 0)
    {
      increment = true;
    }
    if(increment)
    {
      currentFrame = (currentFrame + animationSpeed);
    }
    else if(!increment)
    {
      currentFrame = (currentFrame - animationSpeed);
    }
  }
  
  public void CheckCollision()
  {
    //check if the player picks up the fuel
    if(position.x + size/2 > player.position.x - player.playerWidth/2 && 
       position.x - size/2 < player.position.x + player.playerWidth/2 && 
       position.y + size/2 > player.position.y - player.playerHeight/2 &&
       position.y - size/2 < player.position.y + player.playerHeight/2)
       {
         powerUpManager.fuelCount += fuelAmount;
         //delete this instance of the fuel class
         powerUpManager.fuels.remove(this);
       }
  }
  
  public void Draw()
  {
    pushMatrix();
    translate(position.x - camera.shiftX, position.y - camera.shiftY);
    image(fuel[PApplet.parseInt(round(currentFrame))], 0, 0);
    popMatrix();
  }
}
class GameManager
{
  String[] currencyNames;
  float[] currencyValues;

  int furthestCheckPoint = 0;

  float textOffset = 30f;
  int textColor = color(0);

  PVector currencyPos = new PVector(width, 0);
  PVector imagePos = new PVector(0, 0);

  float seconds;
  float counter;
  float maxTime;

  float highS;

  GameManager()
  {
    currencyNames = new String[6];
    currencyValues = new float[currencyNames.length];

    currencyNames[0] = "Bolts";
    currencyNames[1] = "Fuel";
    currencyNames[2] = "Time passed";
    currencyNames[3] = "Times died";
    currencyNames[4] = "Score";
    currencyNames[5] = "Framerate";

    currencyValues[0] = 0f;
    currencyValues[1] = 0f;
    currencyValues[2] = 0f;
    currencyValues[3] = 0f;
    currencyValues[4] = 0f;
    
  }

  public void Update()
  {
    if(!pauseWorld)
    {
      highS = highscore.getHighscore(currentLevel-1);
      currencyValues[1] = powerUpManager.fuelCount;
      currencyValues[2] += deltaTime;
      currencyValues[5] = round(frameRate);
      seconds += deltaTime;    

      if(seconds >= 60)
        seconds = 0;


      updateCurrency();
    }
  }

  public void Draw()
  {

    textFont(pixelFont);
    textSize(32);
    //pushMatrix();
    // fill(255);
    // translate(currencyPos.x, currencyPos.y);
    // for(int i = 0; i < currencyNames.length; i++)
    // {
    //   text(currencyNames[i] + ": " + round(currencyValues[i]), 0, textOffset * i);
    // }
    //popMatrix();
    textAlign(LEFT,CENTER);

    //images
    pushMatrix();
    imageMode(CORNERS);
    translate(imagePos.x, imagePos.y);

    if (currencyValues[1] < 10){
      image(uiScreenEmpty, 0 ,0);
    } else if (currencyValues[1] < (powerUpManager.maxFuelCount/2.5f)){
      image(uiScreen, 0, 0);
      image(uiScreenOverlay, 16, 40, 16+36, 40 + (69*(1 - currencyValues[1] / powerUpManager.maxFuelCount)));
    } else {
      image(uiScreenGreen, 0, 0);
      image(uiScreenOverlayGreen, 16, 40, 16+36, 40 + (69*(1 - currencyValues[1] / powerUpManager.maxFuelCount)));
    }

    // image(uiScreen3,60,60);
    // fill(79,0,0);
    // text("DEATHS :" + int(currencyValues[3]),72.5,89);
    // fill(255,0,0);
    // text("DEATHS :" + int(currencyValues[3]),72.5,85);
    // fill(255);   



    // image(uiScreen4,0,120);
    // fill(79,0,0);
    // text("TiME : " + int(currencyValues[2]/60) + ":" + int(seconds) + ":" + (int((currencyValues[2] - int(currencyValues[2]))*100)),10,149);
    // fill(255,0,0);
    // text("TiME : " + int(currencyValues[2]/60) + ":" + int(seconds) + ":" + (int((currencyValues[2] - int(currencyValues[2]))*100)),10,145);
    // fill(255);        

    int uiScreenOverlayCropPixels = constrain(PApplet.parseInt(140 * (currencyValues[4] / highS)),0,140);

    PImage cropOverlayHighscore = uiScreen2Overlay.get(0, 0, uiScreenOverlayCropPixels, 32);
    PImage cropOverlayGreen = uiScreen2OverlayGreen.get(0, 0, uiScreenOverlayCropPixels, 32);

    int uiScreenOverlayPixels = PApplet.parseInt((56+8)*(1 + currencyValues[4] / highS));

    if (currencyValues[4] < highS){
      image(uiScreen2, 56, 0);
      image(cropOverlayHighscore, 56+8, 16, uiScreenOverlayCropPixels + 56+8, 16+32);
    } else {
      image(uiScreen2Green, 56, 0);
      image(cropOverlayGreen, 56+8, 16, uiScreenOverlayCropPixels + 56+8, 16+32);
    }

    //PowerUps
    //rocketArm

    //equiped?
    if(powerUpManager.rocketArmActive){

      //on cooldown?
      if (powerUpManager.rocketArmCD){
        image(rocketArmCooldown, 56, 52);

        int rocketArmCooldownOverlayCropPixels = PApplet.parseInt(56 * (powerUpManager.rocketArmCounter / powerUpManager.rocketArmDelay));
        PImage cropOverlayRocketArm = rocketArmCooldownOverlay.get(0, 0, rocketArmCooldownOverlayCropPixels, 48);

        image(cropOverlayRocketArm, 56 + 8, 52 + 16);
      } else {
        image(rocketArmReady, 56, 52);
      }
    } else {
      image(rocketArmNotEquiped, 56, 52);
    }

    //rocketJump

    //equiped?
    if(powerUpManager.rocketJumpActive){

      //on cooldown?
      if(powerUpManager.rocketJumpCD){
        image(rocketJumpCooldown, 56 + 72, 52);

        int rocketJumpCooldownOverlayCropPixels = PApplet.parseInt(34 * (powerUpManager.rocketJumpCounter / powerUpManager.rocketJumpDelay));
        PImage cropOverlayRocketJump = rocketJumpCooldownOverlay.get(0, 0, rocketJumpCooldownOverlayCropPixels, 48);

        image(cropOverlayRocketJump, 56 + 72 + 8, 56 + 12);
      } else {
        image(rocketJumpReady, 56 + 72, 52);
      }

    } else {
      image(rocketJumpNotEquiped, 56 + 72 , 52);
    }


    popMatrix();
    pushMatrix();
    translate(width-372, -120);

    if(counter < 1)
    counter = currencyValues[3]/highscore.MAX_DEATHS;

    pushStyle();
    tint(lerp(0,79,counter),lerp(78,0,counter),0);  
    image(uiScreen3Overlay,220,127.5f);  
    noTint();
    popStyle();

    image(uiScreen3,216,120);
    fill(lerp(0, 79, counter),lerp(79, 0, counter),0);
    text("DEATHS :" + PApplet.parseInt(currencyValues[3]),226,149);
    fill(lerp(0, 255, counter),lerp(255, 0, counter),0);
    text("DEATHS :" + PApplet.parseInt(currencyValues[3]),226,145);
    fill(255);   

    if(maxTime < 1)
      maxTime = currencyValues[2]/highscore.MAX_TIME;

    pushStyle();
    tint(lerp(0,79,maxTime),lerp(78,0,maxTime),0);  
    image(uiScreen4Overlay,6,127.5f); 
    noTint(); 
    popStyle();

    image(uiScreen4,0,120);
    fill(lerp(0, 79, maxTime),lerp(79, 0, maxTime),0);
    text("TiME : " + floor(currencyValues[2]/60) + ":" + PApplet.parseInt(seconds) + ":" + (PApplet.parseInt((currencyValues[2] - PApplet.parseInt(currencyValues[2]))*100)),10,149);
    fill(lerp(0, 255, maxTime),lerp(255, 0, maxTime),0);
    text("TiME : " + floor(currencyValues[2]/60) + ":" + PApplet.parseInt(seconds) + ":" + (PApplet.parseInt((currencyValues[2] - PApplet.parseInt(currencyValues[2]))*100)),10,145);
    fill(255);        

    popMatrix();
    textSize(28);
    textFont(font);    
    imageMode(CENTER);
    textAlign(CENTER,CENTER);
  }

  public void resetValues()
  {
    currencyValues[0] = 0f;
    currencyValues[1] = 0f;
    currencyValues[4] = 0f;
    highS = highscore.getHighscore(currentLevel-1);    
  }

  public void drawCurrency()
  {
    if(coins != null)
      for (int i = 0; i < coins.size(); ++i) {
        coins.get(i).Draw();
      }
  }
  public void updateCurrency()
  {
    if(coins != null)
      for (int i = 0; i < coins.size(); ++i) {
        coins.get(i).Update();
      }
  }
}
public class GameState extends State
{

  public void OnStateEnter()
  {
  }

  public void OnTick()
  {
    println("Game state");
  }

  public void OnDraw()
  {
    
  }

  public void OnStateExit()
  {
  }
}
class Highscore
{
	/*
		Highscore berekenen:
		bolts: 50 punten. secret bolts = 10 bolts
		fuel: 10 punten.
		tijd: 2 minuten max | 2 minuten - tijd / 100 + 1
		deaths: 9 deaths = 10 % van totale score | 8 = 20% etc.

		bolts = 30
		fuel = 75
		tijd = 60 sec
		deaths 4
	*/

	Table highscoreTable;
	Table nameTable;

	int score;
	int highscoreRow;
	float highscoreTableLineSpacing = 30f;
	int blinkingTextColor = /*color(255, 99, 71)*/color(225, 131, 26);
	String topString = "Enter your name below";
	int maxPlayerNameLength = 12;

	float highscore;
	final float BOLTS_SCORE = 50;
	final float FUEL_SCORE = 10;
	final float MAX_TIME = 120;
	final float MAX_DEATHS = 10;
	
	Highscore()
	{
		highscoreTable = loadTable("highscores.csv", "header");
		nameTable = loadTable("PlayerNames.csv", "header");

		//bolts
		highscore = BOLTS_SCORE * gameManager.currencyValues[0];
		highscore += FUEL_SCORE * gameManager.currencyValues[1];
		if((MAX_TIME - gameManager.currencyValues[2])/100 > 0)
			highscore *= (MAX_TIME - gameManager.currencyValues[2])/100 + 1;
		if(gameManager.currencyValues[3] <= MAX_DEATHS)
			if(gameManager.currencyValues[3] != 0)
				highscore *= (MAX_DEATHS - gameManager.currencyValues[3])/MAX_DEATHS + 0.1f;
			println((MAX_DEATHS - gameManager.currencyValues[3])/MAX_DEATHS + 0.1f);

	}

	public String getLevelString(int level)
	{
		String levelString = "Level " + level;
		return levelString;
	}

	public void checkHighscore()
	{
		score = round(gameManager.currencyValues[4]);

		if(score >= highscoreTable.getInt(9, getLevelString(currentLevel)))
		{
			println("YOU GOT A HIGHSCORE");
			determineHighscorePlace(currentLevel);
			saveTable(highscoreTable, "data/Highscores.csv");
			saveTable(nameTable, "data/PlayerNames.csv");
		}
		else
			println("YOU DIDNT GET THE HIGHSCORE YOU NERD");
		
	}

	public void determineHighscorePlace(int finishedLevel)
	{
		int index = 10;

		while(score >= highscoreTable.getInt(index-1, getLevelString(finishedLevel)))
		{
			index--;

			if(index == 0)
			{
				saveHighscore(index, finishedLevel);
				return;	
			}
		}
		
		saveHighscore(index, finishedLevel);
	}

	public void saveHighscore(int index, int finishedLevel)
	{
		moveValuesDownTables(index, finishedLevel);
		highscoreTable.setInt(index, getLevelString(finishedLevel), score);
		enterPlayerName(index);
	}

	public void moveValuesDownTables(int row, int finishedLevel)
	{
		for(int i = 8; i >= row; i--)
		{
			//move the highscores down the highscore table
			int originalScore = highscoreTable.getInt(i, getLevelString(finishedLevel));
			highscoreTable.setInt(i+1, getLevelString(finishedLevel), originalScore);

			//move the names down the name table
			String originalname = nameTable.getString(i, getLevelString(finishedLevel));
			nameTable.setString(i+1, getLevelString(finishedLevel), originalname);
		}
		nameTable.setString(row, getLevelString(finishedLevel), "");
	}

	public void enterPlayerName(int index)
	{
		highscoreRow = index;
		isTypingName = true;
	}

	public int getHighscore(int level)
	{
		return PApplet.parseInt(highscoreTable.getInt(0, getLevelString(level+1)));
	}

	public void showHighscore()
	{
		pushMatrix();
		translate(300, 150);
		textAlign(LEFT);
		for(int i = 0; i < 10; i++)
		{
			fill(0);
			if(isTypingName)
			{
				if(i == highscoreRow)
					fill(blinkingTextColor, menu.textAlpha);
			}
			//textString = ("This %s is %i years old, and weighs %.1f pounds." % (animal, age, weight));
			if(i == 0)
				text((i+1) + " :   " + nameTable.getString(i, getLevelString(currentLevel)), 4, i * highscoreTableLineSpacing);
			else if(i == 9)
				text((i+1) + ": " + nameTable.getString(i, getLevelString(currentLevel)), 0, i * highscoreTableLineSpacing);
			else
				text(i+1 + ":   " + nameTable.getString(i, getLevelString(currentLevel)), 0, i * highscoreTableLineSpacing);
			text("Score:  " + highscoreTable.getInt(i, getLevelString(currentLevel)), 400, i * highscoreTableLineSpacing);
		}

		textAlign(CENTER);
		popMatrix();

		if(isTypingName)
		{
			text(topString, width/2, 100);
			text("Press enter to confirm your name", width/2, 500);
		}
	}

	public void updateScore()
	{
		highscore = BOLTS_SCORE * gameManager.currencyValues[0];
		highscore += FUEL_SCORE * gameManager.currencyValues[1];
		if((MAX_TIME - gameManager.currencyValues[2])/100 > 0)
			highscore *= (MAX_TIME - gameManager.currencyValues[2])/100 + 1;
		if(gameManager.currencyValues[3] <= MAX_DEATHS)
		{
			if(gameManager.currencyValues[3] != 0)
				highscore *= (MAX_DEATHS - gameManager.currencyValues[3])/MAX_DEATHS + 0.1f;
		}
		else
		highscore *= 0.1f;

		gameManager.currencyValues[4] = highscore;	
	}
}
public class IdleState extends State
{
  PVector velocity;
  float animationSpeed;
  float currentFrame;
  final int LEFT = 0, RIGHT = 1;
  
  public void OnStateEnter()
  {
    //set the speed for the idle animation
    animationSpeed = 0.05f;

    //get the direction the player is facing to draw the sprite in the correct direction
    if(player == null)
    {
      currentDirection = 1;
    }
    else
    {
      currentDirection = player.currentDirection;
    }
  }
  
  public void OnTick()
  {
    //currentFrame is the sprite that's selected from the array of sprites
    //currentFrame is incremented untill it reaches the length of the array, then it restarts
    currentFrame = (currentFrame + animationSpeed) % 2;
    velocity = player.velocity.copy();
    
    //check if state switch is needed
    //if the velocity is 0, exit the method and don't read the other two checks
    if(velocity.x == 0 && velocity.y == 0) return;
    
    if(velocity.y != 0)
    {
      player.SetState(new JumpState());
    }
    else if(velocity.x != 0)
    {
      player.SetState(new RunState());
    }
  }

  public void OnDraw()
  {
    pushMatrix();
    translate(player.position.x - camera.shiftX, player.position.y - camera.shiftY);
    //draw the currect sprite from the array, flip the sprite if it needs to face left
    if(currentDirection == RIGHT)
    {
      image(player.idle[PApplet.parseInt(currentFrame)], 0, 0);
    }
    else if(currentDirection == LEFT)
    {
      pushMatrix();
      scale(-1.0f, 1.0f);
      image(player.idle[PApplet.parseInt(currentFrame)],0 ,0);
      popMatrix();
    }
    popMatrix();
  }

  public void OnStateExit()
  { 

  }
 }   
class Input
{
  boolean isUp,isDown,isRight,isLeft,isSpace,isP,isK,isL,isR,isU;
  boolean enabled = true;

  public boolean KeyDown(int k, boolean b)
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
class Introscherm
{
	float animationSpeed = 0.3f;
	float currentImage;
	boolean playIntroAnimation;

	public void updateIntro()
	{
		if(input.isSpace)
		{
			playIntroAnimation = true;
			currentImage = 0;
		}
	}

	public void drawIntro()
	{
		if(playIntroAnimation == false)
		{
			currentImage = (currentImage + animationSpeed) % introIdleScreen.length;
			image(introIdleScreen[PApplet.parseInt(currentImage)], 525, 575, 2048, 1152);
		}
		else 
		{
			currentImage = (currentImage + animationSpeed) % intro.length;
			image(intro[PApplet.parseInt(currentImage)], 525, 575, 2048, 1152);
			if(currentImage >= intro.length - 1 - animationSpeed)
			{
				displayIntro = false;
				playIntroAnimation = false;
				menu.createMainMenu();
			}
		}
	}
}
public class JumpState extends State
{
  PVector velocity;
  float animationSpeed;
  float currentFrame;
  final int LEFT = 0, RIGHT = 1, UP = 2, DOWN = 3;
  
  public void OnStateEnter()
  {
    //set the speed for the jump animation
    animationSpeed = 0.05f;
    
    //get the direction the player is facing to draw the sprite in the correct direction
    if(player == null)
    {
      currentDirection = 1;
    }
    else
    {
      currentDirection = player.currentDirection;
    }
  }
  
  public void OnTick()
  {
    //currentFrame is the sprite that's selected from the array of sprites
    //currentFrame is incremented untill it reaches the length of the array, then it restarts
    currentFrame = (currentFrame + animationSpeed) % player.jump.length;
    velocity = player.velocity.copy();
    
    //check if state switch is needed
    if(velocity.x == 0 && velocity.y == 0)
    {
      player.SetState(new IdleState());
    }
    else if(velocity.y == 0 && velocity.x != 0)
    {
      player.SetState(new RunState());
    }

    //determine facing direction by the player velocity
    if(velocity.x > 0)
    {
      currentDirection = RIGHT;
    }
    else if(velocity.x < 0)
    {
      currentDirection = LEFT;
    }
    if(velocity.y < 0)
    {
      ///jump animation
      //currentDirection = UP;
    }
    else if(velocity.y > 0)
    {
      ///falling animation
      //currentDirection = DOWN;
    }
   }

  
  public void OnDraw()
  {
    pushMatrix();
    translate(player.position.x - camera.shiftX, player.position.y - camera.shiftY);
    //draw the currect sprite from the array, flip the sprite if it needs to face left
    if(currentDirection == RIGHT)
    {
      image(player.jump[PApplet.parseInt(currentFrame)], 0, 0);
    }
    else if(currentDirection == LEFT)
    {
      pushMatrix();
      scale(-1.0f, 1.0f);
      image(player.jump[PApplet.parseInt(currentFrame)],0 ,0);
      popMatrix();
    }
    popMatrix();
  }

  public void OnStateExit()
  {
    player.currentDirection = currentDirection;
  }
}
class Laser
{
	//----------Properties----------
	int laserColor;
	float laserLength;

	//----------Position----------
	PVector spawnPos;
	PVector endPoint;

	//----------Other----------
	//the laser rotates from minAngle to maxAngle and vice versa
	float minAngle, maxAngle;
	float direction;
	float rotationSpeed;
	float angle;

	float laserSize;
	float backLaserSize;
	boolean expanding = false;


	boolean movingUp;

	final int LEFT = 0, RIGHT = 1, MIXED = 2;

	Laser(PVector pos, float minAngle, float maxAngle, float speed, float length, int dir)
	{
		//startPoint of the laser, the laser rotates around the spawnPos
		spawnPos = pos.copy();
		this.minAngle = minAngle;
		this.maxAngle = maxAngle;
		rotationSpeed = speed;
		laserLength = length;
		direction = dir;
		if(dir == RIGHT)
			movingUp = true;
		else if(direction == LEFT)
			movingUp = false;	
		laserColor = color(255, 0, 0);
		endPoint = new PVector(0, 0);
		
		angle = minAngle;

		//the tip of the laser 
		endPoint.x = spawnPos.x + (cos(radians(angle)) * laserLength);
		endPoint.y = spawnPos.y + (sin(radians(angle)) * laserLength);
	}

	public void updateLaser()
	{
		moveLaser();
		checkCollision();
		changeLaserSize();
	}

	public void moveLaser()
	{
		if(direction == LEFT)
			angle -= rotationSpeed * deltaTime;
		else if(direction == RIGHT)
			angle += rotationSpeed * deltaTime;
		else if(direction == MIXED)
		{
			if(movingUp && angle >= maxAngle)
				movingUp = false;
			else if(movingUp && angle < maxAngle)
				angle += rotationSpeed * deltaTime; 
			if(!movingUp && angle <= minAngle)
				movingUp = true;
			else if(!movingUp && angle > minAngle)
				angle -= rotationSpeed * deltaTime;
		}
		
		endPoint.x = spawnPos.x + (cos(radians(angle)) * laserLength);
		endPoint.y = spawnPos.y + (sin(radians(angle)) * laserLength);
	}

	public void checkCollision()
	{
		if(isIntersecting(spawnPos.x, spawnPos.y, endPoint.x, endPoint.y, player.position.x, player.top + 10, player.position.x, player.bottom))
		{
			isMenu=true;
      		menu.menuState=0;
			menu.createDied();
		}

	}

	public boolean isIntersecting(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) 
	{
		float denominator = ((x2 - x1) * (y4 - y3)) - ((y2 - y1) * (x4 - x3));
		float numerator1 = ((y1 - y3) * (x4 - x3)) - ((x1 - x3) * (y4 - y3));
		float numerator2 = ((y1 - y3) * (x2 - x1)) - ((x1 - x3) * (y2 - y1));

		// Detect coincident lines (has a problem, read below)
		if (denominator == 0) return numerator1 == 0 && numerator2 == 0;

		float r = numerator1 / denominator;
		float s = numerator2 / denominator;



		return (r >= 0 && r <= 1) && (s >= 0 && s <= 1);
	}

	  public void changeLaserSize()
	  {
	    float laserGrowthSpeed = 1.5f;
	    float backLaserGrowthSpeed = 3f;

	    if(expanding)
	    {
	      laserSize += laserGrowthSpeed;
	      backLaserSize += backLaserGrowthSpeed;
	    }
	    else
	    {
	      laserSize -= laserGrowthSpeed;
	      backLaserSize -= backLaserGrowthSpeed;
	    }
	    
	    if(laserSize > 12.5f)
	      expanding = false;
	    else if(laserSize < 7.5f)
	      expanding = true;
	  }	

	public void drawLaser()
	{
		pushMatrix();

		strokeWeight(backLaserSize);
		stroke(laserColor, 100);
		line(endPoint.x - camera.shiftX, endPoint.y - camera.shiftY, spawnPos.x - camera.shiftX, spawnPos.y - camera.shiftY);

		strokeWeight(laserSize);
		stroke(laserColor);
		line(endPoint.x - camera.shiftX, endPoint.y - camera.shiftY, spawnPos.x - camera.shiftX, spawnPos.y - camera.shiftY);


		//strokeWeight(4);
		//stroke(255);
		// //line(player.position.x, player.top + 10, player.position.x, player.bottom);

		// text("angle: " + angle, width/2, 100);
		// text("minAngle: " + minAngle, width/2, 200);
		// text("maxAngle: " + maxAngle, width/2, 300);

		fill(255, 255, 0);
		noStroke();
		ellipse(spawnPos.x, spawnPos.y, 10, 10);
		fill(255);
		ellipse(endPoint.x, endPoint.y, 10, 10);


		popMatrix();
	}
}
class Levels
{
  
  //------Position------
  private float x;
  private float y;
  
  //------Object variables------
  private String text;
  private String type;
  int selectedLevel;
  private int rgb;
  private int levels;
  private int[] level;
  
  //------Images------
  private PImage greyPanel;
  private PImage[] map;
  
  Levels(int levels,int rgb)
  {
   this.rgb = rgb;
   this.levels = levels;
   level = new int[levels];
   map = new PImage[levels+1];
   selectedLevel = 0;
   greyPanel = loadImage("Menu/grey_panel.png");
  }
  
  
  public void createLevel()
  {
    for(int i = 0; i < level.length;i++)
    {
      image(greyPanel,width/2,height/2);
      map[i] = loadImage("thumbnail" + (i+1) + ".png");
      
    }
  }
  public void updateLevel()
  {
    if(input.isRight && selectedLevel < levels-1)
    {
      click.rewind();
      click.play();      
      selectedLevel++;
      input.isRight = false;
    }
    if(input.isLeft && selectedLevel > 0)
    {
      click.rewind();
      click.play();      
      selectedLevel--;
      input.isLeft = false;
    }
    for(int i = 0; i < level.length;i++)
    {
      if(i == selectedLevel)
      {
      pushMatrix();
      image(greyPanel,width/2,height/2,300,400);
      if(map[selectedLevel] != null)
        image(map[selectedLevel],width/2,height/2,200,150);
      text("level " + (i+1),width/2,height/2-100);

      int score = highscore.getHighscore(selectedLevel);

      text("score: " + score,width/2,height/2+100);
      popMatrix();
      }
      if(i == selectedLevel + 1)
      {
      pushMatrix();
      image(greyPanel,width/4*3,height/2,150,200);
      if(map[selectedLevel + 1] != null)
        image(map[selectedLevel + 1],width/4*3,height/2,100,75);      
      textSize(16);
      text("level " + (i+1),width/4*3,height/2-50);

      int score = highscore.getHighscore(selectedLevel + 1);
      text("score: " + score,width/4*3,height/2+50);  

      textSize(28);
      popMatrix();
      }
      if(i == selectedLevel - 1)
      {
      pushMatrix();
      image(greyPanel,width/4,height/2,150,200);
      if(selectedLevel != 0)
      {
      if(map[selectedLevel - 1] != null)
        image(map[selectedLevel - 1],width/4,height/2,100,75);   
      }
      textSize(16);
      text("level " + (i+1),width/4,height/2-50);

      if(selectedLevel != menu.amountOfLevels)
      {
      int score = highscore.getHighscore(selectedLevel - 1);
      text("score: " + score,width/4,height/2+50); 
      }

      textSize(28);
      popMatrix();
      }
    }
  }
  
}
class Magnet
{
  PVector position;
  int magnetColor = color(50, 50, 50);
  int magnetHeight = 40;
  int magnetWidth = 40;
  float dotProduct;
  int direction;
  PVector lookDirection;
  PVector offset;
  float attraction;
  float xDiff;
  float yDiff;
  PVector diff;
  float attractionPower = 40f;
  boolean isAttracting;
  boolean wasAttracting;
  boolean slowingDownPlayer;
  float slowingDownSpeed = 20f;
  
  Magnet(int direction, PVector pos)
  {
    position = pos;
    this.direction = direction;
    switch(direction)
    {
      case LEFT:
        lookDirection = new PVector(-1, 0);
        break;
     case RIGHT:
        lookDirection = new PVector(1, 0);
        break;
     case UP:
        lookDirection = new PVector(0, -1);
        break;
     case DOWN:
        lookDirection = new PVector(0, 1);
        break;
    }
  }
  
  public void Update()
  {
    //CheckCollision();
    
    CalculateAttraction();
    
    if(attraction >= 0.167f)
    {
      isAttracting = true;
      if(direction == LEFT || direction == UP || direction == DOWN)
        player.velocity.add(diff.copy());
      else
      {
        if(diff.x > 0)
          diff.x *= -1f;
        player.velocity.add(diff.copy());
      }
    }
    else
      isAttracting = false;
      
    CheckTransition();
      
    if(slowingDownPlayer)
      SlowDownPlayer();
      
    wasAttracting = isAttracting;
  }
  
  public void CalculateAttraction()
  {
    offset = player.position.copy().sub(position.copy());
    
    dotProduct = lookDirection.x * offset.x + lookDirection.y * offset.y;
    
    xDiff = position.x - player.position.x;
    yDiff = position.y - player.position.y;
    //xDiff = Math.abs(position.x - player.position.x);
    //yDiff = Math.abs(position.y - player.position.y);
    diff = new PVector(xDiff, yDiff);
    diff.mult(deltaTime * attraction * attraction * attractionPower);
    attraction = ((1/position.dist(player.position)) * (1/position.dist(player.position))) * dotProduct * 40f;
  }
  
  public void CheckTransition()
  {
    if(isAttracting == false && wasAttracting == true)
    {
      //println("switch");
      //println("isAttracting: " + isAttracting);
      //println("wasAttracting: " + wasAttracting);
      switch(direction)
      {
        case LEFT:
          if(player.velocity.x > player.maxSpeed)
          {
            slowingDownPlayer = true;
          }
          break;
        case RIGHT:
          if(player.velocity.x < -player.maxSpeed)
          {
            slowingDownPlayer = true;
          }
          break;
        case UP:

          if(player.velocity.y > player.maxGrav)
          {
            slowingDownPlayer = true;
          }
          break;
        case DOWN:
          if(player.velocity.y > player.maxGrav)
          {
            slowingDownPlayer = true;
          }
          break;
      }
      slowingDownPlayer = true;
    }
  }
  
  public void SlowDownPlayer()
  {
    switch(direction)
    {
      case LEFT:
        if(player.velocity.x > player.maxSpeed)
        {
          player.velocity.x -= slowingDownSpeed;
        }
        else
          slowingDownPlayer = false;
        break;
      case RIGHT:
        if(player.velocity.x < -player.maxSpeed)
        {
          player.velocity.x += slowingDownSpeed;
        }
        else
          slowingDownPlayer = false;
        break;
      case UP:

        if(player.velocity.y > player.maxGrav)
        {
          player.velocity.y -= slowingDownSpeed;
        }
        else
          slowingDownPlayer = false;
        break;  
      case DOWN:
        if(player.velocity.y > player.maxGrav)
        {
          player.velocity.y -= slowingDownSpeed;
        }
        else
          slowingDownPlayer = false;
        break;
    }
  }
  
  public void CheckCollision()
  {
    if(position.x + magnetWidth/2 > player.position.x - player.playerWidth/2 && 
       position.x - magnetWidth/2 < player.position.x + player.playerWidth/2 && 
       position.y + magnetHeight/2 > player.position.y - player.playerHeight/2 &&
       position.y - magnetHeight/2 < player.position.y + player.playerHeight/2)
       {
         player.position.sub(player.velocity.copy().mult(deltaTime));
       }
  }
  
  public void Draw()
  {
    pushMatrix();
    fill(magnetColor);
    translate(position.x - camera.shiftX, position.y - camera.shiftY);
    switch(direction)
    {
      case LEFT:
        rotate(radians(270));
        break;
      case RIGHT:
        rotate(radians(90));
        break;
      case UP:
        rotate(radians(0));
        break;  
      case DOWN:
        rotate(radians(180));
        break;
      default:
        rotate(radians(0));
    }
    image(magnetTex, 0, 0, magnetWidth, magnetHeight);
    popMatrix();
    
  }
}
class Menu
{

  //------Menu------
  private int menuState;
  //------Classes------
  private Buttons[] button;
  private Levels level;
  private Sliders sliders;
  private ArrayList<Background> back = new ArrayList<Background>();
  //------Variables------
  private int amountOfLevels;
  private int currentSel;
  private int alpha;
  private boolean highscoreShown;
  private boolean mainmenuShown;
  private int timer = 40;
  private float textAlpha = 0f;
  private float textBlinkingSpeed = 7f;
  private boolean increaseAlpha;
  //------Sound------
  
  Menu()
  {
    menuState = 0;
    button = new Buttons[10];
    createMainMenu();
    button[0].selected = true;
    currentSel = 0;
    alpha = 0; 
    highscoreShown = false;
    amountOfLevels = 10;
  }
  
  public void update()
  {
    if(input.isR){
      boxManager = new BoxManager(currentLevel);
      gameManager.currencyValues[3]++;
      gameManager.currencyValues[2] = 0;
      input.isR = false;
    }
  }
  
  public void draw()
  {
    updateMenu();
    if(menuState == 1)level.updateLevel();
  }

  public void createMainMenu()
  {
    highscoreShown = false;
    for(int i = 0; i < button.length;i++)
    {
      button[i] = null;
    }
    level = null;
    sliders = null;

    mainmenuShown = true;
    button[0] = new Buttons(width/2,height/2-75,"Play","button",74);
    //button[0].createButton();
    button[1] = new Buttons(width/2,height/2,"Options","button",74);
    //button[1].createButton();
    button[2] = new Buttons(width/2,height/2+75,"Exit","button",74);
    //button[2].createButton();    
    button[4] = new Buttons(width/2,height/2-200,"For whom the bell tolls","rotatingText",100);
    //button[4].createButton();
  }
  public void createOptions()
  {
    mainmenuShown = true;
    highscoreShown = false;
    for(int i = 0; i < button.length;i++)
    {
      button[i] = null;
    }

    level = null;
    sliders = null;
    String[] text = {"Music volume", "Sound effects volume"};
    sliders = new Sliders(2,text,100);
    sliders.createSlider();
    button[0] = new Buttons(width/2,height/2+75,"Back","button",74);
    button[0].createButton();


  }
  public void createLevelSelect()
  {
    bossLevelMusic.pause();
    if(levelmusic != null)
    levelmusic.pause();
    mainmenuShown = false;
    highscoreShown = false;
    for(int i = 0; i < button.length;i++)
    {
      button[i] = null;
    
    }
    level = null;
    sliders = null;

    level = new Levels(amountOfLevels ,74);
    level.createLevel();
    button[0] = new Buttons(width/2,height-125,"Select","button",74);
    button[0].createButton();
    button[1] = new Buttons(width/2,height-50,"Back","button",74);
    button[1].createButton();  
  }
  public void createEndLevel()
  {
    input.isSpace = false;
    bossLevelMusic.pause();
    if(levelmusic != null)
    levelmusic.pause();
    println("create end level");
    mainmenuShown = false;
    for(int i = 0; i < button.length;i++)
    {
      button[i] = null;
    
    }
    level = null;
    sliders = null;
    PImage maptest = loadImage("level"+(boxManager.level+1)+".png");

    if(maptest != null)
    {
      button[0] = new Buttons(width/2,height-125,"Continue","button",74);
      button[0].createButton();
      //button[0].selected = true;  
      button[1] = new Buttons(width/2,height-50,"Main Menu","button",74);
      button[1].createButton();
      highscoreShown = true;
      highscore.showHighscore();          
    }
    else
    {
      button[0] = new Buttons(width/2,height-50,"Main Menu","button",74);
      button[0].createButton();
      //button[0].selected = true;
      highscoreShown = true;
      highscore.showHighscore();        
    }

  }  
  public void createDied()
  {
    input.isSpace = false;
    bossLevelMusic.pause();
    mainmenuShown = false;
    highscoreShown = false;
    for(int i = 0; i < button.length;i++)
    {
      button[i] = null;
    
    }
    level = null;
    sliders = null;

    button[0] = new Buttons(width/2,height-125,"Retry","button",74);
    button[0].createButton();
    button[0].selected = true;  
    button[1] = new Buttons(width/2,height-50,"Main Menu","button",74);
    button[1].createButton();
    button[2] = new Buttons(width/2,height/2,"You died, continue?","text",50);
    button[2].createButton();   
    button[3] = new Buttons(width/2, height/2-50, "The highscore is: " + str(highscore.getHighscore(currentLevel-1)), "text", 50);           

  }  

  public void registerName()
  {
    if (key==CODED)
    {
      if (keyCode==LEFT)
        println ("left");
      else if (keyCode==RIGHT)
        println ("right");
      else if (keyCode==UP)
        println ("up");
      else if (keyCode==DOWN)
        println ("down");
    }
    else
    {
      if (key==BACKSPACE)
      {
        if (playerName.length()>0)
          playerName=playerName.substring(0, playerName.length()-1);
      }
      else if(key== ' ')
      {
        //prompt message can't use space in name
        highscore.topString = "You can't use spaces in your name";
      }
      else if (key==RETURN || key==ENTER)
      {
        if(playerName.length()>0)
        {
          highscore.nameTable.setString(highscore.highscoreRow, highscore.getLevelString(currentLevel), playerName);
          saveTable(highscore.nameTable, "data/PlayerNames.csv");
          isTypingName = false;
          button[0].selected = true;
        }
        else
        {
          highscore.topString = "Please enter your name before you continue";
          return;
        }
      }
      else
      {
        if(playerName.length() < highscore.maxPlayerNameLength)
          playerName+=key;
        else
          highscore.topString = "Max name length reached";
      }
    }
  }

  public void showPlayerName()
  {
    pushMatrix();
    translate(353, 138);
    textAlign(LEFT, CENTER);

    if(increaseAlpha)
      textAlpha += textBlinkingSpeed;
    else if(!increaseAlpha)
      textAlpha -= textBlinkingSpeed;

    if(textAlpha >= 255f && increaseAlpha)
    {
      textAlpha = 255f;
      increaseAlpha = false;
    }
    else if(textAlpha <= 75f && !increaseAlpha)
    {
      textAlpha = 75f;
      increaseAlpha = true;
    }

    fill(highscore.blinkingTextColor);
    text(playerName, 0, highscore.highscoreTableLineSpacing * (highscore.highscoreRow));
    
    textAlign(CENTER);
    popMatrix();
  }

  public void updateMenu()
  { 
      if(mainmenuShown)
      {
        image(background,width/2,height/2,width, height);
        if(timer == 0)
        {
          back.add(new Background());
          timer = 40;
        }
        else timer--;
        
        for(int i = 0; i < back.size(); i++)
        {
          back.get(i).Update(); 
        }
        for(int i = 0; i < back.size(); i++)
        {
          back.get(i).Draw(); 
        }        
      }

      if(sliders != null)
      sliders.updateSlider();
      
      if(highscoreShown)
        highscore.showHighscore();

      for(int i = 0; i < button.length; i++)
      {
        if(button[i] != null)
        {
          button[i].update();
          if(button[i].selected)currentSel = i;
        }
      }


      //------Input handling------
      if(input.isUp)
      {
        click.rewind();
        click.play();
        if(currentSel <= 0)
        {
          input.isUp = false;
        }
        else
        { 
          button[currentSel].selected = false;
          button[currentSel].selected= false;
          button[currentSel-1].selected = true;
          currentSel--;
          input.isUp = false;
        }
        
      }
      if(input.isDown)
      {
        click.rewind();
        click.play();
        if(currentSel > button.length)
        {
          input.isDown = false;
        }
        else
        {
          if(button[currentSel+1] != null)
          {
            button[currentSel].selected = false;
            button[currentSel+1].selected = true;
            currentSel++;
            input.isDown = false;
          }
        }
        
      }
      if((input.isSpace || input.isK) && !isTypingName)
      {
        click2.rewind();
        click2.play();
        input.isSpace = false;
        input.isK = false;
        if(button[currentSel].text == "Play")
          {
            button[currentSel].selected = false;
            currentSel = 0;
            createLevelSelect();
            button[currentSel].selected = true;
            menuState = 1;return;
          }
        if(button[currentSel].text == "Exit")
          exit();
        if(button[currentSel].text == "Select")
          {
            if(levelmusic != null)
            levelmusic.pause();
            int r = round(random(0,1));
            if(r == 0)
            {
              if(levelmusic == levelmusic1)
                levelmusic.rewind();
              else levelmusic = levelmusic1;
            }
            else 
            {
              if(levelmusic == levelmusic2)
                levelmusic.rewind();
              else levelmusic = levelmusic2;
            };
            levelmusic.setGain(-40 + volume[0]);              
            mainmenuShown = false;
            back.clear();
            currentLevel = level.selectedLevel+1;
            boxManager = new BoxManager(currentLevel);
            isMenu = false;mainMusic.pause();
            player.velocity.y = 0;

          }
        if(button[currentSel].text == "Options")
          {
            button[currentSel].selected = false;
            currentSel = 0;
            createOptions();
            button[currentSel].selected = true;
            return;
          }
        if(button[currentSel].text == "Back")
          {
            button[currentSel].selected = false;
            currentSel = 0;
            createMainMenu();
            button[currentSel].selected = true;
            menuState = 0;
            return;
          }
        if(button[currentSel].text == "Main Menu")
          {
            if(levelmusic != null)
            levelmusic.pause();            
            button[currentSel].selected = false;
            currentSel = 0;
            createMainMenu();
            gameManager = new GameManager();
            button[currentSel].selected = true;
            menuState = 0;
            mainMusic.rewind();
            mainMusic.play();
            return;
          }
        if(button[currentSel].text == "Continue")
          {
            if(levelmusic != null)
            levelmusic.pause();
            int r = round(random(0,1));
            if(r == 0)
            {
              if(levelmusic == levelmusic1)
                levelmusic.rewind();
              else levelmusic = levelmusic1;
            }
            else 
            {
              if(levelmusic == levelmusic2)
                levelmusic.rewind();
              else levelmusic = levelmusic2;
            }
            levelmusic.setGain(-40 + volume[0]);              
            currentLevel++; 
            boxManager = new BoxManager(currentLevel); 
            gameManager = new GameManager();
            isMenu = false;

          }
        if(button[currentSel].text == "Retry")
          {
            gameManager.furthestCheckPoint = checkPointManager.getCurrentCheckPoint();
            boxManager = new BoxManager(currentLevel);
            gameManager.currencyValues[2] = 0;
            isMenu = false;
          }
      }
  }
    
}
class MovingPlatform extends Rectangle
{
	PVector position;
	float maxLeft, maxRight;

	float platformSpeed;
	boolean movingRight;
	boolean movesPlayer;

	MovingPlatform(PVector spawnPos, float platWidth, float platHeight, float farLeft, float farRight, boolean movesPlayer)
	{
		position = spawnPos.copy();
		rectWidth = platWidth;
		rectHeight = platHeight;
		maxLeft = farLeft;
		maxRight = farRight;

		platformSpeed = 80f;
		movingRight = true;

		name = "MovingPlatform";

		this.movesPlayer = movesPlayer;
	}

	protected String getName() {
		return name;
	}

	protected float getX()
	{
		return position.x;
	}

	protected float getY()
	{
		return position.y;
	}

	protected float getSize() {
		return size;
	}

	protected float getWidth() {
		return rectWidth;
	}

	protected float getHeight() {
		return rectHeight;
	}

	protected float getTop() {
		return top;
	}

	protected float getBottom() {
		return bottom;
	}

	protected float getLeft() {
		return left;
	}

	protected float getRight() {
		return right;
	}

	public void SetPosValues()
	{
		top = position.y - rectHeight/2;
		bottom = top + rectHeight;
		right = position.x + rectWidth/2;
		left = right - rectWidth;
	}

	public void updateMovingPlatform()
	{
		SetPosValues();
		movePlatform();
		checkCollisions();
	}

	public void movePlatform()
	{
		if(movingRight)
		{
			if(position.x + (rectWidth/2) > maxRight)
			{
				movingRight = false;
			}
			else 
			{
				position.x += platformSpeed * deltaTime;	
			}
		}
		else if(!movingRight)
		{
			if(position.x - (rectWidth/2) < maxLeft)
			{
				movingRight = true;
			}
			else 
			{
				position.x -= platformSpeed * deltaTime;	
			}
		}

		if(movingRight)
		{
			//position.x += platformSpeed * deltaTime;
			if(player.onMovingPlatform)
			{
				player.position.x += platformSpeed * deltaTime;
			}
		}
		else
		{
			//position.x -= platformSpeed * deltaTime;	
			if(player.onMovingPlatform)
			{
				player.position.x -= platformSpeed * deltaTime;
			}
		}
	}

	public void checkCollisions()
	{
		if(player.onMovingPlatform)
		{
			if((player.position.x > position.x + (rectWidth/2) + (player.playerWidth/2)) || (player.position.x < position.x - (rectWidth/2) - (player.playerWidth/2)))
				player.onMovingPlatform = false;
		}

		if(position.x + rectWidth/2 > player.position.x - player.playerWidth/2 &&
		position.x - rectWidth/2 < player.position.x + player.playerWidth/2 &&
		position.y - (rectHeight/2)+1 > player.position.y - player.playerHeight/2 &&
		position.y - rectHeight/2 < player.position.y + player.playerHeight/2)
		{
			player.GetCollisionDirection(this);
		}
	}

	public void drawMovingPlatform()
	{
		pushMatrix();
		translate(position.x, position.y);
		rect(0, 0, rectWidth, rectHeight);
		popMatrix();
	}
}
class Objects
{
  //------Position------
  private float x;
  private float y;
  
  //------Object variables------
  String text;
  boolean selected;
  
  //------Images-------
  private PImage buttonUp;
  private PImage buttonDown;
  
  //------Color------
  private int rgb;
  
  Objects(float x, float y, String text, int rgb)
  {
   this.x = x;
   this.y = y;
   this.text = text;
   this.rgb = rgb;
   buttonUp = loadImage("grey_button_up.png");
   buttonDown = loadImage("grey_button_down.png");
  }
  
  public void createButton()
  {
    pushMatrix();
    fill(rgb);
    image(buttonUp,x,y);
    text(text,x,y);
    popMatrix();
  }
  public void updateButton()
  {
    if(selected)
    {
      pushMatrix();
      fill(rgb);
      image(buttonDown,x,y);
      text(text,x,y+2);
      popMatrix();
    }
    else
    {
      pushMatrix();
      fill(rgb);
      image(buttonUp,x,y);
      text(text,x,y);
      popMatrix();
    }
        
  }
}
class Sliders
{
  
  //------Position------
  private float y;
  
  //------Object variables------
  private int selectedSlider;
  private int rgb;
  private int sliders;
  private int[] level;
  private String[] texts;
  private int c;
  //------Images------
  private PImage slider;
  private PImage pointer;
  private PImage pointerUp;
  
  Sliders(int sliders, String[] text, int col)
  {
   c = col;
   this.sliders = sliders;
   level = new int[sliders];
   selectedSlider = 0;
   texts = text;
   slider = loadImage("Menu/grey_slider.png");
   pointer = loadImage("Menu/grey_pointer.png");
   pointerUp = loadImage("Menu/grey_pointer_up.png");

   y = 0;
  }
  
  
  public void createSlider()
  {
    y = 0;
    for(int i = 0; i < level.length;i++)
    {
      image(slider,width/2,height/2-150+y,380,10);
      image(pointer,width/2-190+(380*volume[i]/46),height/2-125+y);
      y+=100;
    }
  }
  public void updateSlider()
  {
    if(input.isUp && selectedSlider > 0)
      selectedSlider--;
    if(input.isDown && selectedSlider < level.length-1)
      selectedSlider++;
    if(input.isRight && volume[selectedSlider] < 46)
    {
      click.rewind();
      click.play();      
      volume[selectedSlider]+=0.46f;
    }
    if(input.isLeft && volume[selectedSlider] > 0.5f)
    {
      click.rewind();
      click.play();      
      volume[selectedSlider]-=0.46f;
    }
    y = 0;
    for(int i = 0; i < level.length;i++)
    {
      fill(c);
      text(texts[i], width/2,height/2-200+y);
      image(slider,width/2,height/2-175+y,380,10);
      pushMatrix();
      if(i == selectedSlider)
        image(pointer,width/2-190+(380*volume[i]/46),height/2-150+y);
      else
        image(pointerUp,width/2-190+(380*volume[i]/46),height/2-150+y);
      text(floor((volume[i]/46)*100),width/2-185+(380*volume[i]/46),height/2-112+y);
      popMatrix();
      y+=125;
    }
    updateSound();
  }
  public void updateSound()
  {
    //Music
    mainMusic.setGain(-40 + volume[0]);
    if(levelmusic != null)
    levelmusic.setGain(-40 + volume[0]);

    //Sound effects
    click.setGain(-40 + volume[1]);
    click2.setGain(-40 + volume[1]);
    jumpsound.setGain(-40 + volume[1]);
    walkingsound.setGain(-40 + volume[1]);
    interactionsound.setGain(-40 + volume[1]);
  }
}
  
class Particles
{
	PVector position;
	float vx;
	float vi;
	float size = 5;
	int colors;
	
	float vy;
	Particles(PVector pos,float velx, float vely, float velinc, int col)
	{
		position = pos.copy();
		vx = velx;
		vy = vely;
		colors = col;
		vi = velinc;
	}

	public void Update()
	{
		position.x += vx;
		if(vx != 0)
		{
			if(vx > 0)
				vx -= 0.05f;
			else
				vx += 0.05f;
		}
		position.y -= vy;
		if(vy > -20)
			vy -= vi;



		if(position.y > height*((float) boxManager.rows / 32))
			deletThis();

   		for (int i = 0; i < boxManager.rows; i++)
	    {
	    	for (int j = 0; j < boxManager.columns; ++j) 
	    	{
			    if(position.x + size/2 > boxManager.boxes[i][j].position.x - boxManager.boxes[i][j].size/2 &&
			       position.x - size/2 < boxManager.boxes[i][j].position.x + boxManager.boxes[i][j].size/2 &&
			       position.y + size/2 > boxManager.boxes[i][j].position.y - boxManager.boxes[i][j].size/2 &&
			       position.y - size/2 < boxManager.boxes[i][j].position.y + boxManager.boxes[i][j].size/2)
			    {  	    		
			        if (boxManager.boxes[i][j].collides == 1 ||
			            boxManager.boxes[i][j].collides == 5 ||
			            boxManager.boxes[i][j].collides == 15 ||
			            boxManager.boxes[i][j].collides == 16 ||
			            boxManager.boxes[i][j].collides == 17 ||
			            boxManager.boxes[i][j].collides == 18)
			        {         
			        	if(vy > -0.5f && vy < 0.5f)
			        	{
			        		deletThis();
			        	} 
			        	position.y = boxManager.boxes[i][j].position.y - boxManager.boxes[i][j].size/2 - 0.1f;
		      			vy *= -0.3f;     
			        }
			    }
	        }
	    }		
	}

	public void deletThis()
	{
		particle.remove(this);
	}

	public void Draw()
	{
		fill(colors);
		rect(position.x - camera.shiftX ,position.y - camera.shiftY,size,size);
		noFill();
	}
}
class Player
{
  //----------body----------
  float playerWidth;
  float playerHeight;
  int playerColor;

  //----------Movement----------
  PVector position;
  PVector velocity;
  float speed = 200f;
  float climbSpeed = 250f;
  float jumpVel;
  float gravity;
  float maxGrav;
  float lastVelY;

  //----------collisions----------
  float top, bottom, right, left;
  float oldTop, oldBottom, oldRight, oldLeft;
  PVector[] corners = new PVector[6];
  PVector playerBottom;
  //topLeft, topRight, bottomLeft, bottomRight;
  boolean collidedTop, collidedBottom, collidedRight, collidedLeft;

  //----------Other----------
  int textColor = color(0);
  boolean grounded = false;
  boolean canJump = false;

  PImage[] idle;
  PImage[] run;
  PImage[] slide;
  PImage[] jump;
  PImage[] fire;
  int currentDirection;
  float currentFrame;
  float currentRunFrame;
  float animationSpeed = 0.3f;

  PVector acceleration;
  PVector deceleration;
  float accelRate = 12f * 60;
  float decelRate = 20f * 60;
  float maxSpeed = 300f;
  float turnSpeed = 3f;
  boolean isDead = false;
  boolean isClimbing = false;
  boolean inAir = false;
  boolean jumpHold = false;

  boolean isFire;
  int fireTime = 50;
  int fireFrame = 0;

  float cameraShake = 0;
  boolean isShaking = false;

  boolean onMovingPlatform = false;
  boolean onOil = false;
  boolean oilCD = false;
  float oilCounter;
  float oilTimer = 3f;


  State playerState;

  Player()
  {
    playerWidth = 25;
    playerHeight = 55;
    playerColor = color(155, 0, 0);

    acceleration = new PVector(0, 0);
    acceleration.x = 650f;
    deceleration = new PVector(0, 0);
    deceleration.x = -750f;
    velocity = new PVector(0, 0);
    position = new PVector(width/2, height/2);

    jumpVel = 640f;
    gravity = 9.81f * 144;
    maxGrav = 650f;

    currentDirection = 1;
    onOil = false;    

    SetupSprites();

    //set values once before SetOldPos() is called
    SetNewPos();

    this.SetState(new IdleState());
  }

  public void SetupSprites()
  {
    //load all sprites from data folder    
    idle = new PImage[2];
    String idleName;

    slide = new PImage[5];
    String slideName;

    jump = new PImage[5];
    String jumpName;

    run = new PImage[8];
    String runName;

    fire = new PImage[7];
    String fireName;

    for (int i = 0; i < idle.length; i++)
    {
      //load idle sprites
      idleName = "Sprites/Idle (" + i + ").png";
      idle[i] = loadImage(idleName);
    }
    for (int i = 0; i < jump.length; i++)
    {
      //load jump sprites
      jumpName = "Sprites/Jump (" + i + ").png";
      jump[i] = loadImage(jumpName);
      // //load slide sprites
      // slideName = "Sprites/Slide (" + i + ").png";
      // slide[i] = loadImage(slideName);
      // slide[i].resize(80, 0);
    }

    for (int i = 0; i < 8; i++)
    {
      //load run sprites
      runName = "Sprites/Run (" + i + ").png";
      run[i] = loadImage(runName);
    }
    for (int i = 0; i < 7; i++)
    {
      //load run sprites
      fireName = "Sprites/RobotSpriteFlame" + i + ".png";
      fire[i] = loadImage(fireName);
    }    
  }

  public void SetOldPos()
  {
    //save the old player position before moving the player
    oldTop = top;
    oldBottom = bottom;
    oldRight = right;
    oldLeft = left;
  }

  public void SetPlayerCorners()
  {
    //save the corners of the player sprite to calculate the surrounding tiles    
    corners[0] = new PVector(position.x - (playerWidth/2), position.y - (playerHeight/2));
    corners[1] = new PVector(position.x + (playerWidth/2), position.y - (playerHeight/2));
    corners[2] = new PVector(position.x - (playerWidth/2), position.y + (playerHeight/2));
    corners[3] = new PVector(position.x + (playerWidth/2), position.y + (playerHeight/2));
    corners[4] = new PVector(position.x + (playerWidth/2), player.position.y);
    corners[5] = new PVector(position.x - (playerWidth/2), player.position.y);

    //same the bottom for groundCheck
    playerBottom = new PVector(position.x, position.y + playerHeight/2);

    /*
    topLeft = new PVector(position.x - (playerWidth/2), position.y - (playerHeight/2));
     topRight = new PVector(position.x + (playerWidth/2), position.y - (playerHeight/2));
     bottomLeft = new PVector(position.x - (playerWidth/2), position.y + (playerHeight/2));
     bottomRight = new PVector(position.x + (playerWidth/2), position.y + (playerHeight/2));
     */
  }

  public void Move()
  {
    if(onOil)
    {
      oilCD = true;
      oilCounter = 0f;
      acceleration.x = 75f;
      deceleration.x = -125f;
    }
    else
    {
      if(oilCD)
      {
        //if not on oil, but still oil under feet (cooldown not yet passed)        
        acceleration.x = 125;
        deceleration.x = -200f;

        //reduce cooldown

        oilCounter += deltaTime;
        if(oilCounter >= oilTimer)
        {
          oilCD = false;
          oilCounter = 0f;  
        }
      }
      else
      {
        //no oil under feet, reset acceleration to normal

        acceleration.x = 650f;
        deceleration.x = -750f;  
      }
    }
    
    //accel movement

    if (input.isRight)
    {
      if ( walkingsound.position() == walkingsound.length() && grounded)
      {
        walkingsound.rewind();
        walkingsound.play();
      }
      else if(grounded)
      {
        walkingsound.play();
      }         
      if (velocity.x >= 0)
      {
        ///acceleration.x += 20f * maxSpeed;
        velocity.x += acceleration.x * deltaTime;
        if (velocity.x > maxSpeed)
          velocity.x = maxSpeed;
      } else if (velocity.x + deceleration.x < 0)
      {
        ///deceleration.x -= 20f * turnSpeed;
        velocity.x -= turnSpeed * deceleration.x * deltaTime;
      } else
        ///velocity is lower than 0 but not low enough to add deceleration.
      {
        velocity.x = 0;
      }
    } else if (input.isLeft)
    {
      if ( walkingsound.position() == walkingsound.length() && grounded)
      {
        walkingsound.rewind();
        walkingsound.play();
      }
      else if(grounded)
      {
        walkingsound.play();
      }         
      if (velocity.x <= 0)
      {
        //acceleration.x += 20f * maxSpeed;
        velocity.x -= acceleration.x * deltaTime;
        if (velocity.x < -maxSpeed)
          velocity.x = -maxSpeed;
      } else if (velocity.x - deceleration.x > 0)
      {
        ///deceleration.x -= 20f * turnSpeed;
        velocity.x += turnSpeed * deceleration.x * deltaTime;
      } else
        ///velocity is higher than 0 but not high enough to add deceleration.
      {
        velocity.x = 0;
      }      
    } else
    {
      if (velocity.x + deceleration.x * deltaTime > 0)
      {
        //deceleration.x -= 20f;
        velocity.x += deceleration.x * deltaTime;
      } else if (velocity.x - deceleration.x * deltaTime < 0)
      {
        //deceleration.x -= 20f;
        velocity.x -= deceleration.x * deltaTime;
      } else 
      {
        velocity.x = 0;
      }
    }

    /*
    if (input.isRight)
     {
     acceleration.x = accelRate;
     if (velocity.x > maxSpeed)
     velocity.x = maxSpeed;
     else
     velocity.add(acceleration.mult(deltaTime));
     } else if (input.isLeft)
     {
     acceleration.x = accelRate;
     if (velocity.x < -maxSpeed)
     velocity.x = -maxSpeed;
     else
     {
     velocity.sub(acceleration.mult(deltaTime));
     }
     } 
     else
     {
     if (velocity.x > decelRate * turnSpeed && input.isLeft)
     {
     decelRate *= turnSpeed;
     } 
     if (velocity.x > decelRate * deltaTime)
     {
     acceleration.x = decelRate;
     velocity.sub(acceleration.mult(deltaTime));
     decelRate /= turnSpeed;
     }
     else if (velocity.x < decelRate * turnSpeed && input.isRight)
     {
     decelRate *= turnSpeed;
     }
     if (velocity.x < -decelRate * deltaTime)
     {
     if (input.isRight)
     {
     decelRate *= turnSpeed;
     }
     acceleration.x = decelRate;
     velocity.add(acceleration.mult(deltaTime));
     decelRate /= turnSpeed;
     } 
     else
     {
     acceleration.x = 0;
     velocity.x = 0;
     }
     }
     */

    /*
    //standard left right
     if (input.isRight)
     {
     velocity.x = speed * deltaTime;
     }    
     if (input.isLeft)
     {
     velocity.x = -speed * deltaTime;
     }
     
     if (!input.isRight && !input.isLeft)
     {
     velocity.x = 0;
     }
     */

    /*
    //standard up-down
     if (input.isUp)
     {
     velocity.y = -speed * deltaTime;
     } 
     if (input.isDown)
     {
     velocity.y = speed * deltaTime;
     } 
     if (!input.isUp && !input.isDown)
     {
     velocity.y = 0;
     }
     */

    //jump
    if (input.isSpace && grounded)
    {
      if(!oilCD)
        velocity.y = -jumpVel;  
      else
      {
        velocity.y = -jumpVel/1.5f;
        velocity.x = (velocity.x /4 * 3.5f);  
      }


      grounded = false;
      inAir = true;
      int rand = ceil(random(1,6));
      for(int i = 0; i < rand; i++)
      {
        particle.add(new Particles(new PVector(position.x,position.y+playerHeight/2-1),random(-4,4), random(3,4),0.1f, color(150,75,0,100)));
      }        
      onMovingPlatform = false;
      jumpsound.rewind();
      jumpsound.play();      
    }

    if(input.isSpace)
      jumpHold=true;
    else
      jumpHold = false;

    if(!grounded && velocity.y<-150 && !jumpHold && !powerUpManager.rocketJumpUsing)
    { 
      velocity.y/=1.1f;
    }
  }
public void Climb()
  {
    //linear movement
    velocity.x = 0;
    velocity.y = 0;
    if (input.isRight)
    {       
      position.x += speed * deltaTime;
      velocity.x = 100f;
    } else if (input.isLeft)
    {
      position.x -= speed * deltaTime;
      velocity.x = -100f;  
    }

    if (input.isUp)
    {
      position.y -= climbSpeed * deltaTime;
      velocity.y = -200f;       
    }
    else if (input.isDown)
    {
      position.y += climbSpeed * deltaTime;       
    }
  }  

  public void ApplyGravity()
  {

    if (!grounded)
    {
      //apply gravity

      velocity.y += gravity * deltaTime;
      //don't let player fall faster than maxGravity      
      if (velocity.y > maxGrav)
        velocity.y = maxGrav;
    } else
      velocity.y = 0;
  }

  public void SetNewPos()
  {
    //save position after moving the player    
    top = position.y - playerHeight/2;
    bottom = top + playerHeight;
    right = position.x + playerWidth/2;
    left = right - playerWidth;
  }

  public void fireRocket()
  {   
    if(isFire)
    {
      if(fireTime == 0 || (velocity.y >= -0.5f && velocity.y <= 0.5f))
      {
        isFire = false;
        fireTime = 50;
        fireFrame = 0;
      }
      else fireTime--;       
      if(fireFrame >= fire.length)
        fireFrame = 0;
      image(fire[fireFrame],position.x - camera.shiftX, position.y + playerHeight/2 - camera.shiftY,30,30);
      fireFrame++;
    }
  }
  public void Update()
  {

      if(!grounded)
        lastVelY = velocity.y;

      if(inAir && grounded){
        isShaking = true;
        cameraShake = 3*(lastVelY/maxGrav);      
        inAir = false;
        int rand = ceil(random(1,4));
        for(int i = 0; i < rand; i++)
        {
          particle.add(new Particles(new PVector(position.x,position.y+playerHeight/2-1),random(-4,4), random(2,4),0.1f, color(150,75,0,100)));
        }
      }   

    SetOldPos();
    SetPlayerCorners();
    if(!isClimbing)
    {
      if (powerUpManager.rocketArm == null ||!powerUpManager.rocketArm.pullPlayer/* && !powerUpManager.rocketArm.returnGrapple*/)
      {
         Move();
      }
      else
      {
        velocity.x = 0f;
        velocity.y = 0f;
      }    
    }
    else
    {
      if (powerUpManager.rocketArm == null ||!powerUpManager.rocketArm.pullPlayer && !powerUpManager.rocketArm.returnGrapple)
      {
         Climb();
      }
      else
      {
        velocity.x = 0f;
        velocity.y = 0f;
      }          
    }
    //update player idle, run or jump state
    if(isShaking)
    {
      if (cameraShake > -0.1f && cameraShake < 0.1f)
      {
        isShaking = false;
        cameraShake = 0;
      }
      camera.shiftY += cameraShake;
      cameraShake *= -0.9f;
    }
    playerState.OnTick();
    if(!isClimbing)
    {
      if (powerUpManager.rocketArm == null || !powerUpManager.rocketArm.pullPlayer/* && !powerUpManager.rocketArm.returnGrapple*/)
        ApplyGravity();
    
      //SetDirection();
      position.x += velocity.x * deltaTime;
      position.y += velocity.y * deltaTime;
    }



    SetNewPos();  



    if(boxManager.bottomBox != null && boxManager.boxBottomRight != null && boxManager.boxBottomLeft != null)
    {
      if (boxManager.bottomBox.collides != 1 ||
          boxManager.bottomBox.collides != 5 ||
          boxManager.bottomBox.collides != 15 ||
          boxManager.bottomBox.collides != 16 ||
          boxManager.bottomBox.collides != 17 ||
          boxManager.bottomBox.collides != 18 ||
          boxManager.bottomBox.collides != 12 ||
          boxManager.bottomBox.collides != 10 ||
          boxManager.bottomBox.collides != 14)
      {    
        grounded = false;
      }
    }   
    
  }

   public void GetCollisionDirection(Rectangle box)
  { 
    //check which side of the player collided
    //set that corresponding boolean to true and call ResolveCollision

    if (box.getCollides() == 0)
    {
      grounded = false;
      return;
    } 
    if (oldBottom < box.getTop() && // was not colliding
      bottom >= box.getTop())// now is colliding
    {
      collidedBottom = true;
      //ResolveCollision(box);
    }
    if (oldTop >= box.getBottom() && // was not colliding
      top < box.getBottom())// now is colliding
    {
      collidedTop = true;
      //ResolveCollision(box);
    }
    if (oldLeft >= box.getRight() && // was not colliding
      left < box.getRight())// now is colliding
    {
      collidedLeft = true;

      //ResolveCollision(box);
    }   
    if (oldRight < box.getLeft() && // was not colliding
      right >= box.getLeft()) // now is colliding
    {
      collidedRight = true;
      //ResolveCollision(box);
    }


    if(box.getName() == "Box")
    {
      ResolveCollision(box, "Box");
    }
    else if(box.getName() == "MovingPlatform")
    {
      ResolveCollision(box, "MovingPlatform");
    }
  }

  public void ResolveCollision(Rectangle box, String object)
  {
    if(object == "MovingPlatform")
    {
      if(velocity.y > 0)
      {
      //only collide with moving platform when moving downward        
        if (collidedBottom)
        {
          position.y = box.getY() - box.getHeight()/2 - playerHeight/2 - 0.1f;
          velocity.y = 0;
          grounded = true;
          onMovingPlatform = true;
          collidedBottom = false;
        }
      }
      else
      {
        return;
      }
    }
    else
    {
      if (collidedTop)
      {
        //move the player under the box        
        position.y = box.getY() + box.getHeight()/2 + playerHeight/2 + 0.1f;
        velocity.y = 0;
        collidedTop = false;
      }
      if (collidedBottom)
      {
        //move the player on top of the box        
        position.y = box.getY() - box.getHeight()/2 - playerHeight/2 - 0.1f;
        velocity.y = 0;
        grounded = true;
        collidedBottom = false;
        powerUpManager.rocketJumpUsing = false;         
      } 

      if (collidedRight)
      {
        //move the player left of the box        
        position.x = box.getX() - box.getWidth()/2 - playerWidth/2 - 0.1f;
        velocity.x = 0;
        collidedRight = false;

      }
      if (collidedLeft)
      {
        //move the player right of the box        
        position.x = box.getX() + box.getWidth()/2 + playerWidth/2 + 0.1f;
        velocity.x = 0;
        collidedLeft = false;
      }
    }
    //save new position after changing the player position to outside the colliding box
    SetNewPos();
  }

  public void Draw()
  {
    if (!isDead)
    {
      //draw the idle/run/jump animations      
      pushMatrix();
      fill(playerColor);
      noStroke();
      playerState.OnDraw();
      translate(position.x, position.y);
      //rect(0, 0, playerWidth, playerHeight);
      popMatrix();
      fireRocket();      
    }
  }

  public void DebugText()
  {
    pushMatrix();
    textSize(20);
    fill(textColor);
    translate(100, 105);
    text("Velocity.x: " + velocity.x, 0, 0);
    text("Velocity.y: " + velocity.y, 0, 40);
    text("Acceleration.x: " + acceleration.x, 0, 80);
    text("Acceleration.y * deltaTime: " + (acceleration.y * deltaTime), 0, 120);
    text("Gravity: " + gravity, 0, 160);
    text("Turning: : " + maxSpeed, 0, 200);
    text("fps: " + frameRate, 0, 240);
    text("Pos.x: " + position.x, 0, 520);
    text("Pos y: " + position.y, 0, 560);
    popMatrix();
  }

  public void SetState(State state)
  {
    if (playerState != null)
    {
      playerState.OnStateExit();
    }

    playerState = state;

    if (playerState != null)
    {
      playerState.OnStateEnter();
    }
  }
}
class PowerUpManager
{
  ArrayList<Fuel> fuels = new ArrayList<Fuel>();
  RocketJump rocketJump;
  RocketArm rocketArm;

  PImage rocketJumpIcon = loadImage("PowerUps/RocketJump.png");
  PImage rocketArmIcon = loadImage("PowerUps/RocketArm.png");

  int iconSize = 20;
  int fuelCount = 0;
  int maxFuelCount = 500;
  boolean rocketJumpActive = false;
  boolean rocketArmActive = false;
  boolean rocketJumpUsing = false;


  boolean rocketJumpCD = false;
  boolean rocketArmCD = false;
  float rocketJumpCounter = 0f;
  float rocketArmCounter = 0f;
  float rocketJumpDelay = 2.5f;
  float rocketArmDelay = 2f;

  PowerUpManager()
  {
    SpawnObjects();
  }

  public void SpawnObjects()
  {
  }

  public void Update()
  {
    HandleInput();

    CheckPowerUps();

    UpdatePowerUps();
    
    if(rocketJumpCD)
      RocketJumpCD();
    if(rocketArmCD)
      RocketArmCD();
  }

  public void RocketJumpCD()
  {
    rocketJumpCounter += deltaTime;
    if (rocketJumpCounter > rocketJumpDelay)
    {
      rocketJumpCounter = 0;
      rocketJumpCD = false;
    }
  }
  
  public void RocketArmCD()
  {
    rocketArmCounter += deltaTime;
    if (rocketArmCounter > rocketArmDelay)
    {
      rocketArmCounter = 0;
      rocketArmCD = false;
    }
  }

  public void HandleInput()
  {
    if (input.isK && rocketJumpActive && rocketJump.fuelCost <= fuelCount)
    {
      if(!rocketJumpCD)
      {
        RocketJump();
        rocketJumpCD = true;
        player.isFire = true;
        rocketJumpUsing = true;        
        input.isK = false;
      }
    }

    if (input.isL && rocketArmActive && rocketArm.fuelCost <= fuelCount)
    {
      if(!rocketArmCD)
      {
        RocketArm();
        rocketArmCD = true;
        input.isL = false;
      }
    }
  }

  public void CheckPowerUps()
  {
    if (rocketJump != null && rocketJump.pickedUp)
    {
      rocketJumpActive = true;
    }

    if (rocketArm != null && rocketArm.pickedUp)
    {
      rocketArmActive = true;
    }
  }

  public void UpdatePowerUps()
  {
    if(fuelCount > maxFuelCount)
    {
      fuelCount = maxFuelCount;
    }
    for (int i = 0; i < fuels.size(); i++)
    {
      if(fuels.get(i) != null)         
      fuels.get(i).Update();
    }
    if(rocketJump != null)
      rocketJump.Update();
    if(rocketArm != null)
      rocketArm.Update();
  }

  public void RocketJump()
  {
    fuelCount -= rocketJump.fuelCost;
    player.velocity.y = player.jumpVel * -1.4f;
    player.grounded = false;
  }

  public void RocketArm()
  {
    fuelCount -= rocketArm.fuelCost;
    player.velocity.x /= 2.5f;
    player.velocity.y /= 2.5f;
    rocketArm.position = player.position.copy();
    rocketArm.savedPositions.add(new PVector(rocketArm.position.x, rocketArm.position.y +10));
    rocketArm.oldPos = rocketArm.position.copy();
    if (player.playerState.currentDirection == 0)
    {
      //if facing left
      rocketArm.facingRight = false;
    } else if (player.playerState.currentDirection == 1)
    {
      //else if facing right
      rocketArm.facingRight = true;
    }
    rocketArm.grapple = true;
  }

  public void Draw()
  {
  }

  public void DrawPowerUps()
  {
      for (int i = 0; i < fuels.size(); i++)
      {
        if(fuels.get(i) != null)        
        fuels.get(i).Draw();
      }
    if(rocketJump != null)
      rocketJump.Draw();
    if(rocketArm != null)
      rocketArm.Draw();
  }

  public void DrawIcons()
  {
    // pushMatrix();
    // translate(width, height - 20);
    // if (rocketJumpActive)
    // {
    //   image(rocketJumpIcon, -20, -10, 60, 60);
    // }
    // if (rocketArmActive)
    // {
    //   image(rocketArmIcon, -60, -10, 60, 60);
    // }
    // textSize(24);
    // fill(255);
    // text("Fuel: " + fuelCount, -200, 10);
    // popMatrix();
  }
}
abstract class Rectangle
{
	PVector position;
	float size;
	float rectWidth, rectHeight;
	float top, bottom, left, right;
	int collides;
	String name;
	Box box;

	protected String getName() {
		return name;
	}

	protected float getX()
	{
		return position.x;
	}

	protected float getY()
	{
		return position.y;
	}

	protected float getSize() {
		return size;
	}

	protected float getWidth() {
		return rectWidth;
	}

	protected float getHeight() {
		return rectHeight;
	}

	protected float getTop() {
		return top;
	}

	protected float getBottom() {
		return bottom;
	}

	protected float getLeft() {
		return left;
	}

	protected float getRight() {
		return right;
	}
	protected int getCollides() {
		return collides;
	}
	protected Box getBox() {
		return box;
	}
}
class RocketArm
{
  int rocketArmColor = color(213, 123, 50);
  int size = 10;
  PVector position;
  PVector oldPos = new PVector(0, 0);
  PVector normPos;
  PVector anchorPos;
  ArrayList<PVector> savedPositions = new ArrayList<PVector>();
  int fuelCost = 10;
  boolean grapple = false;
  boolean returnGrapple = false;
  PVector targetPos = new PVector(0, 0);
  int grappleDistance = 600;
  float offset = 4.9f;
  boolean pullPlayer = false;
  float speed = 15f;
  boolean facingRight = false;

  boolean pickedUp = false;

  RocketArm(PVector pos)
  {
    position = pos.copy();
  }

  public void Update()
  {
    if(!pickedUp)
      CheckCollision();
    if(!savedPositions.isEmpty())
    if (grapple)
    {
      ShootGrapple();
    }
    if(pullPlayer)
    {
      PullPlayer();
    }
    if (returnGrapple)
    {
      ReturnGrapple();
    }
  }
  
  public void Move()
  {
    position.x += player.velocity.x * deltaTime;
    position.y = player.position.y ;
    if(player.position != null)
    {
      if(oldPos == null)
        println("oldPos null");    
    oldPos.x = player.position.x;
    oldPos.y = player.position.y;
    }
    else
      println("player.position == null");
    
    for(int i = 0; i < savedPositions.size(); i++)
    {
      savedPositions.get(i).x += player.velocity.x * deltaTime;
      savedPositions.get(i).y = player.position.y;
    }
  }

  public void ShootGrapple()
  {
    Move();
    //targetPos = anchors.get(0).position.copy().sub(position);
    if (!facingRight)
    {
      //if facing left
      targetPos = new PVector(-1, 0);
    } else if (facingRight)
    {
      //else if facing right
      targetPos = new PVector(1, 0);
    }

      for (int i = 0; i < boxManager.rows; i++)
      {
        for (int j = 0; j < boxManager.columns; ++j) 
        {
          if(position.x + size/2 > boxManager.boxes[i][j].position.x - boxManager.boxes[i][j].size/2 &&
             position.x - size/2 < boxManager.boxes[i][j].position.x + boxManager.boxes[i][j].size/2 &&
             position.y + size/2 > boxManager.boxes[i][j].position.y - boxManager.boxes[i][j].size/2 &&
             position.y - size/2 < boxManager.boxes[i][j].position.y + boxManager.boxes[i][j].size/2)
          {           
              if (boxManager.boxes[i][j].collides == 1 ||
                  boxManager.boxes[i][j].collides == 5 ||
                  boxManager.boxes[i][j].collides == 15 ||
                  boxManager.boxes[i][j].collides == 16 ||
                  boxManager.boxes[i][j].collides == 17 ||
                  boxManager.boxes[i][j].collides == 18)
              {         
                  grapple = false;
                  returnGrapple = true;
                  targetPos.x *= -1;
                  return;
              }
          }
          }
      }   
    for(int i = 0; i < anchors.size(); i++)
    {
      if(anchors.get(i) != null)
      {
        if (position.dist(anchors.get(i).position.copy()) <= 20f)
        {
          pullPlayer = true;
          grapple = false;
          anchorPos = anchors.get(i).position.copy();
          return;
        } 
      }
    }
      
        if (Math.abs(position.x - oldPos.x) > grappleDistance)
        {
          grapple = false;
          returnGrapple = true;
          //flip grapple move direction
          targetPos.x *= -1;
          return;
        } 
        else
        {
          position.x += targetPos.x * speed;

          if (Math.abs(position.x - savedPositions.get(savedPositions.size()-1).x) >= offset)
          {
            savedPositions.add(new PVector(position.x, position.y));
          }
        }
      
  }

  public void PullPlayer()
  {
    if (!savedPositions.isEmpty())
    {
    if (Math.abs(player.position.x - savedPositions.get(0).x) <= 10f)
      savedPositions.remove(0);
    }    

    //move the player towards the anchor    
    //for(int i = 0; i < anchors.size(); i++)
    {
      
      if(savedPositions.isEmpty())
      {
          savedPositions.removeAll(savedPositions);
          pullPlayer = false;
          if(facingRight)
            player.position.x = anchorPos.copy().x - player.playerWidth/2;
          else
            player.position.x = anchorPos.copy().x + player.playerWidth/2;

          player.position.y = anchorPos.y - player.playerHeight/2;          
      }
    }
    normPos = new PVector(0.7f,1);
    if(!facingRight && normPos.x > 0)
      normPos.x *= -1;
    player.position.x += normPos.x * speed;
  }

  public void ReturnGrapple()
  {
    Move();
    if (!savedPositions.isEmpty())
    {
      savedPositions.remove(savedPositions.size()-1);
    }

    if (Math.abs(position.x - player.position.x) <= 10f)
    {
      savedPositions.removeAll(savedPositions);
      returnGrapple = false;
    }

    position.x += targetPos.x * speed;
  }

  public void CheckCollision()
  {
    if (position.x + size/2 > player.position.x - player.playerWidth/2 && 
      position.x - size/2 < player.position.x + player.playerWidth/2 && 
      position.y + size/2 > player.position.y - player.playerHeight/2 &&
      position.y - size/2 < player.position.y + player.playerHeight/2)
    {
      pickedUp = true;
      powerUpManager.fuelCount += 20;
    }
  }

  public void Draw()
  {
    fill(rocketArmColor);

    if (!pickedUp)
    {
      pushMatrix();
      translate(position.x - camera.shiftX, position.y - camera.shiftY);
      image(powerUpManager.rocketArmIcon,0, 0, size*3, size*3);
      popMatrix();
    }

    if (grapple || returnGrapple || pullPlayer)
    {
      for (int i = 0; i < savedPositions.size(); i++)
      {
        image(hookMiddle,savedPositions.get(i).x - camera.shiftX, savedPositions.get(i).y - camera.shiftY, size*2, size);
      }
      fill(255, 0, 0);
      if (!facingRight)
        triangle(position.x - size - offset - camera.shiftX, position.y - camera.shiftY, position.x - offset - camera.shiftX, position.y - size/2 - camera.shiftY, position.x - offset - camera.shiftX, position.y + size/2 - camera.shiftY);
      else if (facingRight)
        triangle(position.x + size + offset - camera.shiftX, position.y - camera.shiftY, position.x + offset - camera.shiftX, position.y - size/2 - camera.shiftY, position.x + offset - camera.shiftX, position.y + size/2 - camera.shiftY);
    }
  }
}
class RocketJump
{
  int rocketJumpColor = color(0, 155, 155);
  int size = 30;
  PVector position;
  int fuelCost = 10;
  
  boolean pickedUp = false;
  
  RocketJump(PVector pos)
  {
    position = pos.copy();
  }
  
  public void Update()
  {
    if(!pickedUp)
      CheckCollision();
  }
  
  public void CheckCollision()
  {
    if(position.x + size/2 > player.position.x - player.playerWidth/2 && 
       position.x - size/2 < player.position.x + player.playerWidth/2 && 
       position.y + size/2 > player.position.y - player.playerHeight/2 &&
       position.y - size/2 < player.position.y + player.playerHeight/2)
       {
         pickedUp = true;
         powerUpManager.fuelCount += 20;
       }
  }
  
  public void Draw()
  {
    pushMatrix();
    fill(rocketJumpColor);
    translate(position.x - camera.shiftX, position.y - camera.shiftY);
    if(!pickedUp)
      image(powerUpManager.rocketJumpIcon,0, 0, size, size);
    popMatrix();
  }
  
}
public class RunState extends State
{
   PVector velocity;
  float animationSpeed;
  float currentFrame;
  //int currentDirection;
  final int LEFT = 0, RIGHT = 1;
  
  public void OnStateEnter()
  {
    
    animationSpeed = 0.25f;
    if(player == null)
    {
      currentDirection = 1;
    }
    else
    {
      currentDirection = player.currentDirection;
    }
  }
   public void OnTick()
  {
    velocity = player.velocity.copy();
    currentFrame = (currentFrame + animationSpeed) % 8;    
    
    if(velocity.x == 0)
    {
      player.SetState(new IdleState());
    }
    if(velocity.y != 0)
    {
      player.SetState(new JumpState());
    }
    if(velocity.x > 0)
    {
      currentDirection = RIGHT;
    }
    else if(velocity.x < 0)
    {
      currentDirection = LEFT;
    }
  }
   public void OnDraw()
  {
    
    pushMatrix();
    translate(player.position.x - camera.shiftX, player.position.y - camera.shiftY);
    if(currentDirection == RIGHT)
    {
      image(player.run[PApplet.parseInt(currentFrame)], 0, 0);
    }
    else if(currentDirection == LEFT)
    {
       pushMatrix();
       scale(-1.0f, 1.0f);
       image(player.run[PApplet.parseInt(currentFrame)],0 ,0);
       popMatrix();
    }
    popMatrix();
  }
   public void OnStateExit()
  {
    
    player.currentDirection = currentDirection;
  }
}
public void extraSetup()
{
  //------Classes------
  camera = new Camera();
  player= new Player();
  gameManager = new GameManager();
  debug = new Debug();
  checkPointManager = new CheckPointManager();
  gameManager = new GameManager();  
  //player = new Player(50);

  basicEnemy = new PImage[4];
  bolts = new PImage[7];
  goldenBolts = new PImage[7];

  electricOrb = new PImage[4];
  electricOrbPurple = new PImage[4];
  bolt = new AudioPlayer[3];
  //------Image stuff------

  tileBox = loadImage("Textures/box.png");

  boxLinks= loadImage("Textures/box_links.png");
  boxOmhoog= loadImage("Textures/box_omhoog.png");
  boxOmlaag= loadImage("Textures/box_omlaag.png");
  boxRechts= loadImage("Textures/box_rechts.png");
  boxCornerLinksBoven= loadImage("Textures/box_corner_linksboven.png");
  boxCornerLinksOnder= loadImage("Textures/box_corner_linksonder.png");
  boxCornerRechtsBoven= loadImage("Textures/box_corner_rechtsboven.png");
  boxCornerRechtsOnder= loadImage("Textures/box_corner_rechtsonder.png");

  boxCornerPointRechtsBoven= loadImage("Textures/box_corner_pointrechtsboven.png");
  boxCornerPointRechtsOnder= loadImage("Textures/box_corner_pointrechtsonder.png");
  boxCornerPointLinksBoven= loadImage("Textures/box_corner_pointlinksboven.png");
  boxCornerPointLinksOnder= loadImage("Textures/box_corner_pointlinksonder.png");

  box2CornerLinks= loadImage("Textures/box_2corner_links.png");
  box2CornerRechts= loadImage("Textures/box_2corner_rechts.png");
  box2CornerBoven= loadImage("Textures/box_2corner_boven.png");
  box2CornerOnder= loadImage("Textures/box_2corner_onder.png");
  box2CornerRechtsBovenLinksOnder= loadImage("Textures/box_2corner_rechtsboven_linksonder.png");
  box2CornerRechtsOnderLinksBoven= loadImage("Textures/box_2corner_rechtsonder_linksboven.png");
  box2LaagVerticaal= loadImage("Textures/box_2laag_vertical.png");
  box2LaagZijwaards= loadImage("Textures/box_2laag_zijwaards.png");
  
  box3CornerNietLinksBoven= loadImage("Textures/box_3corner_nietlinksboven.png");
  box3CornerNietLinksOnder= loadImage("Textures/box_3corner_nietlinksonder.png");
  box3CornerNietRechtsBoven= loadImage("Textures/box_3corner_nietrechtsboven.png");
  box3CornerNietRechtsOnder= loadImage("Textures/box_3corner_nietrechtsonder.png");
  box4Corner= loadImage("Textures/box_4corner.png");
  
  box3PointDown= loadImage("Textures/box_3point_down.png");
  box3PointLeft= loadImage("Textures/box_3point_left.png");
  box3PointRight= loadImage("Textures/box_3point_right.png");
  box3PointUp= loadImage("Textures/box_3point_up.png");
  boxCornerRechtsOnderLaagLinks= loadImage("Textures/box_corner_rechtsonder_laaglinks.png");
  boxCornerRechtsOnderLaagBoven= loadImage("Textures/box_corner_rechtsonder_laagboven.png");
  boxCornerRechtsBovenLaagOnder= loadImage("Textures/box_corner_rechtsboven_laagonder.png");
  boxCornerLinksBovenLaagOnder= loadImage("Textures/box_corner_linksboven_laagonder.png");
  boxCornerLinksOnderLaagBoven= loadImage("Textures/box_corner_linksonder_laagboven.png");
  boxCornerLinksBovenLaagRechts= loadImage("Textures/box_corner_linksboven_laagrechts.png");
  box2CornerLinksOnderRechtsOnderLaagBoven = loadImage("Textures/box_2corner_linksonder_rechtsonder_laagboven.png");
  
  boxCornerLinksBovenLaagRechtsLaagOnder= loadImage("Textures/box_corner_linksboven_laagrechts_laagonder.png");
  boxCornerLinksOnderLaagRechtsLaagBoven= loadImage("Textures/box_corner_linksonder_laagrechts_laagboven.png");
  boxCornerRechtsBovenLaaglinksLaagOnder= loadImage("Textures/box_corner_rechtsboven_laaglinks_laagonder.png");
  boxCornerRechtsOnderLaaglinksLaagBoven= loadImage("Textures/box_corner_rechtsonder_laaglinks_laagboven.png");

  secret = loadImage("Textures/box.png");
  tileSteelPillar = loadImage("Textures/steel_pillar.png");
  tileSmallPlatformTopRight = loadImage("Textures/small_platform_top_right.png");
  tileSmallPlatformPillarRight = loadImage("Textures/small_platform_pillar_right.png");
  tileSmallPlatformTopLeft = loadImage("Textures/small_platform_top_left.png");
  tileSmallPlatformPillarLeft = loadImage("Textures/small_platform_pillar_left.png");
  tileMiniPlatformTop = loadImage("Textures/mini_platform_top.png");
  steelPlatformLeft = loadImage("Textures/steel_platform_left.png");
  steelPlatformMiddle = loadImage("Textures/steel_platform_middle.png");
  steelPlatformRight = loadImage("Textures/steel_platform_right.png");
  steelPlatformMiddle2 = loadImage("Textures/steel_platform_middle_2.png");
  overgrownLeft = loadImage("Textures/overgrown_platform.png");
  overgrownMiddle = loadImage("Textures/overgrown_platform_2.png");
  overgrownRight = loadImage("Textures/overgrown_platform_4.png");
  hookMiddle = loadImage("Textures/hook_middle.png");
  hookTop = loadImage("Textures/hook_top.png");
  exitDoor = loadImage("Textures/Door_open.png");
  enterDoor = loadImage("Textures/Door_locked.png");
  ladder = loadImage("Textures/Ladder.png");
  deathOrb = loadImage("Textures/DeathOrb.png");
  switch0 = loadImage("Textures/LeverBlock0.png");
  switch1 = loadImage("Textures/LeverBlock1.png");
  water0 = loadImage("Textures/WaterNormie(0).png");
  underwater0 = loadImage("Textures/Underwater1.png");
  underwater1 = loadImage("Textures/Underwater2.png");
  magnetTex = loadImage("Textures/MagnetSprite.png");
  grappleTex = loadImage("Textures/GrapplePlatform.png");
  background = loadImage("background.png");
  biskitGames = loadImage("BiskitGames.png");

  wireStart = loadImage("Textures/Wires_start_point.png");
  wireHeel = loadImage("Textures/Wires_heel.png");
  wireHeel2 = loadImage("Textures/Wires_heel_2.png");
  wireCompleet = loadImage("Textures/Wires_complete.png");
  wireStartBroken = loadImage("Textures/Wires_start_point_broken.png");
  wireHeelBroken = loadImage("Textures/Wires_broken.png");
  wireHeel2Broken = loadImage("Textures/Wires_broken_2.png");
  wireCompleetBroken = loadImage("Textures/Wires_complete_broken.png");  

  tutorialA = loadImage("Textures/Tutorial/Tutorial_A_groot.png");
  tutorialD = loadImage("Textures/Tutorial/Tutorial_D_groot.png");
  tutorialW = loadImage("Textures/Tutorial/Tutorial_W_jump_groot.png");
  tutorialDeath = loadImage("Textures/Tutorial/Tutorial_death_warning.png");
  tutorialLadderW = loadImage("Textures/Tutorial/Tutorial_W_ladder_groot.png");
  tutorialLadderS = loadImage("Textures/Tutorial/Tutorial_S_ladder_groot.png");
  tutorialX = loadImage("Textures/Tutorial/Tutorial_X_groot.png");
  tutorialZ = loadImage("Textures/Tutorial/Tutorial_Z_groot.png");
  tutorialK = loadImage("Textures/Tutorial/Tutorial_K_groot.png");
  tutorialL = loadImage("Textures/Tutorial/Tutorial_L_groot.png");
  tutorialSecret = loadImage("Textures/Tutorial/Tutorial_Secret_point.png");
  tutorialEnd = loadImage("Textures/Tutorial/Tutorial_Victory.png");

  uiScreen = loadImage("ui/screen.png");
  uiScreenEmpty = loadImage("ui/screenEmpty.png");
  uiScreenOverlay = loadImage("ui/screenOverlay.png");
  uiScreen2 = loadImage("ui/screen2.png");
  uiScreen2Overlay = loadImage("ui/screen2Overlay.png");

  uiScreenGreen = loadImage("ui/screenGreen.png");
  uiScreenOverlayGreen = loadImage("ui/screenOverlayGreen.png");
  uiScreen2Green = loadImage("ui/screen2Green.png");
  uiScreen2OverlayGreen = loadImage("ui/screen2OverlayGreen.png");

  uiScreen3 = loadImage("ui/screen3.png");
  uiScreen3Overlay = loadImage("ui/screen3Overlay.png");
  uiScreen4 = loadImage("ui/screen4.png");
  uiScreen4Overlay = loadImage("ui/screen4Overlay.png");

  rocketArmCooldown = loadImage("ui/rocketArmCooldown.png");
  rocketArmCooldownOverlay = loadImage("ui/rocketArmCooldownOverlay.png");
  rocketArmNotEquiped = loadImage("ui/rocketArmNotEquiped.png");
  rocketArmReady = loadImage("ui/rocketArmReady.png");

  rocketJumpCooldown = loadImage("ui/rocketJumpCooldown.png");
  rocketJumpCooldownOverlay = loadImage("ui/rocketJumpCooldownOverlay.png");
  rocketJumpNotEquiped = loadImage("ui/rocketJumpNotEquiped.png");
  rocketJumpReady = loadImage("ui/rocketJumpReady.png");

  for (int i = 0; i < basicEnemy.length; i++)
  {
    //load enemy run sprites
    basicEnemy[i] = loadImage("Sprites/RobotOvergrownRun (" + i + ").png");
    electricOrb[i] = loadImage("Sprites/ElectricOrb" + i + ".png");
    electricOrbPurple[i] = loadImage("Sprites/PurpleElectricOrb" + i + ".png");    
  }

  for (int i = 0; i < 7; ++i) {
    bolts[i] = loadImage("Textures/CurrencyBolt(" + i + ").png");
  }
  for (int i = 0; i < 7; ++i) {
    goldenBolts[i] = loadImage("Textures/CurrencyGoldBolt(" + i + ").png");
  }  

bossSprite = new PImage();
  String bossSpriteName;







  //load the sprites
  idle = new PImage[6];
  String idleName;

  charge = new PImage[4];
  String chargeName;

  blueCharge = new PImage[6];
  String blueChargeName;

  chargeImpact = new PImage[8];
  String chargeImpactName;

  stunned = new PImage[5];
  String stunnedName;

  death = new PImage[4];
  String deathName;

  laserCharge = new PImage[8];
  String laserChargeName;

  laserFire = new PImage[3];
  String laserFireName;

  bossSpriteName = "Sprites/BossBegin.png";
  bossSprite = loadImage(bossSpriteName);

  //load idle sprites
  for (int i = 0; i < idle.length; i++)
  {
    idleName = "Sprites/BossIdle"+(i+1)+".png";
    idle[i] = loadImage(idleName);
  }

  //load charge sprites
  for (int i = 0; i < charge.length; i++)
  {
    chargeName = "Sprites/BossCharge"+(i+1)+".png";
    charge[i] = loadImage(chargeName);
  }

  //load charge sprites
  for (int i = 0; i < blueCharge.length; i++)
  {
    blueChargeName = "Sprites/BossChargeBlue"+(i+1)+".png";
    blueCharge[i] = loadImage(blueChargeName);
  }

  //load chargeImpact sprites
  for (int i = 0; i < chargeImpact.length; i++)
  {
    chargeImpactName = "Sprites/FireImpact"+(i+1)+".png";
    chargeImpact[i] = loadImage(chargeImpactName);
  }

  //load stunned sprites
  for (int i = 0; i < stunned.length; i++)
  {
    stunnedName = "Sprites/BossStunned"+(i+1)+".png";
    stunned[i] = loadImage(stunnedName);
  }

  //load death sprites
  for (int i = 0; i < death.length; i++)
  {
    deathName = "Sprites/BossDeath"+(i+1)+".png";
    death[i] = loadImage(deathName);
  }

  //load laserCharge sprites
  for (int i = 0; i < laserCharge.length; i++)
  {
    laserChargeName = "Sprites/BossLaserCharge"+(i+1)+".png";
    laserCharge[i] = loadImage(laserChargeName);
  }

  //load laserFire sprites
  for (int i = 0; i < laserFire.length; i++)
  {
    laserFireName = "Sprites/BossLaserFire"+(i+1)+".png";
    laserFire[i] = loadImage(laserFireName);
  }

  fireAnimation = new PImage[10];
  String fireName;

  teslaCoil = new PImage[6];
  String teslaCoilName;

  //load fire sprites
  for (int i = 0; i < fireAnimation.length; i++)
  {
    fireName = "Sprites/FireSprite"+(i+1)+".png";
    fireAnimation[i] = loadImage(fireName);
  }

  //load teslaCoil sprites
  for (int i = 0; i < teslaCoil.length; i++)
  {
    teslaCoilName = "Sprites/TeslaCoilON("+i+").png";
    teslaCoil[i] = loadImage(teslaCoilName);
  }

  grappleGrounded = new PImage[3];
  String grappleGroundedName;

  //load grounded grapple sprites
  for (int i = 0; i < grappleGrounded.length; i++)
  {
    grappleGroundedName = "Sprites/RobotSpriteGrapple("+i+").png";
    grappleGrounded[i] = loadImage(grappleGroundedName);
  }

  grappleMidAir = new PImage[3];
  String grappleMidAirName;

  //load mid-air grapple sprites
  for (int i = 0; i < grappleMidAir.length; i++)
  {
    grappleMidAirName = "Sprites/RobotSpriteMidairGrapple("+i+").png";
    grappleMidAir[i] = loadImage(grappleMidAirName);
  }

  introIdleScreen = new PImage[14];
  String introScreen;

  for(int i = 0; i < 14; i++)
  {
    introScreen = "Introscherm/Menubackground"+(i+1)+".png";
    introIdleScreen[i] = loadImage(introScreen);
  }

  intro = new PImage[27];
  String introFileName;

  for(int i = 0; i < 27; i++)
  {
    introFileName = "Introscherm/Menubackground"+(i+15)+".png";
    intro[i] = loadImage(introFileName);
  }

  //------Font stuff------
  font = createFont("fonts/kenvector_future.ttf", 28);
  pixelFont = createFont("fonts/pixelated.ttf", 36);  
  textFont(font);
  textMode(SHAPE);
  textAlign(CENTER,CENTER);
  //------Variables------
  isMenu = true;

  //------Sounds------
  //main menus sounds
  minim = new Minim(this);
  click = minim.loadFile("Soundeffects/click.mp3");
  click.setGain(10);
  click2 = minim.loadFile("Soundeffects/click2.mp3");
  
  //level music
  levelmusic1 = minim.loadFile("Music/levelMusic1.mp3");
  levelmusic2 = minim.loadFile("Music/levelMusic2.mp3");
  bossLevelMusic = minim.loadFile("Music/bossFightMusic.mp3");

  //Boss sounds
  laserFireSound = minim.loadFile("Soundeffects/Laser_Fire.mp3");
  bossImpact = minim.loadFile("Soundeffects/Boss_Impact.wav");
  bossExplotions = minim.loadFile("Soundeffects/Boss_Explotions.wav");
    
  //Player sounds
  jumpsound = minim.loadFile("Soundeffects/Jump_sound_3.wav");
  walkingsound = minim.loadFile("Soundeffects/walking_metal.wav");
  interactionsound = minim.loadFile("Soundeffects/interaction_switch.wav");
  //jumpsound = minim.loadFile("Soundeffects/Jump_sound_3.wav");
  //Enemy sounds

  //Bolts sounds
  for (int i = 0; i < bolt.length; i++)
  {
    bolt[i] = minim.loadFile("Soundeffects/Bolt"+ (i+1) +".wav");
    bolt[i].setGain(-50 + volume[1]);
  }


  //Condition sounds


  //main menu music
  if(month() == 10 && day() == 31)
  mainMusic = minim.loadFile("Music/mainMusic3.mp3");
  else {
    int rand = round(random(1,2));
    mainMusic = minim.loadFile("Music/mainMusic"+ rand +".mp3");
  }
  //Music
  mainMusic.setGain(-40 + volume[0]);

  //Sound effects

  laserFireSound.setGain(-40 + volume[1]);
  bossImpact.setGain(-40 + volume[1]);
  bossExplotions.setGain(-40 + volume[1]);
  click.setGain(-40 + volume[1]);
  click2.setGain(-40 + volume[1]);
  jumpsound.setGain(-40 + volume[1]);
  walkingsound.setGain(-40 + volume[1]);
  interactionsound.setGain(-40 + volume[1]);
  mainMusic.loop();  


}
class SlipperyTile
{
	PVector position;
	boolean underPlayer;
	float size;

	SlipperyTile(PVector pos)
	{
		position = pos;
		underPlayer = false;
		size = 40f;
	}

	public void updateSlipperyTile()
	{
		if(abs(player.position.x - position.x) < (player.playerWidth/2) && position.y - player.position.y <= player.playerHeight + boxManager.boxSize)
		{
			underPlayer = true;
		}
		else
		{
			underPlayer = false;	
		}
	}

	public void drawSlipperyTile()
	{
		pushMatrix();
		translate(position.x, position.y);
		rect(0, 0, size, size);
		popMatrix();
	}
}
public abstract class State
{
	//direction the player is facing
	public int currentDirection;

	//called once when the new state is assigned
	public void OnStateEnter(){}

	//update method where all the calculations are done
	public abstract void OnTick();

	//draw method where everything is drawn
	public abstract void OnDraw();

	//exit method that gets called once when a state is switching to another state
	public void OnStateExit(){} 
}
  public void settings() {  size(1280,720,P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#030303", "--hide-stop", "FWTBT_Prototype_2_0" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
