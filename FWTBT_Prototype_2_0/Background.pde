class Background
{
  PVector position = new PVector(0,0);
  float size;
  float speed;
  float alpha;
  Background()
  {
    position.x = 0;
    position.y = random(0,height);
    size = random(5,40);
    speed = random(0.5,2);
    alpha = random(50,200);
  }
  void Update()
  {
    position.x += speed;
    alpha -= random(0,0.2);
    if(alpha <= 0 || position.x > width)
    	menu.back.remove(this);
  }
  
  void Draw()
  {
    fill(210,190,200,alpha);
    ellipse(position.x, position.y, size, size);
  }	
}