class BossAttackState extends State
{
  float animationSpeed;
  float currentFrame;
  float lockOnTime = 0.5;
  float lockOnProgress;
  float chargeSpeed = 400;
  PVector targetPos;
  PVector beforeChargePosition;
  boolean lockedOnPlayer;
  boolean returnToIdle;

  void OnStateEnter()
  {
    animationSpeed = 0.05f;
    currentFrame = 0;
    lockOnProgress = 0;
    lockedOnPlayer = false;
    returnToIdle = false;
    beforeChargePosition = boss.position.copy();
  }

  void OnTick()
  {
    currentFrame = (currentFrame + animationSpeed) % 2;
    if (!lockedOnPlayer)
    {
      lockOnPlayer();
    } else {
      if (!returnToIdle)
      {
        chargeAtPlayer();
        checkMapBounds();
      } else
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
      targetPos.normalize();
      lockedOnPlayer = true;
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
      returnToIdle = true;
    }
    if (boss.position.y + boss.bossSize/2 >= height - 40||boss.position.y - boss.bossSize/2 <= 0f + 40 )
    {
      returnToIdle = true;
    }
  }

  void returnToIdlePosition()
  {
    boss.position.x -= targetPos.x * chargeSpeed * deltaTime;
    boss.position.y -= targetPos.y * chargeSpeed * deltaTime;
    if (boss.position.dist(beforeChargePosition) <= 5)
    {
      boss.SetState(new BossIdleState());
    }
  }

  void OnDraw()
  {
    //draw attacking boss
    pushMatrix();
    translate(boss.position.x/* - camera.shiftX*/, boss.position.y/* - camera.shiftY*/);
    ellipse(0, 0, boss.bossSize, boss.bossSize);
    if (boss.currentDirection == boss.RIGHT)
    {
      //image(boss.attack[int(currentFrame)], 0, 0);
    } else if (boss.currentDirection == boss.LEFT)
    {
      pushMatrix();
      scale(-1.0, 1.0);

      //image(boss.attack[int(currentFrame)],0 ,0);
      popMatrix();
    }
    popMatrix();
  }

  void OnStateExit()
  {
    boss.position.y = boss.spawnPosition.y;
  }
}
