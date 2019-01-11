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

	Table highscoreTable;
	String names[];

	int score;

	float highscore;
	final float BOLTS_SCORE = 50;
	final float FUEL_SCORE = 10;
	final float MAX_TIME = 120;
	final float MAX_DEATHS = 10;
	
	Highscore()
	{
		highscoreTable = loadTable("data/Highscores.csv", "header");
		names  = loadStrings("data/HighscoreNames.csv");

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

	String getLevelString(int level)
	{
		String levelString = "Level " + level;
		return levelString;
	}

	void checkHighscore()
	{
		score = round(gameManager.currencyValues[4]);

		int finishedLevel = currentLevel;

		checkNewHighscore(finishedLevel);

		saveTable(highscoreTable, "data/highscores.csv");
	}

	void checkNewHighscore(int finishedLevel)
	{
		if(score >= highscoreTable.getInt(9, getLevelString(finishedLevel)))
		{
			println("YOU GOT A HIGHSCORE");
			determineHighscorePlace(finishedLevel);
		}
		else
			println("YOU DIDNT GET THE HIGHSCORE YOU NERD");
	}

	void determineHighscorePlace(int finishedLevel)
	{
		int index = 10;

		while(score >= highscoreTable.getInt(index-1, getLevelString(finishedLevel)))
		{
			index--;

			if(index == 0)
			{
				saveHighscore(index, finishedLevel);
				return;	
			}
		}
		
		saveHighscore(index, finishedLevel);
	}

	void saveHighscore(int index, int finishedLevel)
	{
		moveHighscoresDownTable(index, finishedLevel);
		highscoreTable.setInt(index, getLevelString(finishedLevel), score);
		enterPlayerName();
	}

	void moveHighscoresDownTable(int row, int finishedLevel)
	{
		for(int i = 8; i >= row; i--)
		{
			int origionalScore = highscoreTable.getInt(i, getLevelString(finishedLevel));
			highscoreTable.setInt(i+1, getLevelString(finishedLevel), origionalScore);
		}
	}

	void enterPlayerName()
	{
		
	}

	int getHighscore(int level)
	{
		return int(highscoreTable.getInt(0, getLevelString(level+1)));
	}

	void showHighscore()
	{
		pushMatrix();
		translate(300, 150);
		textAlign(LEFT);
		for(int i = 0; i < 10; i++)
		{
			//textString = ("This %s is %i years old, and weighs %.1f pounds." % (animal, age, weight));
			//String nameText = String.format("%i: %s", (i, names[i]));
			if(i == 0)
				text((i+1) + " :   " + names[i], 0, i * 30);
			else if(i == 9)
				text((i+1) + ": " + names[i], 0, i * 30);
			else
				text(i+1 + ":   " + names[i], 0, i * 30);
			text("Score:  " + highscoreTable.getInt(i, getLevelString(currentLevel)), 400, i * 30);
		}

		textAlign(CENTER);
		
		popMatrix();
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