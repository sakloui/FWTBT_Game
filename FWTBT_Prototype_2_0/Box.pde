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
  
  void Draw()
  {
    if (collides != 0)
    {
      pushMatrix();   
      //if(collides == 0)
      //  fill(0);
      if(collides == 2)
        fill(255, 0, 0);
      if(collides == 3)
        fill(0, 255, 0); 
      if(collides == 4)
        fill(255, 255, 0); 
      if(collides == 5)
        fill(0, 0, 255);  
      if(collides == 7)
        fill(150,150,150);
      if(collides == 8){
        fill(255,255,100);
        CheckCollisionInvis();
      }
      if(collides == 9)
        fill(0,0,255);
      stroke(0);
      strokeWeight(2);
      translate(position.x, position.y);
      noStroke();
      rect(0, 0, size, size);
      if(collides == 1)
        image(tile,0,0, size, size);
      if(collides == 6){
        image(tile,0,0, size, size); 
        CheckCollisionInvis();
      }
      popMatrix();
    }
    if((collides == 2 || collides == 5 || collides == 9) && dist(player.position.x,player.position.y,position.x,position.y) <= dist)
    {
      menu.menuState = 0;
      menu.createMainMenu();
      menu.currentSel = 0;
      menu.button[0].selected = true;
      menu.button[0].update();
      isMenu = true;
    }
    if(collides == 4 && dist(player.position.x,player.position.y,position.x,position.y) <= dist)
    {
      currentLevel++;
      loadMap(currentLevel);
      menu.level.selectedLevel++;
      
    }
  }
}
