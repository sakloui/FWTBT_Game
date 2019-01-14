void extraSetup()
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