class Currency
{
	PVector position;
	PImage currency;

	int currentCoins;
	int size;

	Currency(PVector pos)
	{
		  currency = loadImage("Textures/currency.png");
		  position = pos.copy();
		  size = currency.width;
	}

	void checkCollision()
	{
	    if(position.x + size/2 > player.position.x - player.playerWidth/2 && 
	       position.x - size/2 < player.position.x + player.playerWidth/2 && 
	       position.y + size/2 > player.position.y - player.playerHeight/2 &&
	       position.y - size/2 < player.position.y + player.playerHeight/2)
	    {
	        gameManager.currencyValues[0]++;
	    	coins.remove(this);
	    }
	}

	void Update()
	{
		checkCollision();
	}

	void Draw()
	{
		image(currency, position.x - camera.shiftX, position.y - camera.shiftY);
	}
}