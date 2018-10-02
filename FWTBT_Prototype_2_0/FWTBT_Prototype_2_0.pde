import ddf.minim.*;


//------Classes------
Menu menu;
Player player;

//------Image stuff------
PImage map;

//------Font stuff------
PFont font;

//------Variables------
float lastTime,deltaTime;
boolean isMenu;
int currentLevel;

int amount = 32;
float boxSize = 40;
int rows = 32;
int columns = 18;
Box[][] boxes = new Box[rows][columns];

//------Sounds------
Minim minim;
AudioPlayer click;
//------Keys------
boolean isUp,isDown,isRight,isLeft,isSpace;

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
  if(isMenu)
  {
    menu.draw();
  }
  else
  {
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
    background(200, 200, 200);
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

  int coll = 0;
  
  for(int i = 0; i < map.width; i++)
  {
    for(int j = 0; j < map.height; j++)
    {
      int p = i + (j * map.width);
      if(map.pixels[p] == color(0,0,0)){
        coll = 1; 
      }
      if(map.pixels[p] == color(255,0,0)){
        coll = 2; 
      }
      if(map.pixels[p] == color(0,255,0)){
        coll = 3; 
      }      
      if(map.pixels[p] == color(255,255,0)){
        coll = 4; 
      }    
      if(map.pixels[p] == color(255)) { 
        coll = 0;
      }
      boxes[i][j] = new Box(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j), boxSize, coll);
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
