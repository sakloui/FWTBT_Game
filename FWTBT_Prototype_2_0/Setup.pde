void extraSetup()
{
  //------Classes------
  menu = new Menu();
  //player = new Player(50);
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
  hookMiddle = loadImage("Textures/hook_middle.png");
  hookTop = loadImage("Textures/hook_top.png");
  background = loadImage("background.png");
  //------Font stuff------
  font = createFont("kenvector_future.ttf", 28);
  textFont(font);
  textMode(SHAPE);
  textAlign(CENTER,CENTER);
  //------Variables------
  isMenu = true;

  //------Sounds------
  minim = new Minim(this);
  minim2 = new Minim(this);
  click = minim.loadFile("click.mp3");
  click.setGain(10);
  click2 = minim.loadFile("click2.mp3");
  if(month() == 10 && day() == 31)
  mainMusic = minim2.loadFile("mainMusic3.mp3");
  else {
    int rand = round(random(1,2));
    mainMusic = minim2.loadFile("mainMusic"+ rand +".mp3");
  }

  mainMusic.setGain(-40 + volume[0]);

  click.setGain(-40 + volume[1]);
  click2.setGain(-40 + volume[1]);

  mainMusic.loop();


}
