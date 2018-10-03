void extraSetup()
{
  //------Classes------
  menu = new Menu();
  //player = new Player(50);
  //------Image stuff------
  tile = loadImage("Floor2.png");
  
  //------Font stuff------
  font = createFont("kenvector_future.ttf", 28);
  textFont(font);
  textMode(SHAPE);
  textAlign(CENTER,CENTER);
  //------Variables------
  isMenu = true;
  
  //------Sounds------
  minim = new Minim(this);
  click = minim.loadFile("click.mp3");
  click.setGain(10);
}
