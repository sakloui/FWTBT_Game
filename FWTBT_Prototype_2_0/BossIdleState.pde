class BossIdleState extends State
{
  float animationSpeed;
  float currentFrame;
  float bossMoveSpeed = 200;
  float playerAggroRange = 5;
  boolean movingRight;
  float moveLimit = 480;

  void OnStateEnter()
  {
    animationSpeed = 0.05f;
    currentFrame = 0;

    if (boss != null)
      movingRight = boss.movingRight;
  }

  void OnTick()
  {
    currentFrame = (currentFrame + animationSpeed) % 2;


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
      boss.SetState(new BossAttackState());
    }
  }

  void OnDraw()
  {
    //draw idle animation
    pushMatrix();
    translate(boss.position.x - camera.shiftX, boss.position.y - camera.shiftY);
    image(boss.bossSprite, 0, 0);
    if (boss.currentDirection == boss.RIGHT)
    {
      //image(boss.idle[int(currentFrame)], 0, 0);
    } else if (boss.currentDirection == boss.LEFT)
    {
      pushMatrix();
      scale(-1.0, 1.0);
      //image(boss.idle[int(currentFrame)], 0, 0);
      popMatrix();
    }
    popMatrix();
  }

  void OnStateExit()
  {
    boss.movingRight = movingRight;
  }
}
