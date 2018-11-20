class MovingPlatform extends Rectangle
{
	PVector position;
	float platformWidth, platformHeight;
	float maxLeft, maxRight;

	float platformSpeed;
	boolean movingRight;

	MovingPlatform(PVector spawnPos, float platWidth, float platHeight, float farLeft, float farRight)
	{
		position = spawnPos.copy();
		platformWidth = platWidth;
		platformHeight = platHeight;
		maxLeft = farLeft;
		maxRight = farRight;

		platformSpeed = 20f;
		movingRight = true;
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

	void updateMovingPlatform()
	{
		movePlatform();
	}

	void movePlatform()
	{
		if(movingRight)
		{
			if(position.x + (platformWidth/2) > maxRight)
			{
				movingRight = false;
			}
			else 
			{
				position.x += platformSpeed * deltaTime;	
			}
		}
		if(!movingRight)
		{
			if(position.x - (platformWidth/2) < maxLeft)
			{
				movingRight = true;
			}
			else 
			{
				position.x -= platformSpeed * deltaTime;	
			}
		}
	}

	void checkCollisions()
	{
		if(position.x + platformWidth/2 > player.position.x - player.playerWidth/2 &&
		position.x - platformWidth/2 < player.position.x + player.playerWidth/2 &&
		position.y + platformHeight/2 > player.position.y - player.playerHeight/2 &&
		position.y - platformHeight/2 < player.position.y + player.playerHeight/2)
		{
			//player.GetCollisionDirection(this);
		}
	}

	void drawMovingPlatform()
	{
		pushMatrix();
		translate(position.x, position.y);
		rect(0, 0, platformWidth, platformHeight);
		popMatrix();
	}
}