void extraSetup()
{
  //------Classes------
  menu = new Menu();
  //player = new Player(50);
  //------Image stuff------
  tileBox = loadImage("textures/box.png");
  tileSteelPillar = loadImage("textures/steel_pillar.png");
  tileSmallPlatformTopRight = loadImage("textures/small_platform_top_right.png");
  tileSmallPlatformPillarRight = loadImage("textures/small_platform_pillar_right.png");
  tileSmallPlatformTopLeft = loadImage("textures/small_platform_top_left.png");
  tileSmallPlatformPillarLeft = loadImage("textures/small_platform_pillar_left.png");
  tileMiniPlatformTop = loadImage("textures/mini_platform_top.png");
  
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
  int rand = round(random(1,2));
  mainMusic = minim2.loadFile("mainMusic"+ rand +".mp3");
  mainMusic.play();
  mainMusic.loop();
}
