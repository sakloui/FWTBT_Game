class Fuel
{
  PVector position;
  int size = 20;
  int fuelAmount = 25;
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
      //fuelName = "Character/Robot" + i + ".png";
      fuel[i] = loadImage(fuelName);
      //fuel[i].resize(80, 0);
    }
  }
  
  void Update()
  {
    CheckCollision();

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
  
  void CheckCollision()
  {
    if(position.x + size/2 > player.position.x - player.playerWidth/2 && 
       position.x - size/2 < player.position.x + player.playerWidth/2 && 
       position.y + size/2 > player.position.y - player.playerHeight/2 &&
       position.y - size/2 < player.position.y + player.playerHeight/2)
       {
         powerUpManager.fuelCount += fuelAmount;
         powerUpManager.fuels.remove(this);
       }
  }
  
  void Draw()
  {
    pushMatrix();
    translate(position.x - camera.shiftX, position.y - camera.shiftY);
    image(fuel[int(round(currentFrame))], 0, 0);
    popMatrix();
  }
}
