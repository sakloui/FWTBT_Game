class BoxManager
{
  float boxSize = 40;
  int rows = 32;
  int columns = 18;
  Box[][] boxes = new Box[rows][columns];

  ArrayList<Box> over = new ArrayList<Box>();
  ArrayList<Box> surrounding = new ArrayList<Box>();
  Box bottomBox;

  int[] xTile = new int[6];
  int[] yTile = new int[6];
  int xBottom, yBottom;

  BoxManager(int level)
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
    camera.shiftX = 0;
    camera.shiftY = 0;

    //select the boxes that the player collides with
    PlaceCollisionBoxes();
  }

  void PlaceCollisionBoxes()
  {



    for(int i = 0; i < rows; i++)
      {
        for(int j = 0; j < columns; j++)
        {
          int coll = 0;
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
          if(map.pixels[p] == color(150,150,150)){
            coll = 7;
          }
          if(map.pixels[p] == color(255,255,100)){
            coll = 8;
          }
          if(map.pixels[p] == color(0,0,100)){
            coll = 9;
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

          boxes[i][j] = new Box(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j), boxSize, coll);

        }
      }
  }

  void Update()
  {
    over = new ArrayList<Box>();
    surrounding = new ArrayList<Box>();

    CalculateCurrentTiles();
    SetOverCells();
    SetSurroundingCells();
    SetGridColor();
    CheckCollisions();
  }

  void CalculateCurrentTiles()
  {
    //get the tiles where the corners of the player are located in
    float xPercentage, yPercentage;
    for (int i = 0; i < player.corners.length; i++)
    {
      xPercentage = player.corners[i].x / (width * (rows / 32))  * 100;
      xTile[i] = floor(rows / 100f * xPercentage);
      println(rows / 100f + " " + xPercentage);
      println(xTile[i]);      
      yPercentage = player.corners[i].y / (height * (columns / 18)) * 100;
      yTile[i] = floor(columns / 100f * yPercentage);
    }

    xPercentage = player.playerBottom.x / width * 100;
    xBottom = floor(rows / 100f * xPercentage);
    yPercentage = player.playerBottom.y / height * 100;
    yBottom = floor(columns / 100f * yPercentage);
  }

  void SetOverCells()
  {
    for (int i = 0; i < 6; i++)
    {
      if (xTile[i] >= rows || xTile[i] <= 0);
      else if (yTile[i] >= columns || yTile[i] <= 0);
      else
      {
        Box box = boxes[xTile[i]][yTile[i]];

        if (!over.contains(box))
        {
          over.add(box);
        }
      }
    }
  }

  void SetSurroundingCells()
  {
    for (int i = 0; i < 6; i++)
    {
      //if cell is within the array of cells
      if (xTile[i] >= rows || xTile[i] + 1 >= rows || xTile[i] <= 0 || xTile[i] - 1 < 0);
      else if (yTile[i] >= columns || yTile[i] + 1 >= columns || yTile[i] <= 0 || yTile[i] - 1 < 0);
      else
      {
        Box boxTop = boxes[xTile[i]][yTile[i]-1];
        Box boxBottom = boxes[xTile[i]][yTile[i]+1];
        Box boxRight = boxes[xTile[i]-1][yTile[i]];
        Box boxLeft = boxes[xTile[i]+1][yTile[i]];
        Box boxTopLeft = boxes[xTile[i]-1][yTile[i]-1];
        Box boxTopRight = boxes[xTile[i]+1][yTile[i]-1];
        Box boxBottomLeft = boxes[xTile[i]-1][yTile[i]+1];
        Box boxBottomRight = boxes[xTile[i]+1][yTile[i]+1];

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

        if (!surrounding.contains(boxTopLeft) && !over.contains(boxTopLeft))
        {
          surrounding.add(boxTopLeft);
        }
        if (!surrounding.contains(boxTopRight) && !over.contains(boxTopRight))
        {
          surrounding.add(boxTopRight);
        }
        if (!surrounding.contains(boxBottomLeft) && !over.contains(boxBottomLeft))
        {
          surrounding.add(boxBottomLeft);
        }
        if (!surrounding.contains(boxBottomRight) && !over.contains(boxBottomRight))
        {
          surrounding.add(boxBottomRight);
        }
      }
    }
    if (xBottom + 1 >= rows || xBottom - 1 < 0);
    else if (yBottom + 1 >= columns || yBottom - 1 < 0);
    else
      bottomBox = boxes[xBottom][yBottom];
  }

  void SetGridColor()
  {
    // //background cells
    // for (int i = 0; i < rows; i++)
    // {
    //  for (int j = 0; j < columns; j++)
    //  {
    //    if(boxes[i][j].collides == 50)
    //    boxes[i][j].collides = 0;
    //  }
    // }

    // //over cells
    // for (int i = 0; i < over.size(); i++)
    // {
    //  if(over.get(i).collides == 0){
    //  over.get(i).collides = 50;
    //  over.get(i).groundColor = color(255);
    // }
    // }
  }

  void CheckCollisions()
  {
    //check for collisions on the surrounding cells that the player can collide with
    for (int i = 0; i < surrounding.size(); i++)
    {
      //set the surrounding cells color
      surrounding.get(i).groundColor = color(150, 0, 150);
      //check for collisions
      // println(surrounding.get(i).collides);
      // println(surrounding.get(i).position.x + " " + player.position.x);      
      if (surrounding.get(i).collides == 1)
        surrounding.get(i).CheckCollision();

      if (surrounding.get(i).collides == 12 ||
         surrounding.get(i).collides == 10)
        surrounding.get(i).CheckCollisionTop();
    }
  }

  void DrawBoxes()
  {
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
  }
}
