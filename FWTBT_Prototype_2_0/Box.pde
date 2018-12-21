class Box extends Rectangle
{

  //----------Box properties----------
  float size;
  color groundColor = color(255);

  //----------Position----------
  PVector position;
  float top, bottom, right, left;

  //----------Other----------
  int collides;
  int foreCollides;
  int dist = 20;
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
        boxManager.currentGrid = 0;
        boxManager.updateGridTrue = true;
        interactionsound.rewind();
        interactionsound.play();        
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
          if(collides == 4)
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

  void Draw()
  {
    //if (collides != 0)
    {
      pushMatrix();
      stroke(0);
      strokeWeight(2);
      noStroke();      

      translate(position.x  - camera.shiftX, position.y  - camera.shiftY);
      switch(collides)
      {
        case 1:
          image(tileBox,0,0, size, size);
          break;
        case 2:
          fill(255, 0, 0);
          rect(0, 0, size, size);
          killPlayer();
          break;
        case 3:
          fill(0, 255, 0);
          image(enterDoor,0, -20,80,80);
          break;
        case 4:
          image(exitDoor,0, -20,80,80);
          CheckCollisionNext();
          break;
        case 5:
          image(tileSteelPillar,0,0,size,size);
          break;            
        case 7:
          fill(150,150,150);
          rect(0, 0, size, size);
          break;
        case 8:
          fill(255,255,100);
          rect(0, 0, size, size);
          CheckCollisionSwitch();
          break;

        case 10:
          image(tileSmallPlatformTopRight,0,0, size, size); 
          break;
        case 11:
          image(tileSmallPlatformPillarRight,0,0, size, size); 
          break;
        case 12:
          image(tileSmallPlatformTopLeft,0,0, size, size); 
          break;
        case 13:
          image(tileSmallPlatformPillarLeft,0,0, size, size); 
          break;
        case 14:
          image(tileMiniPlatformTop,0,0, size, size); 
          break;
        case 15:
          image(steelPlatformLeft,0,0,size,size);
          break;
        case 16:
          image(steelPlatformMiddle,0,0,size,size);
          break;
        case 17:
          image(steelPlatformRight,0,0,size,size);
          break;          
        case 18:
          image(steelPlatformMiddle2,0,0,size,size);
          break; 
        case 19:
          image(tileSteelPillar,0,0,size,size);
          break;    
        case 20:
          image(hookMiddle,0,0,size,size);
          break;    
        case 21:
          image(hookTop,0,0,size,size);
          break;  
        case 24:
          image(tutorialA,0,0,80,80);
          break;
        case 25:
          image(tutorialD,0,0,80,80);
          break;
        case 26:
          image(tutorialLadderW,0,0,80,80);
          break;
        case 27:
          image(tutorialW,0,0,80,80);
          break;
        case 28:
          image(tutorialK,0,0,80,80);
          break;
        case 29:
          image(tutorialL,0,0,80,80);
          break;
        case 30:
          image(tutorialX,0,0,80,80);
          break;
        case 31:
          image(tutorialZ,0,0,80,80);
          break;
        case 32:
          image(tutorialLadderS,0,0,80,80);
          break;                                                  
        case 33:
          image(tutorialDeath,0,0,80,80);
          break;
        case 34:
          image(tutorialSecret,0,0,80,80);
          break;
        case 35:
          image(tutorialEnd,0,0,80,80);
          break;                      
        // case 34:
        //   image(wireStart,0,0,size,size);
        //   break;  
        case 36:
          image(wireHeel,0,0,size,size);
          break;  
        case 37:
          image(wireHeel2,0,0,size,size);
          break;
        case 38:
          image(wireCompleet,0,0,size,size);
          break;  
        case 39:
          image(wireStartBroken,0,0,size,size);
          break;  
        case 40:
          image(wireHeelBroken,0,0,size,size);
          break;
        case 41:
          image(wireHeel2Broken,0,0,size,size);
          break;          
        case 42:
          image(wireCompleetBroken,0,0,size,size);
          break;
        case 43:
          image(boxOmhoog,0,0,size,size);
          break;
        case 44:
          image(boxOmlaag,0,0,size,size);
          break;
        case 45:
          image(boxLinks,0,0,size,size);
          break;
        case 46:
          image(boxRechts,0,0,size,size);
          break;
        case 47:
          image(boxCornerLinksBoven,0,0,size,size);
          break;
        case 48:
          image(boxCornerLinksOnder,0,0,size,size);
          break;
        case 49:
          image(boxCornerRechtsBoven,0,0,size,size);
          break;
        case 50:
          image(boxCornerRechtsOnder,0,0,size,size);
          break;
        case 51:
          image(boxCornerPointRechtsBoven,0,0,size,size);
          break;
        case 52:
          image(boxCornerPointRechtsOnder,0,0,size,size);
          break;
        case 53:
          image(boxCornerPointLinksBoven,0,0,size,size);
          break;
        case 54:
          image(boxCornerPointLinksOnder,0,0,size,size);
          break;
        case 100:
          fill(groundColor);
          rect(0,0,size,size);
          break;                                                                                                                              
        }        
      popMatrix();
    } 
  }
void Drawforeground()
  {
    if (foreCollides != 0)
    {
      pushMatrix();
      stroke(0);
      strokeWeight(2);
      noStroke();      

      translate(position.x  - camera.shiftX, position.y  - camera.shiftY);
      switch(foreCollides)
      {
        case 1:
          fill(100,100,0,200);
          rect(0,0,size,size);
          break; 
        case 2:
          CheckCollisionInvis();        
          image(tileSteelPillar, 0, 0, size, size); 
          noTint();
          break;
        case 3:
          fill(0, 0,255,100);
          rect(0, 0, size, size);
          killPlayer();
          break;  
        case 4:
          fill(0,0,255,100);
          rect(0, 0, size, size);
          killPlayer();
          break; 
        case 5:
          image(overgrownLeft, 0, 0, size, size);
          break;
        case 6:
          image(overgrownMiddle, 0, 0, size, size);
          break;
        case 7:
          image(overgrownRight, 0, 0, size, size);
          break; 
        case 8:
          fill(0,255,255);
          image(ladder,0,0,size,size);
          //CheckLadderCollision();
          break;                   
      }               
      popMatrix();
    } 
  }  
}
