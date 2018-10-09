class Fuel
{
  PVector position;
  PImage[] fuel;
  float currentFrame;
  float animationSpeed = 0.1f;
  boolean increment;
  
  Fuel(PVector position)
  {
    this.position = position.copy();
    SetupSprites();
    increment = true;
  }
  
  void SetupSprites()
  {
    fuel = new PImage[3];
    String fuelName;

    for (int i = 0; i < fuel.length; i++)
    {
      //load fuel sprites
      fuelName = "Fuel/Fuel" + i + ".png";
      fuel[i] = loadImage(fuelName);
      //fuel[i].resize(80, 0);
    }
  }
  
  void Update()
  {
    if(currentFrame >= 2)
    {
      increment = false;
    }
    if(currentFrame <= 0)
    {
      increment = true;
    }
    if(increment)
    {
      currentFrame = (currentFrame + animationSpeed);
    }
    else if(!increment)
    {
      currentFrame = (currentFrame - animationSpeed);
    }
      
  }
  
  void Draw()
  {
    pushMatrix();
    translate(position.x, position.y);
    image(fuel[int(currentFrame)], 0, 0);
    popMatrix();
  }
}
