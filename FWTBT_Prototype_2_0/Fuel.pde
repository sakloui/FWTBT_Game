class Fuel
{
  //----------Properties----------
  int size = 20;
  int fuelAmount = 25;

  //----------Position----------
  PVector position;
  
  //----------Animation----------
  PImage[] fuel;
  //currentFrame represents the specific image from the array that's being drawn
  float currentFrame;
  float animationSpeed = 0.1f;
  boolean increment;
  
  Fuel(PVector pos)
  {
    position = pos.copy();
    increment = true;
    SetupSprites();
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
    CheckCollision();

    //determine which sprite should be loaded next
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
    //check if the player picks up the fuel
    if(position.x + size/2 > player.position.x - player.playerWidth/2 && 
       position.x - size/2 < player.position.x + player.playerWidth/2 && 
       position.y + size/2 > player.position.y - player.playerHeight/2 &&
       position.y - size/2 < player.position.y + player.playerHeight/2)
       {
         powerUpManager.fuelCount += fuelAmount;
         //delete this instance of the fuel class
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
