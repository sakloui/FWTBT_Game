class SlipperyTile
{
	PVector position;
	boolean underPlayer;
	float size;

	SlipperyTile(PVector pos)
	{
		position = pos.copy();
		underPlayer = false;
		size = 40f;
	}

	void updateSlipperyTile()
	{
		if(abs(player.position.x - position.x) < (player.playerWidth/2) && position.y - player.position.y <= player.playerHeight + boxManager.boxSize)
		{
			underPlayer = true;
		}
		else
		{
			underPlayer = false;	
		}
	}

	void drawSlipperyTile()
	{
		pushMatrix();
		translate(position.x, position.y);
		rect(0, 0, size, size);
		popMatrix();
	}
}