class PowerUpManager
{
  ArrayList<Fuel> fuels = new ArrayList<Fuel>();
  RocketJump rocketJump;
  RocketArm rocketArm;

  PImage rocketJumpIcon = loadImage("PowerUps/RocketJump.png");
  PImage rocketArmIcon = loadImage("PowerUps/RocketArm.png");

  int iconSize = 20;
  int fuelCount = 0;
  int maxFuelCount = 150;
  boolean rocketJumpActive = false;
  boolean rocketArmActive = false;

  boolean rocketJumpCD = false;
  boolean rocketArmCD = false;
  float rocketJumpCounter = 0f;
  float rocketArmCounter = 0f;
  float rocketJumpDelay = 2.5f;
  float rocketArmDelay = 2f;

  PowerUpManager()
  {
    SpawnObjects();
  }

  void SpawnObjects()
  {
  }

  void Update()
  {
    HandleInput();

    CheckPowerUps();

    UpdatePowerUps();

    if(rocketJumpCD)
      RocketJumpCD();
    if(rocketArmCD)
      RocketArmCD();
  }

  void RocketJumpCD()
  {
    rocketJumpCounter += deltaTime;
    if (rocketJumpCounter > rocketJumpDelay)
    {
      rocketJumpCounter = 0;
      rocketJumpCD = false;
    }
  }

  void RocketArmCD()
  {
    rocketArmCounter += deltaTime;
    if (rocketArmCounter > rocketArmDelay)
    {
      rocketArmCounter = 0;
      rocketArmCD = false;
    }
  }

  void HandleInput()
  {
    if (input.isK && rocketJumpActive && rocketJump.fuelCost <= fuelCount)
    {
      if(!rocketJumpCD)
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
      {
        RocketArm();
        rocketArmCD = true;
        input.isL = false;
      }
    }
  }

  void CheckPowerUps()
  {
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
    if(fuelCount > maxFuelCount)
    {
      fuelCount = maxFuelCount;
    }
    for (int i = 0; i < fuels.size(); i++)
    {
      if(fuels.get(i) != null)
      fuels.get(i).Update();
    }
    if(rocketJump != null)
      rocketJump.Update();
    if(rocketArm != null)
      rocketArm.Update();
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
    player.velocity.x /= 2.5;
    player.velocity.y /= 2.5;
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
