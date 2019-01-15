class Currency
{
	PVector position;
	PImage[] currency;

	int currentCoins;
	int size;
	String type;

	int timer;
	int currentCoin;

	Currency(PVector pos, String type)
	{
		  this.type = type;
		  if(type == "norm")
		  	currency = bolts;
		  else if(type == "gold")
		  	currency = goldenBolts;
		  position = pos.copy();
		  size = currency[0].width;
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
	        int r = round(random(0,2));
	        bolt[r].rewind();
	        bolt[r].play();
	    	coins.remove(this);
	    }
	}

	void Update()
	{
		checkCollision();
	}

	void Draw()
	{	
		if(timer == 10)
		{
			timer = 0;
			currentCoin++;
			if(currentCoin > 6) currentCoin = 0;
		}
		else
			timer++;
		image(currency[currentCoin], position.x - camera.shiftX, position.y - camera.shiftY);
	}
}
