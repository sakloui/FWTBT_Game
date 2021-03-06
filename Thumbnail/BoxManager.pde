class BoxManager
{
  float boxSize = 20;
  int rows = 32;
  int columns = 18;
  int level;
  Box[][] boxes = new Box[rows][columns];
  Box[][] foreground = new Box[rows][columns];

  ArrayList<Box> over = new ArrayList<Box>();
  ArrayList<Box> surrounding = new ArrayList<Box>();
  Box bottomBox;

  int[] xTile = new int[6];
  int[] yTile = new int[6];
  int xBottom, yBottom;
  int[] xEnemyTile = new int[50];
  int[] yEnemyTile = new int[50];  


  boolean updateGridTrue;
  int currentGrid;
  int updateTime = 10;

  BoxManager(int level)
  {    //enemy = new Enemy(width/2, height-60);
    this.level = level;

    //Clear arraylists

    map = loadImage("level"+level+".png");
    foregroundImage = loadImage("foreground"+level+".png");

    rows = map.width;
    columns = map.height;
    //println(rows);
    if(rows > 32 || columns > 18)
    {
      println(20/(float(map.width)/32) +" "+ rows);
      boxSize = 20 / (float(map.width)/32);
    }
    boxes = new Box[rows][columns];
    foreground = new Box[rows][columns];
        
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
          if(map.pixels[p] == color(255,100,0)){
            coll = 2;
          }
          if(map.pixels[p] == color(0,255,0)){
            coll = 3;
          }
          if(map.pixels[p] == color(255,255,0)){
            coll = 4;
          }
          //steel pillar col 
          if(map.pixels[p] == color(0,0,1)){
            coll = 5;
          }          
          if(map.pixels[p] == color(150,150,150)){
            coll = 7;
          }
          if(map.pixels[p] == color(255,255,100)){
            coll = 8;
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
          //steel platform left
          if(map.pixels[p] == color(20,10,0)){
            coll = 15;
          }
          //steel platform middle
          if(map.pixels[p] == color(25,0,0)){
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
          if(map.pixels[p] == color(20,0,10)){
            coll = 17;
          }
          //steel platform middle 2
          if(map.pixels[p] == color(30,0,0)){
            coll = 18;
          }
          //steel pillar
          if(map.pixels[p] == color(20,0,0)){
            coll = 19;
          }
          //hook middle
          if(map.pixels[p] == color(100,0,0)){
            coll = 20;
          }
          //hook top
          if(map.pixels[p] == color(110,0,0)){
            coll = 21;
          }

          //Invisible hitboxes enemy
          if(map.pixels[p] == color(220,0,0)){
            coll = 22;
          }
          //Ladder      
          //Tutorial stuff
          if(map.pixels[p] == color(0,55,0)){
            coll = 24;
          }     

          if(map.pixels[p] == color(0,60,0)){
            coll = 25;
          }     

          if(map.pixels[p] == color(0,65,0)){
            coll = 26;
          }     

          if(map.pixels[p] == color(0,70,0)){
            coll = 27;
          }     

          if(map.pixels[p] == color(0,75,0)){
            coll = 28;
          }      

          if(map.pixels[p] == color(0,80,0)){
            coll = 29;
          }    

          if(map.pixels[p] == color(0,85,0)){
            coll = 30;
          }    

          if(map.pixels[p] == color(0,90,0)){
            coll = 31;
          }    

          if(map.pixels[p] == color(0,95,0)){
            coll = 32;
          }    

          if(map.pixels[p] == color(0,100,0)){
            coll = 33;
          }     
          //Wires
          // if(map.pixels[p] == color(255,100,0)){
          //   coll = 34;
          // }                       
          if(map.pixels[p] == color(255,100,5)){
            coll = 35;
          }                       
          if(map.pixels[p] == color(255,100,10)){
            coll = 36;
          }                       
          if(map.pixels[p] == color(255,100,15)){
            coll = 37;
          }                       
          if(map.pixels[p] == color(255,100,20)){
            coll = 38;
          }                       
          if(map.pixels[p] == color(255,100,25)){
            coll = 39;
          }                       
          if(map.pixels[p] == color(255,100,30)){
            coll = 40;
          }                       
          if(map.pixels[p] == color(255,100,35)){
            coll = 41;
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
