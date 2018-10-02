class Box
{
  PVector position;
  float size;
  color groundColor = color(255);
  
  float top, bottom, right, left;
  
  boolean collides;
  
  Box(PVector position, float size, boolean collide)
  {
    this.position = position.copy();
    this.size = size;
    collides = collide;
    SetPosValues();
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
    if(position.x + size/2 > player.position.x - player.size/2 && 
       position.x - size/2 < player.position.x + player.size/2 && 
       position.y + size/2 > player.position.y - player.size/2 &&
       position.y - size/2 < player.position.y + player.size/2)
       {
         player.GetCollisionDirection(this);
       }
  }
  
  void Draw()
  {
    pushMatrix();
    if(collides)
      fill(0, 0, 200);
    else
      fill(groundColor);
    stroke(0);
    strokeWeight(2);
    translate(position.x, position.y);
    rect(0, 0, size, size);
    popMatrix();
  }
}
