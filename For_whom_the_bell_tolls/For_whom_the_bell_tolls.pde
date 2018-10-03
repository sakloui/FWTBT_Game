Player player;
Input input = new Input();
int amount = 32;
float boxSize = 40;
int rows = 32;
int columns = 18;
Box[][] boxes = new Box[rows][columns];

int[] xTile = new int[6];
int[] yTile = new int[6];

float lastTime;
float deltaTime;

void setup()
{
  size(1280, 720);
  rectMode(CENTER);
  frameRate(100);

  player= new Player();
    
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
      boxes[i][j] = new Box(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j), boxSize, coll);
    }
  }
}

void CalculateCurrentTiles()
{
  float xPercentage, yPercentage;
  for(int i = 0; i < player.corners.length; i++)
  {
    xPercentage = player.corners[i].x / width * 100;
    xTile[i] = floor(rows / 100f * xPercentage);  
    yPercentage = player.corners[i].y / height * 100;
    yTile[i] = floor(columns / 100f * yPercentage);
  }
}

void draw()
{
  //----------Time----------
  deltaTime = (millis() - lastTime) / 1000;
  lastTime = millis();
  
  //----------Updates----------
  player.Update();
  
  CalculateCurrentTiles();

  for(int i = 0; i < rows; i++)
  {
    for(int j = 0; j < columns; j++)
    {
      boxes[i][j].groundColor = color(255);
      if(boxes[i][j].collides)
        boxes[i][j].CheckCollision();
    }
  }
  ArrayList<Box> surrounding = new ArrayList<Box>();
  for(int k = 0; k < 6; k++)
  {
    Box box = boxes[xTile[k]][yTile[k]];
    //boxes[xTile[k]][yTile[k]].groundColor = color(0, 200, 0);
    if(!surrounding.contains(box))
    {
      surrounding.add(box);
    }
  }
  
  for(int i = 0; i < surrounding.size(); i++)
  {
    surrounding.get(i).groundColor = color(0, 200, 0);
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
  for(int i = 0; i < surrounding.size(); i++)
  {
    surrounding.get(i).Draw();
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
