void extraSetup()
{
  //------Classes------
  menu = new Menu();
  //player = new Player(50);
  //------Image stuff------
  tile = loadImage("Floor2.png");
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
  mainMusic.loop();
}
