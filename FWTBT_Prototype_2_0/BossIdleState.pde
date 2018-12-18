class BossIdleState extends State
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
		
		//if player is within boss aggro range
		//SetState(new BossAttackState())
	}

	void OnDraw()
	{
		//draw idle animation
		pushMatrix();
	    translate(player.position.x - camera.shiftX, player.position.y - camera.shiftY);
	    if(boss.currentDirection == RIGHT)
	    {
	      image(player.idle[int(currentFrame)], 0, 0);
	    }
	    else if(boss.currentDirection == LEFT)
	    {
	      pushMatrix();
	      scale(-1.0, 1.0);
	      image(player.idle[int(currentFrame)],0 ,0);
	      popMatrix();
	    }
	    popMatrix();
	}

	void OnStateExit()
	{

	}
}