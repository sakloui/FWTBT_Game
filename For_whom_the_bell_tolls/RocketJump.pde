class RocketJump
{
  color rocketJumpColor = color(0, 155, 155);
  int size = 30;
  PVector position;
  int fuelCost = 10;
  
  boolean pickedUp = false;
  
  RocketJump(PVector pos)
  {
    position = pos.copy();
  }
  
  void Update()
  {
    CheckCollision();
  }
  
  void CheckCollision()
  {
    if(position.x + size/2 > player.position.x - player.playerWidth/2 && 
       position.x - size/2 < player.position.x + player.playerWidth/2 && 
       position.y + size/2 > player.position.y - player.playerHeight/2 &&
       position.y - size/2 < player.position.y + player.playerHeight/2)
       {
         pickedUp = true;
       }
  }
  
  void Draw()
  {
    pushMatrix();
    fill(rocketJumpColor);
    translate(position.x, position.y);
    if(!pickedUp)
      rect(0, 0, size, size);
    popMatrix();
  }
  
}
