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

  for (int i = 0; i < rows; i++)
  {
    for (int j = 0; j < columns; j++)
    {
      if (i == 19)
      {
        if (j > 14)
        {
          coll = true;
        } else
          coll = false;
      } else if (j == 17)
      {
        if (i < 20)
        {
          coll = true;
        } else
          coll = false;
      } else
        coll = false;
      boxes[i][j] = new Box(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j), boxSize, coll);
    }
  }
}

void CalculateCurrentTiles()
{
  float xPercentage, yPercentage;
  for (int i = 0; i < player.corners.length; i++)
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

  for (int i = 0; i < rows; i++)
  {
    for (int j = 0; j < columns; j++)
    {
      boxes[i][j].groundColor = color(255);
      /*
      if(boxes[i][j].collides)
       boxes[i][j].CheckCollision();
       */
    }
  }

  ArrayList<Box> over = new ArrayList<Box>();
  ArrayList<Box> surrounding = new ArrayList<Box>();

  for (int i = 0; i < 6; i++)
  {
    if (xTile[i] >= 32 || xTile[i] <= 0);
    else if (yTile[i] >= 18 || yTile[i] <= 0);
    else
    {
      Box box = boxes[xTile[i]][yTile[i]];

      if (!over.contains(box))
      {
        over.add(box);
      }
    }
  }

  for (int i = 0; i < 6; i++)
  {
    if (xTile[i] >= 32 || xTile[i] + 1 >= 32 || xTile[i] <= 0 || xTile[i] - 1 <= 0);
    else if (yTile[i] >= 18 || yTile[i] + 1 >= 18 || yTile[i] <= 0 || yTile[i] - 1 <= 0);
    else
    {
      Box boxTop = boxes[xTile[i]][yTile[i]-1];
      Box boxBottom = boxes[xTile[i]][yTile[i]+1];
      Box boxRight = boxes[xTile[i]-1][yTile[i]];
      Box boxLeft = boxes[xTile[i]+1][yTile[i]]; 

      if (!surrounding.contains(boxTop) && !over.contains(boxTop))
      {
        surrounding.add(boxTop);
      }
      if (!surrounding.contains(boxBottom) && !over.contains(boxBottom))
      {
        surrounding.add(boxBottom);
      }
      if (!surrounding.contains(boxRight) && !over.contains(boxRight))
      {
        surrounding.add(boxRight);
      }
      if (!surrounding.contains(boxLeft) && !over.contains(boxLeft))
      {
        surrounding.add(boxLeft);
      }
    }
  }

  for (int i = 0; i < over.size(); i++)
  {
    over.get(i).groundColor = color(0, 200, 0);
  }
  for (int i = 0; i < surrounding.size(); i++)
  {
    surrounding.get(i).groundColor = color(150, 0, 150);
    if (surrounding.get(i).collides)
      surrounding.get(i).CheckCollision();
  }

  //----------Draws----------
  background(200, 200, 200);
  for (int i = 0; i < rows; i++)
  {
    for (int j = 0; j < columns; j++)
    {
      boxes[i][j].Draw();
    }
  }
  for (int i = 0; i < surrounding.size(); i++)
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
