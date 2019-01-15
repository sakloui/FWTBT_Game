class Background
{
  // This class name is a bit misleading as it's actually just a ellipse spawner.
  // This is for the time being, incase it does get into the release here's how it works:
  // In the Menu class in the updateMenu method a timer is used to create a new Background class.

  PVector position = new PVector(0,0);
  float size;
  float speed;
  float alpha;
  Background()
  {
    // In here all variables except X position get randomized, this causes the ellipses to differ in size, speed, position and alpha.
    position.y = random(0,height);
    size = random(5,40);
    position.x = 0-size/2;
    speed = random(0.5,2);
    alpha = random(50,220);
  }
  void Update()
  {
    //

    position.x += speed;
    alpha -= random(0,0.3);
    if(alpha <= 0 || position.x - size/2> width)
    	menu.back.remove(this);
  }
  
  void Draw()
  {
    fill(210,190,200,alpha);
    ellipse(position.x, position.y, size, size);
  }	
}
