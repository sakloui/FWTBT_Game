class Fire
{
	PVector position;
	boolean underPlayer;
	float size;

	float currentFrame;
	float animationSpeed;

	Fire(PVector pos)
	{
		position = pos;
		underPlayer = false;
		size = 40f;

		animationSpeed = 0.3f;
	}

	void updateFire()
	{
		currentFrame = (currentFrame + animationSpeed) % 2;
	}

	void drawFire()
	{
		pushMatrix();
		translate(position.x, position.y);
		rect(0, 0, size, size);
		popMatrix();
	}
}
