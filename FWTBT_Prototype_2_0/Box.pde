class Box
{
  PVector position;
  float size;
  color groundColor = color(255);

  float top, bottom, right, left;

  int collides;
  int foreCollides;
  int dist = 20;
  float timer = random(100,1000);

  boolean switched = false;

  Box(PVector position, float size, boolean foreground,int collide)
  {
    this.position = position.copy();
    this.size = size;
    if(!foreground)
    collides = collide;
    else foreCollides = collide;
    SetPosValues();
    if(collides == 3){player.position.x = position.x;player.position.y = position.y;}
  }

  void SetPosValues()
  {
    top = position.y - size/2;
    bottom = top + size;
    right = position.x + size/2;
    left = right - size;
  }

  void CheckCollision()
  {
    if(position.x + size/2 > player.position.x - player.playerWidth/2 &&
       position.x - size/2 < player.position.x + player.playerWidth/2 &&
       position.y + size/2 > player.position.y - player.playerHeight/2 &&
       position.y - size/2 < player.position.y + player.playerHeight/2)
       {
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

         player.GetCollisionDirection(this);
       }

  }
  void CheckLadderCollision()
  {
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
    if(position.x + size/2 > player.position.x - player.playerWidth/2 &&
       position.x - size/2 < player.position.x + player.playerWidth/2 &&
       position.y + size/2 > player.position.y - player.playerHeight/2 &&
       position.y - size/2 < player.position.y + player.playerHeight/2)
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
          rect(0, 0, size, size);
          break;
        case 4:
          fill(255, 255, 0);
          rect(0, 0, size, size);
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
          image(tutorialLadderS,0,0,80,80);
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
          image(tutorialLadderW,0,0,80,80);
          break;                                                  
        case 33:
          image(tutorialDeath,0,0,80,80);
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
          fill(0, 0,255);
          rect(0, 0, size, size);
          killPlayer();
          break;  
        case 4:
          fill(0,0,255);
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
          rect(0,0,size,size);
          //CheckLadderCollision();
          break;                   
      }               
      popMatrix();
    } 
  }  
}
