class Box extends Rectangle
{

  //----------Box properties----------
  float size;
  color groundColor = color(255);

  //----------Position----------
  PVector position;
  float top, bottom, right, left;
  float yOffset = 0;
  float xOffset = 0;

  //----------Other----------
  int collides;
  int foreCollides;
  int dist = 20;
  PImage type;
  PImage subtype = tileBox;

  float timer = random(100,1000);

  boolean switched = false;

  Box(PVector position, float size, boolean foreground,int collide)
  {
    this.name = "Box";
    this.position = position.copy();
    this.size = size;
    this.rectWidth = size;
    this.rectHeight = size;
    if(!foreground)
    collides = collide;
    else foreCollides = collide;
    SetPosValues();
    if(collides == 3){player.position.x = position.x;player.position.y = position.y-15;}
    if(!foreground)
      createBox();
    else
      createForegroundBox();
  }


  void SetPosValues()
  {
    //save the top, bottom, left and right positions for collision detection
    top = position.y - size/2;
    bottom = top + size;
    right = position.x + size/2;
    left = right - size;
  }

  //all protected methods are from the Rectangle super class
  //these are used for collision detection
  protected String getName() {
    return name;
  }

  protected float getX()
  {
    return position.x;
  }

  protected float getY()
  {
    return position.y;
  }

  protected float getSize() {
    return size;
  }

  protected float getTop() {
    return top;
  }

  protected float getBottom() {
    return bottom;
  }

  protected float getLeft() {
    return left;
  }

  protected float getRight() {
    return right;
  }
  protected int getCollides() {
    return collides;
  }  
  protected Box getBox() {
    return this;
  }    



  void CheckCollision()
  {
    //if the player is within a box
    if(position.x + size/2 > player.position.x - player.playerWidth/2 &&
       position.x - size/2 < player.position.x + player.playerWidth/2 &&
       position.y + size/2 > player.position.y - player.playerHeight/2 &&
       position.y - size/2 < player.position.y + player.playerHeight/2)
       {
          //handle collision in the player class, pass *this* (instance of the box class) to the method
          //the method uses the protected methods to above to get the box position variables
          player.GetCollisionDirection(this);
       }

  }
  void CheckCollisionTop()
  {
    if(position.x + 10 > player.position.x - player.playerWidth/2 &&
       position.x - 10 < player.position.x + player.playerWidth/2 &&
       position.y + 10 > player.position.y - player.playerHeight/2 &&
       position.y - size/2 < player.position.y + player.playerHeight/2)
       {

          //handle collision in the player class, pass *this* (instance of the box class) to the method
          //the method uses the protected methods to above to get the box position variables
          player.GetCollisionDirection(this);
       }

  }
  void CheckLadderCollision()
  {
    if(input.isUp || input.isDown || player.isClimbing)
      if(position.x + size/2 > player.position.x - player.playerWidth/2 &&
         position.x - size/2 < player.position.x + player.playerWidth/2 &&
         position.y + size/2 > player.position.y - player.playerHeight/2 &&
         position.y - size/2 < player.position.y + player.playerHeight/2)
         {
           player.isClimbing = true;
         }
  }    
  void CheckCollisionInvis()
  {
    if(position.x + size/2 > player.position.x - player.playerWidth*1.5 &&
       position.x - size/2 < player.position.x + player.playerWidth*1.5 &&
       position.y + size/2 > player.position.y - player.playerHeight &&
       position.y - size/2 < player.position.y + player.playerHeight)
       {
        if(foreCollides == 2){
         // println("oh");
          tint(255,100);
        }

       }
    else
    {
      if(foreCollides == 2){
         // println("oh");
         tint(255,255);
      }
    }

  }
  void CheckCollisionSwitch()
  {
    if(position.x + size/2 > player.position.x - player.playerWidth/2 &&
       position.x - size/2 < player.position.x + player.playerWidth/2 &&
       position.y + size/2 > player.position.y - player.playerHeight/2 &&
       position.y - size/2 < player.position.y + player.playerHeight/2)
    {    
      if(collides == 8 && !switched){
        switched = true;
        type = switch1;
        loop:
        for (int j = 0; j < boxManager.columns; j++)
        {
          for (int i = 0; i < boxManager.rows; i++)
          { 
            if(boxManager.foreground[i][j].foreCollides == 4)
            {  
              boxManager.currentGrid = j;
              println(boxManager.currentGrid);
              break loop;
            }   
          }
        }    
        
        boxManager.updateGridTrue = true;
        interactionsound.rewind();
        interactionsound.play();  
        boxManager.focusWater();      
      }
    }    
  }

