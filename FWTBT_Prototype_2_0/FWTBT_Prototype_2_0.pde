import ddf.minim.*;


//------Classes------
Menu menu;
Player player;
//------Image stuff------
PImage map;
PImage tile;
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
AudioPlayer click;
AudioPlayer click2;
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
  player= new Player();

}

void draw()
{
  //------Time------
  deltaTime = (millis() - lastTime) / 1000; //Calculates the diffrence in time between frames
  lastTime = millis();
  
  //------Background Stuff------
  background(0);
  
  //------Gamestate------
  if(isP)isMenu = true;
  
  if(isMenu)
  {
    menu.draw();
  }
  else
  {
    image(background,width/2,height/2);
    player.Update();
    
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
    return;
  }
  rows = map.width;
  columns = map.height;
  boxes = new Box[rows][columns];
  if(rows == 64){
    boxSize = 20;
    player.playerWidth = 20;
    player.playerHeight = 30;
    player.jumpVel = 7.5f;
  }
  else 
  {
    boxSize = 40;
    player.playerWidth = 40;
    player.playerHeight = 60;  
    player.jumpVel = 10f;  
  }
  int coll = 0;
  
  for(int i = 0; i < rows; i++)
  {
    for(int j = 0; j < columns; j++)
    {
      int p = i + (j * rows);
      if(map.pixels[p] == color(0,0,0)){
        coll = 1; 
      }
      if(map.pixels[p] == color(255,100,0)){
        coll = 2; 
      }
      if(map.pixels[p] == color(0,255,0)){
        coll = 3; 
      }      
      if(map.pixels[p] == color(255,255,0)){
        coll = 4; 
      }   
      if(map.pixels[p] == color(0,0,255)){
        coll = 5; 
      }      
      if(map.pixels[p] == color(0,160,255)){
        coll = 6; 
      }         
      if(map.pixels[p] == color(255)) { 
        coll = 0;
      }
      boxes[i][j] = new Box(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j), boxSize, coll);    
    }
  } 
  return;
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
