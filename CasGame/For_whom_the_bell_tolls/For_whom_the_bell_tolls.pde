Player player;
Input input;
int amount = 32;
float size;
Box[] boxes = new Box[amount*amount];

float lastTime;
float deltaTime;

void setup()
{
  size(1280, 720);
  rectMode(CENTER);
  frameRate(100);
  
  player = new Player();
  input = new Input();

  int index = 0;
  size = width / amount;
    
  boolean coll;
  
  for(int i = 0; i < amount; i++)
  {
    for(int j = 0; j < amount; j++)
    {
      if(i == 18 && j == 10)
      {
        coll = true;
      }
      else
        coll = false;
      boxes[index] = new Box(new PVector(size/2 + size*i, size/2 + size*j), size, coll);
      index++;
    }
  }
}

void draw()
{
  //----------Time----------
  deltaTime = (millis() - lastTime) / 1000;
  lastTime = millis();
  
  //----------Updates----------
  for(int i = 0; i < boxes.length; i++)
  {
    if(boxes[i].collides)
      boxes[i].CheckCollision();
  }
  player.Update();
  
  //----------Draws----------
  background(200, 200, 200);
  for(int i = 0; i < boxes.length; i++)
  {
    boxes[i].Draw();
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
