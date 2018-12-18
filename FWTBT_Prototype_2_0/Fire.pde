class Fire
{
	//----------Properties----------
	float size;

	//----------Position----------
	PVector position;
	
	//----------Animation----------
	//currentFrame represents the specific image from the array that's being drawn
	float currentFrame;
	float animationSpeed;

	//----------Other----------
	boolean underPlayer;

	Fire(PVector pos)
	{
		position = pos.copy();
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