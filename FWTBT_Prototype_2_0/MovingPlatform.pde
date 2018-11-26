class MovingPlatform extends Rectangle
{
	PVector position;
	float maxLeft, maxRight;

	float platformSpeed;
	boolean movingRight;
	boolean movesPlayer;

	MovingPlatform(PVector spawnPos, float platWidth, float platHeight, float farLeft, float farRight, boolean movesPlayer)
	{
		position = spawnPos.copy();
		rectWidth = platWidth;
		rectHeight = platHeight;
		maxLeft = farLeft;
		maxRight = farRight;

		platformSpeed = 200f;
		movingRight = true;

		name = "MovingPlatform";

		this.movesPlayer = movesPlayer;
	}

	protected String getName() {
		return name;
	}

	protected float getX()
	{
		return position.x;
	}

	protected float getY()
	{
		return position.y;
	}

	protected float getSize() {
		return size;
	}

	protected float getWidth() {
		return rectWidth;
	}

	protected float getHeight() {
		return rectHeight;
	}

	protected float getTop() {
		return top;
	}

	protected float getBottom() {
		return bottom;
	}

	protected float getLeft() {
		return left;
	}

	protected float getRight() {
		return right;
	}

	void SetPosValues()
	{
		top = position.y - rectHeight/2;
		bottom = top + rectHeight;
		right = position.x + rectWidth/2;
		left = right - rectWidth;
	}

	void updateMovingPlatform()
	{
		SetPosValues();
		movePlatform();
		checkCollisions();
	}

	void movePlatform()
	{
		if(movingRight)
		{
			if(position.x + (rectWidth/2) > maxRight)
			{
				movingRight = false;
			}
			else 
			{
				position.x += platformSpeed * deltaTime;	
			}
		}
		else if(!movingRight)
		{
			if(position.x - (rectWidth/2) < maxLeft)
			{
				movingRight = true;
			}
			else 
			{
				position.x -= platformSpeed * deltaTime;	
			}
		}

		if(movingRight)
		{
			//position.x += platformSpeed * deltaTime;
			if(player.onMovingPlatform)
			{
				player.position.x += platformSpeed * deltaTime;
			}
		}
		else
		{
			//position.x -= platformSpeed * deltaTime;	
			if(player.onMovingPlatform)
			{
				player.position.x -= platformSpeed * deltaTime;
			}
		}
	}

	void checkCollisions()
	{
		if(player.onMovingPlatform)
		{
			if((player.position.x > position.x + (rectWidth/2) + (player.playerWidth/2)) || (player.position.x < position.x - (rectWidth/2) - (player.playerWidth/2)))
				player.onMovingPlatform = false;
		}

		if(position.x + rectWidth/2 > player.position.x - player.playerWidth/2 &&
		position.x - rectWidth/2 < player.position.x + player.playerWidth/2 &&
		position.y - (rectHeight/2)+1 > player.position.y - player.playerHeight/2 &&
		position.y - rectHeight/2 < player.position.y + player.playerHeight/2)
		{
			player.GetCollisionDirection(this);
		}
	}

	void drawMovingPlatform()
	{
		pushMatrix();
		translate(position.x, position.y);
		rect(0, 0, rectWidth, rectHeight);
		popMatrix();
	}
}