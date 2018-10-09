import ddf.minim.*;


//------Classes------
Menu menu;
Player player;
Camera camera;
//------Image stuff------
PImage map;

PImage tileBox;
PImage tileSteelPillar;
PImage tileSmallPlatformTopRight;
PImage tileSmallPlatformPillarRight;
PImage tileSmallPlatformTopLeft;
PImage tileSmallPlatformPillarLeft;
PImage tileMiniPlatformTop;

PImage background;
//------Font stuff------
PFont font;

//------Variables------
float lastTime,deltaTime;
boolean isMenu;
int currentLevel;

int amount = 32;
float boxSize = 40;


int rows;
int columns;
Box[][] boxes;// = new Box[rows][columns];

//------Sounds------
Minim minim;
Minim minim2;
AudioPlayer click;
AudioPlayer click2;
AudioPlayer mainMusic;
//------Keys------
boolean isUp,isDown,isRight,isLeft,isSpace,isP;

void setup()
{
  size(1280,720,P2D);
  rectMode(CENTER);
  imageMode(CENTER);
  ellipseMode(CENTER);
  background(0);
  extraSetup();
  player = new Player();
  camera = new Camera();

}

void draw()
{
  //------Time------
  deltaTime = (millis() - lastTime) / 1000; //Calculates the diffrence in time between frames
  lastTime = millis();
  
  //------Background Stuff------
  background(0);
  
  //------Gamestate------
  
  
  if(isMenu)
  {
    menu.draw();
  }
  else
  {
    if(isP){isMenu = true;mainMusic.rewind();mainMusic.play();}
    image(background,width/2,height/2);
    
    player.Update();
    
    if (rows > 32){
      camera.UpdateX();
    }
    if (columns > 18){
      camera.UpdateY();
    }
    
    for(int i = 0; i < rows; i++)
    {
      for(int j = 0; j < columns; j++)
      {
        if(boxes[i][j].collides == 1)
          boxes[i][j].CheckCollision();
      }
    }
    
    //----------Draws----------
    //background(200, 200, 200);
    for(int i = 0; i < rows; i++)
    {
      for(int j = 0; j < columns; j++)
      {
        boxes[i][j].Draw();
      }
    }
    player.Draw();
    
  }
  
}

void loadMap(int level)
{

  map = loadImage("level"+level+".png");

  if(map == null)
  {
    menu.level.selectedLevel--;
    isMenu = true;
    mainMusic.rewind();
    mainMusic.play();
    return;
  }
  rows = map.width;
  columns = map.height;
  boxes = new Box[rows][columns];
  boxSize = 40;
  player.playerWidth = 40;
  player.playerHeight = 60;  
  player.jumpVel = 10f;  
  int coll = 0;
  
  for(int i = 0; i < rows; i++)
  {
    for(int j = 0; j < columns; j++)
    {
      int p = i + (j * rows);
      
      //gameplay
      
      //spawn
      if(map.pixels[p] == color(0,255,0)){
        coll = 3; 
      }      
      
      //victory
      if(map.pixels[p] == color(255,255,0)){
        coll = 4; 
      }  
      
      //water
      if(map.pixels[p] == color(0,0,255)){
        coll = 5; 
      }
      
      //secret
      if(map.pixels[p] == color(0,160,255)){
        coll = 6; 
      }
      
      //magneet
      if(map.pixels[p] == color(150,150,150)){
        coll = 7; 
      }
      
      //victory condition change  
      if(map.pixels[p] == color(255,255,100)){
        coll = 8;
      }
      //elektrisch draad
      if(map.pixels[p] == color(255,100,0)){
        coll = 2; 
      }
      
      //graphics
      //box
      if(map.pixels[p] == color(0,0,0)){
        coll = 1; 
      }
      
      //small platform top right
      if(map.pixels[p] == color(0,5,0)){
        coll = 10;
      }  
      //small platform pillar right
      if(map.pixels[p] == color(0,10,0)){
        coll = 11;
      }  
      //small platform top left
      if(map.pixels[p] == color(5,0,0)){
        coll = 12;
      }
      //small platform pillar right
      if(map.pixels[p] == color(10,0,0)){
        coll = 13;
      } 
      //mini platform top
      if(map.pixels[p] == color(0,0,5)){
        coll = 14;
      } 
      
      if(map.pixels[p] == color(255)) { 
        coll = 0;
      }
      boxes[i][j] = new Box(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j), boxSize, coll);
      if(rows > 32)boxes[i][j].dist = 30/(rows/32);
      
    }
  } 
  return;
}

void updateGrid()
{
  for(int i = 0; i < rows; i++)
  {
    for(int j = 0; j < columns; j++)
    {  
      if(boxes[i][j].collides == 9){
        boxes[i][j].collides = 0;
      }
    }
  }
}


 boolean SetMove(int k, boolean b)
  {
    switch(k)
    {
    case 'W':
    case UP:
      return isUp = b;
    case 'S':
    case DOWN:
      return isDown = b;
    case 'A':
    case LEFT:
      return isLeft = b;
    case 'D':
    case RIGHT:
      return isRight = b;
    case 32:
      return isSpace = b;
    case 'P':
      return isP = b;      
    default:
      return b;
    }
  }
  
void keyPressed()
{
  SetMove(keyCode, true);
}

void keyReleased()
{
  SetMove(keyCode, false);
}
