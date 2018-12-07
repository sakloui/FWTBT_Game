class PowerUpManager
{
  //----------Objects----------
  ArrayList<Fuel> fuels = new ArrayList<Fuel>();
  RocketJump rocketJump;
  RocketArm rocketArm;

  //----------Sprites----------
  PImage rocketJumpIcon = loadImage("PowerUps/RocketJump.png");
  PImage rocketArmIcon = loadImage("PowerUps/RocketArm.png");

  //----------Powerup cooldowns----------
  boolean rocketJumpCD = false;
  boolean rocketArmCD = false;
  float rocketJumpCounter = 0f;
  float rocketArmCounter = 0f;
  float rocketJumpDelay = 2.5f;
  float rocketArmDelay = 2f;

  //----------Other----------
  int iconSize = 20;
  int fuelCount = 0;
  int maxFuelCount = 500;
  boolean rocketJumpActive = false;
  boolean rocketArmActive = false;

  PowerUpManager()
  {
    
  }

  void Update()
  {
    HandleInput();

    CheckPowerUps();

    UpdatePowerUps();
    
    if(rocketJumpCD)
    {
      //if still on cooldown, reduce cooldown
      RocketJumpCD();
    }
    if(rocketArmCD)
    {
      //if still on cooldown, reduce cooldown
      RocketArmCD();
    }
  }

  void HandleInput()
  {
    if (input.isK && rocketJumpActive && rocketJump.fuelCost <= fuelCount)
    {
      if(!rocketJumpCD)
      //if not on cooldown
      {
        RocketJump();
        rocketJumpCD = true;
        player.isFire = true;        
        input.isK = false;
      }
    }

    if (input.isL && rocketArmActive && rocketArm.fuelCost <= fuelCount)
    {
      if(!rocketArmCD)
      //if not on cooldown
      {
        RocketArm();
        rocketArmCD = true;
        input.isL = false;
      }
    }
  }

  void CheckPowerUps()
  {
    //check if powerUps are picked up
    if (rocketJump != null && rocketJump.pickedUp)
    {
      rocketJumpActive = true;
    }

    if (rocketArm != null && rocketArm.pickedUp)
    {
      rocketArmActive = true;
    }
  }

  void UpdatePowerUps()
  {
    //make sure fuelCount is never bigger than maxFuelCount
    if(fuelCount > maxFuelCount)
    {
      fuelCount = maxFuelCount;
    }
    for (int i = 0; i < fuels.size(); i++)
    {
      if(fuels.get(i) != null)      
      {
        //play fuel animation
        fuels.get(i).Update();
      } 
    }
    if(rocketJump != null)
      rocketJump.Update();
    if(rocketArm != null)
      rocketArm.Update();
  }

  void RocketJumpCD()
  {
    //reduce cooldown
    rocketJumpCounter += deltaTime;
    if (rocketJumpCounter > rocketJumpDelay)
    {
      rocketJumpCounter = 0;
      rocketJumpCD = false;
    }
  }
  
  void RocketArmCD()
  {
    //reduce cooldown
    rocketArmCounter += deltaTime;
    if (rocketArmCounter > rocketArmDelay)
    {
      rocketArmCounter = 0;
      rocketArmCD = false;
    }
  }

  void RocketJump()
  {
    fuelCount -= rocketJump.fuelCost;
    player.velocity.y = player.jumpVel * -1.4f;
    player.grounded = false;
  }

  void RocketArm()
  {
    fuelCount -= rocketArm.fuelCost;
    //reduce velocity while shooting grappling hook
    player.velocity.x /= 2.5f;
    player.velocity.y /= 2.5f;
    rocketArm.position = player.position.copy();
    rocketArm.savedPositions.add(new PVector(rocketArm.position.x, rocketArm.position.y +10));
    rocketArm.oldPos = rocketArm.position.copy();
    if (player.playerState.currentDirection == 0)
    {
      //if facing left
      rocketArm.facingRight = false;
    } else if (player.playerState.currentDirection == 1)
    {
      //else if facing right
      rocketArm.facingRight = true;
    }
    rocketArm.grapple = true;
  }

  void Draw()
  {
    DrawPowerUps();
    DrawIcons();
  }

  void DrawPowerUps()
  {
      for (int i = 0; i < fuels.size(); i++)
      {
        if(fuels.get(i) != null)        
        fuels.get(i).Draw();
      }
    if(rocketJump != null)
      rocketJump.Draw();
    if(rocketArm != null)
      rocketArm.Draw();
  }

  void DrawIcons()
  {
    pushMatrix();
    translate(width, height - 20);
    if (rocketJumpActive)
    {
      image(rocketJumpIcon, -20, -10, 60, 60);
    }
    if (rocketArmActive)
    {
      image(rocketArmIcon, -60, -10, 60, 60);
    }
    textSize(24);
    fill(255);
    text("Fuel: " + fuelCount, -200, 10);
    popMatrix();
  }
}
