void extraSetup()
{
  //------Classes------
  camera = new Camera();
  player= new Player();
  checkPointManager = new CheckPointManager();
  gameManager = new GameManager();
  //player = new Player(50);

  basicEnemy = new PImage[4];

  electricOrb = new PImage[4];
  electricOrbPurple = new PImage[4];
  //------Image stuff------
  tileBox = loadImage("Textures/box.png");
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
  uiScreenOverlay = loadImage("ui/screenOverlay.png");
  uiScreen2 = loadImage("ui/screen2.png");
  uiScreen2Overlay = loadImage("ui/screen2Overlay.png");

  uiScreenGreen = loadImage("ui/screenGreen.png");
  uiScreenOverlayGreen = loadImage("ui/screenOverlayGreen.png");
  uiScreen2Green = loadImage("ui/screen2Green.png");
  uiScreen2OverlayGreen = loadImage("ui/screen2OverlayGreen.png");

  uiScreen3 = loadImage("ui/screen3.png");
  uiScreen4 = loadImage("ui/screen4.png");

  for (int i = 0; i < basicEnemy.length; i++)
  {
    //load enemy run sprites
    basicEnemy[i] = loadImage("Sprites/RobotOvergrownRun (" + i + ").png");
    electricOrb[i] = loadImage("Sprites/ElectricOrb" + i + ".png");
    electricOrbPurple[i] = loadImage("Sprites/PurpleElectricOrb" + i + ".png");    
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

  //Player sounds
  jumpsound = minim.loadFile("Soundeffects/Jump_sound_3.wav");
  walkingsound = minim.loadFile("Soundeffects/walking_metal.wav");
  interactionsound = minim.loadFile("Soundeffects/interaction_switch.wav");
  //jumpsound = minim.loadFile("Soundeffects/Jump_sound_3.wav");
  //Enemy sounds


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
  click.setGain(-40 + volume[1]);
  click2.setGain(-40 + volume[1]);
  jumpsound.setGain(-40 + volume[1]);
  walkingsound.setGain(-40 + volume[1]);
  interactionsound.setGain(-40 + volume[1]);
  mainMusic.loop();  


}