class Box
{
  PVector position;
  float size;
  color groundColor = color(255);

  float top, bottom, right, left;

  int collides;
  int dist = 20;

  Box(PVector position, float size, int collide)
  {
    this.position = position.copy();
    this.size = size;
    collides = collide;
    SetPosValues();
    if(collides == 3)player.position.set(position);
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
  void CheckCollisionInvis()
  {
    if(position.x + size/2 > player.position.x - player.playerWidth/2 &&
       position.x - size/2 < player.position.x + player.playerWidth/2 &&
       position.y + size/2 > player.position.y - player.playerHeight/2 &&
       position.y - size/2 < player.position.y + player.playerHeight/2)
       {
         if(collides == 6){
         // println("oh");
         collides = 0;
         }
         if(collides == 8){
           updateGrid();
         }
       }

  }

  void CheckCollisionKill()
  {
    if(position.x + size/2 > player.position.x - player.playerWidth/2 &&
       position.x - size/2 < player.position.x + player.playerWidth/2 &&
       position.y + size/2 > player.position.y - player.playerHeight/2 &&
       position.y - size/2 < player.position.y + player.playerHeight/2)
       {

          menu.menuState = 0;
          menu.createMainMenu();
          menu.currentSel = 0;
          menu.button[0].selected = true;
          menu.button[0].update();
          isMenu = true;
          mainMusic.rewind();
          mainMusic.play();
       }
  }

  void Draw()
  {
    if (collides != 0)
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
          CheckCollisionKill();
          break;
        case 3:
          fill(0, 255, 0);
          rect(0, 0, size, size);
          break;
        case 4:
          fill(255, 255, 0);
          rect(0, 0, size, size);
          break;
        case 5:
          fill(0, 0, 255);
          rect(0, 0, size, size);
          CheckCollisionKill();
          break;
        case 6:
          image(tileBox, 0, 0, size, size); 
          CheckCollisionInvis();
          break;
        case 7:
          fill(150,150,150);
          rect(0, 0, size, size);
          break;
        case 8:
          fill(255,255,100);
          rect(0, 0, size, size);
          CheckCollisionInvis();
          break;
        case 9:
          fill(0,0,255);
          rect(0, 0, size, size);
          break;
        case 10:
          image(tileSmallPlatformTopRight,0- camera.shiftX,0 - camera.shiftY, size, size); 
          break;
        case 11:
          image(tileSmallPlatformPillarRight,0- camera.shiftX,0 - camera.shiftY, size, size); 
          break;
        case 12:
          image(tileSmallPlatformTopLeft,0- camera.shiftX,0 - camera.shiftY, size, size); 
          break;
        case 13:
          image(tileSmallPlatformPillarLeft,0- camera.shiftX,0 - camera.shiftY, size, size); 
          break;
        case 14:
          image(tileMiniPlatformTop,0- camera.shiftX,0 - camera.shiftY, size, size); 
          break;       

      }
      popMatrix();
    }
    if((collides == 2 || collides == 5 || collides == 9) && dist(player.position.x,player.position.y,position.x,position.y) <= dist)
    {

    }
    if(collides == 4 && dist(player.position.x,player.position.y,position.x,position.y) <= dist)
    {
      currentLevel++;
      boxManager = new BoxManager(currentLevel);
      menu.level.selectedLevel++;

    }
  }
}
