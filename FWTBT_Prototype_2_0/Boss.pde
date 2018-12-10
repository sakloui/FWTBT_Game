class Boss
{
	//----------Position----------
	PVector position;

	//----------Aggroo----------
	float aggroRange;
	float attackRange;

	//----------Animation----------
	PImage[] idle;
	PImage[] run;
	PImage[] attack;

	float currentFrame;
	float animationSpeed = 0.3f;
	
	//----------Other----------
	int currentDirection;
	final int LEFT = 0, RIGHT = 1;

	State currentState;

	Boss()
	{
		//set position
		//set aggro- and attack range
		//set facing direction
		
		setupSprites();
		SetState(new IdleState());
	}

	void setupSprites()
	{
		//load the sprites
		idle = new PImage[2];
	    String idleName;

	    run = new PImage[8];
	    String runName;

	    attack = new PImage[5];
	    String attackName;

	    //load idle sprites
	    for (int i = 0; i < idle.length; i++)
	    {
	      idleName = "Sprites/Idle (" + i + ").png";
	      idle[i] = loadImage(idleName);
	    }

	    //load attack sprites
	    for (int i = 0; i < attack.length; i++)
	    {
	      attackName = "Sprites/Attack (" + i + ").png";
	      attack[i] = loadImage(attackName);
	    }

	    //load run sprites
	    for (int i = 0; i < 8; i++)
	    {
	      runName = "Sprites/Run (" + i + ").png";
	      run[i] = loadImage(runName);
	    }
	}

	void bossUpdate()
	{
		//set the direction the boss is facing
		if(position.x - player.position.x < 0)
			currentDirection = 1;
		else
			currentDirection = 0;	

		//update the current state
		currentState.OnTick();
	}

	void bossDraw()
	{
		//draw the current state
		currentState.OnDraw();
	}

	void SetState(State state)
	{
	  if (currentState != null)
	  {
	    currentState.OnStateExit();
	  }

	  //set currentState to new state
	  currentState = state;

	  if (currentState != null)
	  {
	    currentState.OnStateEnter();
	  }
	}
}