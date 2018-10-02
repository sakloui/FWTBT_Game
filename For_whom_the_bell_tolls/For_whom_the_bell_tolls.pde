Player player;
Input input = new Input();
int amount = 32;
float size;
int rows = 32;
int columns = 18;
Box[][] boxes = new Box[rows][columns];

float lastTime;
float deltaTime;

void setup()
{
  size(1280, 720);
  rectMode(CENTER);
  frameRate(100);

   player= new Player();

  size = 40;
    
  boolean coll;
  
  for(int i = 0; i < rows; i++)
  {
    for(int j = 0; j < columns; j++)
    {
      if(i == 19)
      {
        if(j > 14)
        {
          coll = true;
        }
        else
          coll = false;
      }
      else if(j == 17)
      {
        if(i < 20)
        {
          coll = true;
        }
        else
          coll = false;
      }
      else
        coll = false;
      boxes[i][j] = new Box(new PVector(size/2 + size*i, size/2 + size*j), size, coll);
    }
  }
}

void draw()
{
  //----------Time----------
  deltaTime = (millis() - lastTime) / 1000;
  lastTime = millis();
  
  //----------Updates----------
  for(int i = 0; i < rows; i++)
  {
    for(int j = 0; j < columns; j++)
    {
      if(boxes[i][j].collides)
      boxes[i][j].CheckCollision();
    }
  }
  player.Update();
  
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

void keyPressed()
{
  input.KeyDown(keyCode, true);
}

void keyReleased()
{
  input.KeyDown(keyCode, false);
}
