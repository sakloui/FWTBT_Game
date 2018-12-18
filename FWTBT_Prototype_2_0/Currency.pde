class Currency
{
	PVector position;
	PImage currency;

	int currentCoins;
	int size;
	String type;

	Currency(PVector pos, String type)
	{
		  this.type = type;
		  if(type == "norm")
		  	currency = loadImage("Textures/currency.png");
		  else if(type == "gold")
		  	currency = loadImage("Textures/currency_golden.png");
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
	    	if(type == "norm")
	        	gameManager.currencyValues[0]++;
	        else if(type == "gold")
	        	gameManager.currencyValues[0] += 10;
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