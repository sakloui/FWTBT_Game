Player player;
Input input = new Input();
int amount = 32;

float size;
int rows = 32;
int columns = 18;

PImage img;
  
 Box[][] boxes;


float lastTime;
float deltaTime;

void setup()
{
  size(1280, 720);
  rectMode(CENTER);
  frameRate(100);


  img = loadImage("map.png");
  img.loadPixels();

  boxes = new Box[img.width][img.height];

  player = new Player();

  size = 40;

  boolean coll;
  
  for(int x = 0; x < img.width; x++)
  {
    for(int y = 0; y < img.height; y++)
    {
      int p = x + (y * img.width);
      if(img.pixels[p] == color(0,0,0)){
        coll = true; 
      } else { 
        coll = false;
      }
      boxes[x][y] = new Box(new PVector(boxSize/2 + boxSize*x, boxSize/2 + boxSize*y), boxSize, coll);
    }
  }
  

}

void draw()
{
  //----------Time----------
  deltaTime = (millis() - lastTime) / 1000;
  lastTime = millis();
  
  //----------Updates----------

  for(int i = 0; i < img.height - 1; i++){
    for(int j = 0; j < img.width - 1; j++){
      if(boxes[j][i].collides)
      boxes[j][i].CheckCollision();
    }
  }
  player.Update();
  
  //----------Draws----------
  background(200, 200, 200);
  for(int i = 0; i < img.height; i++)
  {
    for(int j = 0; j < img.width; j++)
    {
      boxes[j][i].Draw();
    }
  }
  player.Draw();
}

void keyPressed()
{
  input.KeyDown(keyCode, true);
}

void keyReleased()
{
  input.KeyDown(keyCode, false);
}
