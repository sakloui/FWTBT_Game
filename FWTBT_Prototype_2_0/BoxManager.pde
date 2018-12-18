class BoxManager
{
  //----------Properties----------
  float boxSize = 40;
  int rows = 32;
  int columns = 18;
  int level;

  //----------Arrays and lists----------
  Box[][] boxes = new Box[rows][columns];
  Box[][] foreground = new Box[rows][columns];
  
  //----------Surrounding boxes----------
  ArrayList<Box> over = new ArrayList<Box>();
  ArrayList<Box> foreOver = new ArrayList<Box>();
  ArrayList<Box> surrounding = new ArrayList<Box>();
  Box bottomBox;
  Box bottomRightBox;
  Box bottomLeftBox;

  //----------Current player location----------
  int[] xTile = new int[6];
  int[] yTile = new int[6];
  int xBottom, yBottom;
  int[] xEnemyTile = new int[50];
  int[] yEnemyTile = new int[50];  

  Box boxTop;
  Box boxBottom;
  Box boxRight;
  Box boxLeft;
  Box boxTopLeft;
  Box boxTopRight;
  Box boxBottomLeft;
  Box boxBottomRight;

  //----------Other----------
  boolean updateGridTrue;
  int currentGrid;
  int updateTime = 10;

  BoxManager(int level)
  {    //enemy = new Enemy(width/2, height-60);
    counter = 0;
    loadingTime = 1;
    gameManager.resetValues();
    powerUpManager = new PowerUpManager();
    this.level = level;

    //Clear arraylists
    anchors.clear();  
    enemies.clear();
    coins.clear();
    magnet.clear();
    bullet.clear();
    particle.clear();

    if(levelmusic != null)
      levelmusic.pause();

    map = loadImage("level"+level+".png");
    foregroundImage = loadImage("foreground"+level+".png");

    levelmusic = minim.loadFile("Music/Levelmusic" +level+ ".wav");

    if(levelmusic != null)
    levelmusic.setGain(-40 + volume[0]);
    if(map == null)
    {
      menu.level.selectedLevel--;
      isMenu = true;
      mainMusic.rewind();
      mainMusic.play();
      if(levelmusic != null)
      levelmusic.pause();
      return;
    }

    rows = map.width;
    columns = map.height;

    player.velocity = new PVector(0, 0);

    //fill 2 dimensional array with Box-objects
    boxes = new Box[rows][columns];
    foreground = new Box[rows][columns];
    camera.shiftX = 0;
    camera.shiftY = 0;
    if(levelmusic != null)
    levelmusic.loop();
        
    //select the boxes that the tileBox collides with
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
          else if(map.pixels[p] == color(255,100,0)){
            coll = 2;
          }
          else if(map.pixels[p] == color(0,255,0)){
            coll = 3;
          }
          else if(map.pixels[p] == color(255,255,0)){
            coll = 4;
          }
          //steel pillar col 
          else if(map.pixels[p] == color(0,0,1)){
            coll = 5;
          }          
          else if(map.pixels[p] == color(150,150,150)){
            coll = 7;
          }
          else if(map.pixels[p] == color(255,255,100)){
            coll = 8;
          }
          //small platform top right
          else if(map.pixels[p] == color(0,5,0)){
            coll = 10;
          }
          //small platform pillar right
          else if(map.pixels[p] == color(0,10,0)){
            coll = 11;
          }
          //small platform top left
          else if(map.pixels[p] == color(5,0,0)){
            coll = 12;
          }
          //small platform pillar right
          else if(map.pixels[p] == color(10,0,0)){
            coll = 13;
          }
          //mini platform top
          else if(map.pixels[p] == color(0,0,5)){
            coll = 14;
          }
          //steel platform left
          else if(map.pixels[p] == color(20,10,0)){
            coll = 15;
          }
          //steel platform middle
          else if(map.pixels[p] == color(25,0,0)){
            coll = 16;
            int rand = ceil(random(0, 5));
            if(rand == 5)
            {
              foregroundImage.pixels[p] = color(0,25,0);
              foregroundImage.pixels[p+1] = color(0,30,0);
              foregroundImage.pixels[p-1] = color(0,20,0);
            }
          }
          //steel platform right
          else if(map.pixels[p] == color(20,0,10)){
            coll = 17;
          }
          //steel platform middle 2
          else if(map.pixels[p] == color(30,0,0)){
            coll = 18;
          }
          //steel pillar
          else if(map.pixels[p] == color(20,0,0)){
            coll = 19;
          }
          //hook middle
          else if(map.pixels[p] == color(100,0,0)){
            coll = 20;
          }
          //hook top
          else if(map.pixels[p] == color(110,0,0)){
            coll = 21;
          }

          //Invisible hitboxes enemy
          else if(map.pixels[p] == color(220,0,0)){
            coll = 22;
          }
          //Ladder      
          //Tutorial stuff
          else if(map.pixels[p] == color(0,55,0)){
            coll = 24;
          }     

          else if(map.pixels[p] == color(0,60,0)){
            coll = 25;
          }     

          else if(map.pixels[p] == color(0,65,0)){
            coll = 26;
          }     

          else if(map.pixels[p] == color(0,70,0)){
            coll = 27;
          }     

          else if(map.pixels[p] == color(0,75,0)){
            coll = 28;
          }      

          else if(map.pixels[p] == color(0,80,0)){
            coll = 29;
          }    

          else if(map.pixels[p] == color(0,85,0)){
            coll = 30;
          }    

          else if(map.pixels[p] == color(0,90,0)){
            coll = 31;
          }    

          else if(map.pixels[p] == color(0,95,0)){
            coll = 32;
          }    

          else if(map.pixels[p] == color(0,100,0)){
            coll = 33;
          }   
          else if(map.pixels[p] == color(0,105,0)){
            coll = 34;
          } 
          else if(map.pixels[p] == color(0,110,0)){
            coll = 35;
          }           
          //Wires
          // else if(map.pixels[p] == color(255,100,0)){
          //   coll = 34;
          // }                       
          else if(map.pixels[p] == color(255,100,5)){
            coll = 36;
          }                       
          else if(map.pixels[p] == color(255,100,10)){
            coll = 37;
          }                       
          else if(map.pixels[p] == color(255,100,15)){
            coll = 38;
          }                       
          else if(map.pixels[p] == color(255,100,20)){
            coll = 39;
          }                       
          else if(map.pixels[p] == color(255,100,25)){
            coll = 40;
          }                       
          else if(map.pixels[p] == color(255,100,30)){
            coll = 41;
          }                       
          else if(map.pixels[p] == color(255,100,35)){
            coll = 42;
          }                       


          //Powerup Spawns
          else if(map.pixels[p] == color(100,255,255)){
            anchors.add(new Anchor(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j)));
          }
          else if(map.pixels[p] == color(244,0,0)){
            powerUpManager.rocketArm = new RocketArm(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j));
          }         
          else if(map.pixels[p] == color(243,0,0)){
            powerUpManager.rocketJump = new RocketJump(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j));
          } 
          else if(map.pixels[p] == color(240,0,0)){
            powerUpManager.fuels.add(new Fuel(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j)));
          }
          else if(map.pixels[p] == color(241,0,0)){
            coins.add(new Currency(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j), "norm"));
          }    
          else if(map.pixels[p] == color(242,0,0)){
            coins.add(new Currency(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j), "gold"));
          }               

          //Enemy spawn         
          else if(map.pixels[p] == color(255,0,0)){
            enemies.add(new Enemy(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j,0));
          }         
          //shooting enemy
          else if(map.pixels[p] == color(250,0,0)){
            enemies.add(new Enemy(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j,1));
          }  
          //plant enemy
          else if(map.pixels[p] == color(251,0,0)){
            enemies.add(new Enemy(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j,2));
          }     
          //shooting plant enemy
          else if(map.pixels[p] == color(252,0,0)){
            enemies.add(new Enemy(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j,3));
          }                                                
          else if(map.pixels[p] == color(253,0,0)){
            enemies.add(new Enemy(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j,4));
          }                                                
          else if(map.pixels[p] == color(254,0,0)){
            enemies.add(new Enemy(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j,5));
          }                                                

          //Magnet down spawn
          else if(map.pixels[p] == color(152,152,152)){
            magnet.add(new Magnet(DOWN,new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j)));
          }
          //Magnet up spawn
          else if(map.pixels[p] == color(150,150,150)){
            magnet.add(new Magnet(UP,new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j)));
          }          
          //Magnet right spawn
          else if(map.pixels[p] == color(151,151,151)){
            magnet.add(new Magnet(RIGHT,new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j)));
          }
          //Magnet left spawn
          else if(map.pixels[p] == color(153,153,153)){
            magnet.add(new Magnet(LEFT,new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j)));
          }                    

          boxes[i][j] = new Box(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j), boxSize, false, coll);

        }
      }
  if(foregroundImage != null)
  {
    for(int i = 0; i < rows; i++)
    {
      for(int j = 0; j < columns; j++)
      {
        int coll = 0;
        int p = i + (j * rows);
        if(foregroundImage.pixels[p] == color(0,0,0)){
          coll = 1;
        }
        if(foregroundImage.pixels[p] == color(0,160,255)){
          coll = 2;
        }  
        if(foregroundImage.pixels[p] == color(0,0,255)){
          coll = 3;
        }           
        if(foregroundImage.pixels[p] == color(0,0,100)){
          coll = 4;
        }      
        if(foregroundImage.pixels[p] == color(0,20,0)){
          coll = 5;
        }   
        if(foregroundImage.pixels[p] == color(0,25,0)){
          coll = 6;
        }   
        if(foregroundImage.pixels[p] == color(0,30,0)){
          coll = 7;
        }        
        if(foregroundImage.pixels[p] == color(0,255,255)){
          coll = 8;
        }                                     
        foreground[i][j] = new Box(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j), boxSize, true, coll);
      }
    }
  }
  }  
  void Update()
  {
    over = new ArrayList<Box>();
    surrounding = new ArrayList<Box>();
    foreOver = new ArrayList<Box>();
    CalculateCurrentTiles();
    SetOverCells();
    SetSurroundingCells();
    CheckEnemyCollision();    
    CheckCollisions();
    if(updateGridTrue)
      updateGrid();

  }

  void updateGrid()
  {
    if(updateTime == 0)
    {
      for(int j = 0; j < rows; j++)
      {
        if(foregroundImage != null)
        {
          if(foreground[j][currentGrid].foreCollides == 4){
            foreground[j][currentGrid].foreCollides = 0;
          }
        }
      }
      currentGrid++;
      updateTime = 10;
    }
    updateTime--;


    if(currentGrid == columns -1)
    {
      updateGridTrue = false;
      currentGrid = 0;
    }
  }

  void CalculateCurrentTiles()
  {
    //get the tiles where the corners of the player are located in
    float xPercentage, yPercentage;
    for (int i = 0; i < player.corners.length; i++)
    {
      xPercentage = player.corners[i].x / (width * ((float) rows / 32))  * 100;
      xTile[i] = floor(rows / 100f * xPercentage);     
      yPercentage = player.corners[i].y / (height * ((float) columns / 18)) * 100;
      yTile[i] = floor(columns / 100f * yPercentage);
    }
    //get the tiles underneath the player for groundCheck
    xPercentage = player.playerBottom.x / (width * ((float)rows / 32)) * 100;
    xBottom = floor(rows / 100f * xPercentage);
    yPercentage = player.playerBottom.y / (height * ((float) columns / 18)) * 100;
    yBottom = floor(columns / 100f * yPercentage);

    //get enemy tile position
    for (int i = 0; i < enemies.size(); ++i) {
      float xEnemyPercentage = enemies.get(i).x / (width * ((float) rows / 32)) * 100;
      xEnemyTile[i] = floor(rows / 100f * xEnemyPercentage);
      float yEnemyPercentage = enemies.get(i).y / (height * ((float) columns / 18)) * 100;
      yEnemyTile[i] = floor(columns / 100f * yEnemyPercentage);       
    }
   
  }

  void SetOverCells()
  {
    //add the boxes the player is currently on top of to the over ArrayList
    for (int i = 0; i < 6; i++)
    {
      if (xTile[i] >= rows || xTile[i] <= 0);
      else if (yTile[i] >= columns || yTile[i] <= 0);
      else
      //if valid row and column
      {
        //store box in temporary box variable
        Box box = boxes[xTile[i]][yTile[i]];

        //if the box is not yet in the over ArrayList, add it
        if (!over.contains(box))
        {
          over.add(box);
        }
      }
    }
    for (int i = 0; i < 6; i++)
    {
      if (xTile[i] >= rows || xTile[i] <= 0);
      else if (yTile[i] >= columns || yTile[i] <= 0);
      else
      {
        Box box = foreground[xTile[i]][yTile[i]];

        if (!foreOver.contains(box))
        {
          foreOver.add(box);
        }
      }
    }    
  }

  void SetSurroundingCells()
  {
    //get the boxes surrounding the player
    for (int i = 0; i < 6; i++)
    {
      //if grid cell is within the array of cells(boxes)
      if (xTile[i] >= rows || xTile[i] + 1 >= rows || xTile[i] <= 0 || xTile[i] - 1 < 0);
      else if (yTile[i] >= columns || yTile[i] + 1 >= columns || yTile[i] <= 0 || yTile[i] - 1 < 0);
      else
      {
        //set temporary box variables to the box surrounding player
         boxTop = boxes[xTile[i]][yTile[i]-1];
         boxBottom = boxes[xTile[i]][yTile[i]+1];
         boxRight = boxes[xTile[i]-1][yTile[i]];
         boxLeft = boxes[xTile[i]+1][yTile[i]];
         boxTopLeft = boxes[xTile[i]-1][yTile[i]-1];
         boxTopRight = boxes[xTile[i]+1][yTile[i]-1];
         boxBottomLeft = boxes[xTile[i]-1][yTile[i]+1];
         boxBottomRight = boxes[xTile[i]+1][yTile[i]+1];

        //if its not yet in the surrounding boxes ArrayList, add it
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
    {
      //set bottomBox to the boxes below the player
      bottomBox = boxes[xBottom][yBottom+1];
    }
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
      if (surrounding.get(i).collides == 1 ||
          surrounding.get(i).collides == 5 ||
          surrounding.get(i).collides == 15 ||
          surrounding.get(i).collides == 16 ||
          surrounding.get(i).collides == 17 ||
          surrounding.get(i).collides == 18)
        surrounding.get(i).CheckCollision();

      if (surrounding.get(i).collides == 12 ||
          surrounding.get(i).collides == 10 ||
          surrounding.get(i).collides == 14)
        surrounding.get(i).CheckCollisionTop();
    }
    for (int i = 0; i < foreOver.size(); ++i) {
      if (foreOver.get(i).foreCollides == 8)
      {
        foreOver.get(i).CheckLadderCollision();
        break;
      }
      else player.isClimbing = false;
    }
  }

  void CheckEnemyCollision()
  {
    //check for collision left and right of the enemy
    //if there is a tiles that it collides with, it changes direction
    for (int i = 0; i < enemies.size(); ++i) {
      if(enemies.get(i) != null)
      {
        float enemyTileCenter = 20 + (xEnemyTile[i]) * 40;

        // if(i == 0)
        // println(enemyTileCenter + " " + xEnemyTile[0] + " " + yEnemyTile[0]);
          //check left and right tile
        if (!(xEnemyTile[i] <= 0 || xEnemyTile[i] >= rows - 1))
        {
          //set the boxes to check collision on
          enemies.get(i).boxesToCheck[0] = new PVector(xEnemyTile[i]-1, yEnemyTile[i]);
          enemies.get(i).boxesToCheck[1] = new PVector(xEnemyTile[i]+1, yEnemyTile[i]);           
        }   
      } 
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

    // for (int i = 0; i < surrounding.size(); i++)
    // {
    //   surrounding.get(i).Draw();
    // }
  }
  void DrawForeground()
  {
    if(foregroundImage != null)
    {
      for (int i = 0; i < rows; i++)
      {
        for (int j = 0; j < columns; j++)
        {
          foreground[i][j].Drawforeground();
        }
      } 
    }       
  }
}
