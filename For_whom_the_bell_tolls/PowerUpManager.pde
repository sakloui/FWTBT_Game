class PowerUpManager
{
  ArrayList<Fuel> fuels = new ArrayList<Fuel>();
  RocketJump rocketJump;
  RocketArm rocketArm;

  PImage rocketJumpIcon = loadImage("PowerUps/RocketJump.png");
  PImage rocketArmIcon = loadImage("PowerUps/RocketArm.png");

  int iconSize = 20;
  int fuelCount = 1000;
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
    fuels.add(new Fuel(new PVector(width/2 - 200, height-200)));
    rocketJump = new RocketJump(new PVector(300, height-100));
    rocketArm = new RocketArm(new PVector(500, height-100));
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
      }
    }

    if (input.isL && rocketArmActive && rocketArm.fuelCost <= fuelCount)
    {
      if(!rocketArmCD)
      {
        RocketArm();
        rocketArmCD = true;
      }
    }
  }

  void CheckPowerUps()
  {
    if (rocketJump.pickedUp)
    {
      rocketJumpActive = true;
    }

    if (rocketArm.pickedUp)
    {
      rocketArmActive = true;
    }
  }

  void UpdatePowerUps()
  {
    for (int i = 0; i < fuels.size(); i++)
    {
      fuels.get(i).Update();
    }

    rocketJump.Update();

    rocketArm.Update();
  }

  void RocketJump()
  {
    fuelCount -= rocketJump.fuelCost;
    player.velocity.y = -player.jumpVel;
    player.grounded = false;
  }

  void RocketArm()
  {
    fuelCount -= rocketArm.fuelCost;
    player.velocity.x /= 2.5;
    player.velocity.y /= 2.5;
    rocketArm.position = player.position.copy();
    rocketArm.savedPositions.add(new PVector(rocketArm.position.x, rocketArm.position.y));
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
      fuels.get(i).Draw();
    }

    rocketJump.Draw();

    rocketArm.Draw();
  }

  void DrawIcons()
  {
    pushMatrix();
    translate(width, height - 20);
    if (rocketJumpActive)
    {
      image(rocketJumpIcon, -20, 0);
    }
    if (rocketArmActive)
    {
      image(rocketArmIcon, -60, 0);
    }
    textSize(24);
    text("Fuel: " + fuelCount, -200, 10);
    popMatrix();
  }
}
