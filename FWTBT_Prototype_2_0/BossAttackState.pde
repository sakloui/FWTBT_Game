class BossAttackState extends State
{
  Boss boss;

  float animationSpeed;
  float currentFrame;

  float lockOnTime = 0.5;
  float lockOnProgress;

  float stunDuration = 0.7f;
  float timeStunned;
  
  float chargeSpeed = 400;
  
  float grappleDamage = 10f;

  PVector targetPos;
  PVector beforeChargePosition;
  
  boolean lockedOnPlayer;
  boolean hasCharged;
  boolean returnToIdle;

  BossAttackState(Boss boss)
  {
    this.boss = boss;
  }

  void OnStateEnter()
  {
  	//animation
    animationSpeed = 0.15f;
    currentFrame = 0;

    lockOnProgress = 0;
    lockedOnPlayer = false;

    returnToIdle = false;
    beforeChargePosition = boss.position.copy();

    powerUpManager.fuelCount = 99999;
  }

  void OnTick()
  {
    currentFrame = (currentFrame + animationSpeed) % 6;
    if (!lockedOnPlayer)
    {
      lockOnPlayer();
    } else {
      if (!returnToIdle && !hasCharged)
      {
        chargeAtPlayer();
        checkMapBounds();
      } else if(hasCharged)
      {
        stunned();
        checkGrappleCollision();
      }
      else
      {
        returnToIdlePosition();
      }
    }

    //if has attacked
    //SetState(new IdleState());
    //or SetState(new MoveState());
  }

  void lockOnPlayer()
  {
    lockOnProgress += deltaTime;
    if ( lockOnProgress >= lockOnTime)
    {
      targetPos = player.position.copy().sub(boss.position.copy());
      if(player.velocity.x > 0)
        targetPos.x += random(350);
      else if(player.velocity.x < 0)
        targetPos.x -= random(350);
      targetPos.normalize();
      lockedOnPlayer = true;
    }
  }

  void stunned()
  {
    timeStunned += deltaTime;
    if ( timeStunned >= stunDuration)
    {
      hasCharged = false;
      returnToIdle = true;
    }
  }

  void checkGrappleCollision()
  {
    RocketArm rocketArm = powerUpManager.rocketArm;
    if((boss.position.x-rocketArm.position.x) * (boss.position.x-rocketArm.position.x) + 
      (rocketArm.position.y-boss.position.y) * (rocketArm.position.y-boss.position.y)
      <= (60+1) * (60+1))
    {
      //return grapple
      if(!rocketArm.returnGrapple)
      {
        rocketArm.grapple = false;
        rocketArm.targetPos.x *= -1;
        rocketArm.returnGrapple = true;  

        boss.takeDamage(grappleDamage);
      }
    }
  }

  void chargeAtPlayer()
  {
    boss.position.x += targetPos.x * chargeSpeed * deltaTime;
    boss.position.y += targetPos.y * chargeSpeed * deltaTime;
  }

  void checkMapBounds()
  {
    if (boss.position.x + boss.bossSize/2 >= width - 40||boss.position.x - boss.bossSize/2 <= 0 + 40 )
    {
      hasCharged = true;
    }
    if (boss.position.y + boss.bossSize/2 >= height - 40||boss.position.y - boss.bossSize/2 <= 0f + 40 )
    {
      hasCharged = true;
    }
  }

  void returnToIdlePosition()
  {
    boss.position.x -= targetPos.x * chargeSpeed * deltaTime;
    boss.position.y -= targetPos.y * chargeSpeed * deltaTime;
    if (boss.position.dist(beforeChargePosition) <= 5)
    {
      boss.SetState(new BossIdleState(this.boss));
    }
  }

  void OnDraw()
  {
    //draw attacking boss
    pushMatrix();

    translate(boss.position.x/* - camera.shiftX*/, boss.position.y/* - camera.shiftY*/);

    image(boss.charge[int(currentFrame)], 0, 0);

    popMatrix();

  }

  void OnStateExit()
  {
    boss.position.y = boss.spawnPosition.y;
  }
}
