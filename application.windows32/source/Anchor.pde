class Anchor
{
  
  // This stores and draws the position of the anchor, the position is used in the RocketArm class to check if it's close to the grapple hook. 
  
  PVector position;
  int size = 40;
  color anchorColor = color(100, 255, 255);
  
  Anchor(PVector pos)
  {
    position = pos.copy();
  }
  
  void Draw()
  {
    pushMatrix();
    translate(position.x  - camera.shiftX, position.y - camera.shiftY);
    fill(anchorColor);
    image(grappleTex,0,0, size, size);
    popMatrix();
  }
}