  void CheckCollisionNext()
  {
    if(position.x + 80/2 > player.position.x - player.playerWidth/2 &&
       position.x - 80/2 < player.position.x + player.playerWidth/2 &&
       position.y + 80/2 > player.position.y - player.playerHeight/2 &&
       position.y - 80/2 < player.position.y + player.playerHeight/2)
       {
          if(type == exitDoor)
          {
            menu.currentSel = 0;
            menu.createEndLevel();
            menu.menuState = 0;
            isMenu = true;
            highscore.checkHighscore();
          }
       }
  }

  void killPlayer()
  {
    if(position.x + size/2 > player.position.x - player.playerWidth/2 &&
       position.x - size/2 < player.position.x + player.playerWidth/2 &&
       position.y + size/2 > player.position.y - player.playerHeight/2 &&
       position.y - size/2 < player.position.y + player.playerHeight/2)
    {    
      menu.currentSel = 0;
      menu.createDied();
      menu.menuState = 0;
      isMenu = true;
      gameManager.currencyValues[3]++;
    }        
  }

  void createBox()
  {
    if (collides != 0)
    {
      switch(collides)
      {
        case 1:
          type = tileBox;
          break;
        case 2:
          type = deathOrb;
          break;
        case 3:
          type =enterDoor;
          yOffset = -20;
          size = 80;          
          break;
        case 4:
          type = exitDoor;
          yOffset = -20;
          size = 80;
          break;
        case 5:
          type = tileSteelPillar;
          break;            
        // case 7:
        //   fill(150,150,150);
        //   rect(0, 0, size, size);
        //   break;
        case 8:
          type = switch0;
          break;

        case 10:
          type =tileSmallPlatformTopRight; 
          break;
        case 11:
          type =tileSmallPlatformPillarRight; 
          break;
        case 12:
          type = tileSmallPlatformTopLeft; 
          break;
        case 13:
          type = tileSmallPlatformPillarLeft; 
          break;
        case 14:
          type = tileMiniPlatformTop; 
          break;
        case 15:
          type = steelPlatformLeft;
          break;
        case 16:
          type = steelPlatformMiddle;
          break;
        case 17:
          type = steelPlatformRight;
          break;          
        case 18:
          type = steelPlatformMiddle2;
          break; 
        case 19:
          type = tileSteelPillar;
          break;    
        case 20:
          type = hookMiddle;
          break;    
        case 21:
          type = hookTop;
          break;  
        case 24:
          type = tutorialA;
          size = 80;
          break;
        case 25:
          type = tutorialD;
          size = 80;
          break;
        case 26:
          type = tutorialLadderW;
          size = 80;
          break;
        case 27:
          type = tutorialW;
          size = 80;
          break;
        case 28:
          type = tutorialK;
          size = 80;
          break;
        case 29:
          type = tutorialL;
          size = 80;
          break;
        case 30:
          type = tutorialX;
          size = 80;
          break;
        case 31:
          type = tutorialZ;
          size = 80;
          break;
        case 32:
          type = tutorialLadderS;
          size = 80;
          break;                                                  
        case 33:
          type = tutorialDeath;
          size = 80;
          break;
        case 34:
          type = tutorialSecret;
          size = 80;
          break;
        case 35:
          type = tutorialEnd;
          size = 80;
          break;                      
        // case 34:
        //   image(wireStart;
        //   break;  
        case 36:
          type = wireHeel;
          break;  
        case 37:
          type = wireHeel2;
          break;
        case 38:
          type = wireCompleet;
          break;  
        case 39:
          type = wireStartBroken;
          break;  
        case 40:
          type = wireHeelBroken;
          break;
        case 41:
          type = wireHeel2Broken;
          break;          
        case 42:
          type = wireCompleetBroken;
          break;
        case 50:
          fill(groundColor);
          rect(0,0,size,size);
          break;                                                                                                                              
        }        
    } 
  }
void createForegroundBox()
  {
    if (foreCollides != 0)
    {
      switch(foreCollides)
      {
        case 2:
          type = tileBox;
          break;
        case 3:
          type = water0; 
          break;  
        case 4:
          type = water0;
          break; 
        case 5:
          type = overgrownLeft;
          break;
        case 6:
          type = overgrownMiddle;
          break;
        case 7:
          type = overgrownRight;
          break; 
        case 8:
          type = ladder;
          //CheckLadderCollision();
          break;    


      }               
    } 
  } 

  void Draw()
  {
    if (type != null)
    {
      if (foreCollides == 2)
        CheckCollisionInvis();  

      pushMatrix();
      stroke(0);
      strokeWeight(2);
      noStroke();      

      translate(position.x  - camera.shiftX, position.y  - camera.shiftY);
      if (type == tileBox || type == water0)
        image(subtype, xOffset, yOffset, size, size);
      else
        image(type, xOffset, yOffset, size, size);
      noTint();
      popMatrix();


      if (type == deathOrb || type == water0)
          killPlayer();
      if (type == exitDoor)
          CheckCollisionNext();
      if (type == switch0)
          CheckCollisionSwitch();
    }
  }

}
