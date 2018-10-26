class Highscore
{
	/*
		Highscore berekenen:
		bolts: 50 punten. secret bolts = 10 bolts
		fuel: 10 punten.
		tijd: 2 minuten max | 2 minuten - tijd / 100 + 1
		deaths: 9 deaths = 10 % van totale score | 8 = 20% etc.



		bolts = 30
		fuel = 75
		tijd = 60 sec
		deaths 4
	*/


	float highscore;
	final float BOLTS_SCORE = 50;
	final float FUEL_SCORE = 10;
	final float MAX_TIME = 120;
	final float MAX_DEATHS = 10;

	String[] highscores = loadStrings("data/highscores.csv");
	
	Highscore()
	{

		//bolts
		highscore = BOLTS_SCORE * gameManager.currencyValues[0];
		highscore += FUEL_SCORE * gameManager.currencyValues[1];
		if((MAX_TIME - gameManager.currencyValues[2])/100 > 0)
			highscore *= (MAX_TIME - gameManager.currencyValues[2])/100 + 1;
		if(gameManager.currencyValues[3] <= MAX_DEATHS)
			if(gameManager.currencyValues[3] != 0)
				highscore *= (MAX_DEATHS - gameManager.currencyValues[3])/MAX_DEATHS + 0.1;
			println((MAX_DEATHS - gameManager.currencyValues[3])/MAX_DEATHS + 0.1);

	}

	void saveHighscore()
	{
			
		highscores[currentLevel - 1] = str(round(gameManager.currencyValues[4]));
		saveStrings("data/highscores.csv", highscores);
		printArray(highscores);	
		highscores = null;		
	}

	void checkHighscore()
	{
		highscores = loadStrings("data/highscores.csv");

		if(int(highscores[currentLevel - 1]) < gameManager.currencyValues[4])
		{
			saveHighscore();
			println("YOU GOT A HIGHSCORE");
		}
		else
			println("YOU DIDNT GET THE HIGHSCORE YOU NERD");		
	}

	void updateScore()
	{
		highscore = BOLTS_SCORE * gameManager.currencyValues[0];
		highscore += FUEL_SCORE * gameManager.currencyValues[1];
		if((MAX_TIME - gameManager.currencyValues[2])/100 > 0)
			highscore *= (MAX_TIME - gameManager.currencyValues[2])/100 + 1;
		if(gameManager.currencyValues[3] <= MAX_DEATHS)
		{
			if(gameManager.currencyValues[3] != 0)
				highscore *= (MAX_DEATHS - gameManager.currencyValues[3])/MAX_DEATHS + 0.1;
		}
		else
		highscore *= 0.1;

		gameManager.currencyValues[4] = highscore;	
	}
}