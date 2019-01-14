class BossMoveState extends State
{
  float animationSpeed;
  float currentFrame;

  void OnStateEnter()
  {
    animationSpeed = 0.05f;
    currentFrame = 0;
  }

  void OnTick()
  {
    currentFrame = (currentFrame + animationSpeed) % 2;

    //move boss

    //if player is within attack range
    //SetState(new BossAttackState());
  }

  void OnDraw()
  {
    //draw movement animation
    pushMatrix();
    translate(boss.position.x/* - camera.shiftX*/, boss.position.y/* - camera.shiftY*/);
    image(bossSprite, 0, 0);
    if (boss.currentDirection == boss.RIGHT)
    {
      //image(boss.run[int(currentFrame)], 0, 0);
    } else if (boss.currentDirection == boss.LEFT)
    {
      pushMatrix();
      scale(-1.0, 1.0);
      //image(boss.run[int(currentFrame)], 0, 0);
      popMatrix();
    }
    popMatrix();
  }

  void OnStateExit()
  {
  }
}
