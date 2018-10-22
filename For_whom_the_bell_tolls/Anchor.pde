class Anchor
{
  PVector position;
  int size = 20;
  color anchorColor = color(100, 255, 255);
  
  Anchor(PVector pos)
  {
    position = pos.copy();
  }
  
  void Draw()
  {
    pushMatrix();
    translate(position.x, position.y);
    fill(anchorColor);
    rect(0, 0, size, size);
    popMatrix();
  }
}
