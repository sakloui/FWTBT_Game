class Anchor
{
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
    rect(0, 0, size, size);
    popMatrix();
  }
}
