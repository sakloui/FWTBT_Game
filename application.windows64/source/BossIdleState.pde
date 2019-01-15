class BossIdleState extends State
{
  Boss boss;

  float animationSpeed;
  float currentFrame;
  float bossMoveSpeed = 200;
  float playerAggroRange = 5;
  boolean movingRight;
  float moveLimit = 480;

  float laserCooldown = 3f;
  float laserCooldownCounter;

  BossIdleState(Boss boss)
  {
    this.boss = boss;
  }

  void OnStateEnter()
  {
    animationSpeed = 0.25f;
    currentFrame = 0;

    if (boss != null)
      movingRight = boss.movingRight;
  }

  void OnTick()
  {
    currentFrame = (currentFrame + animationSpeed) % 6;

    laserCooldown();

    if (movingRight)
    {
      boss.position.x = boss.position.x + bossMoveSpeed * deltaTime;
      if (boss.position.x >= boss.spawnPosition.x + moveLimit)
      {
        movingRight = false;
      }
    } else
    {
      boss.position.x = boss.position.x - bossMoveSpeed * deltaTime;
      if ( boss.position.x <= boss.spawnPosition.x - moveLimit)
      {
        movingRight = true;
      }
    }

    //if player is within boss aggro range
    if (abs(player.position.x - boss.position.x) <= playerAggroRange) {
      boss.SetState(new BossAttackState(this.boss));
    }
  }

  void laserCooldown()
  {
    laserCooldownCounter += deltaTime;
    if (laserCooldownCounter >= laserCooldown)
    {
      laserCooldownCounter = 0f;
      boss.SetState(new BossLaserState(this.boss));
    }
  }

  void OnDraw()
  {
    //draw idle animation
    pushMatrix();
    
    translate(boss.position.x - camera.shiftX, boss.position.y - camera.shiftY);
    
    image(idle[int(currentFrame)], 0, 0);
    
    popMatrix();
  }

  void OnStateExit()
  {
    boss.movingRight = movingRight;
  }
}
