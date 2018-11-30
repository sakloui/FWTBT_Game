class BossAttackState extends State
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
		
		//if has attacked
		//SetState(new IdleState());
		//or SetState(new MoveState());
	}

	void OnDraw()
	{
		//draw attacking boss
		pushMatrix();
	    translate(boss.position.x/* - camera.shiftX*/, boss.position.y/* - camera.shiftY*/);
	    if(boss.currentDirection == boss.RIGHT)
	    {
	      image(boss.attack[int(currentFrame)], 0, 0);
	    }
	    else if(boss.currentDirection == boss.LEFT)
	    {
	       pushMatrix();
	       scale(-1.0, 1.0);
	       image(boss.attack[int(currentFrame)],0 ,0);
	       popMatrix();
	    }
	    popMatrix();
	}

	void OnStateExit()
	{
	
	}
}