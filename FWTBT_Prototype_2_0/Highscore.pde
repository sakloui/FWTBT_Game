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
	Table nameTable;

	int score;
	int highscoreRow;
	float highscoreTableLineSpacing = 30f;
	color blinkingTextColor = /*color(255, 99, 71)*/color(225, 131, 26);
	String topString = "Enter your name below";
	int maxPlayerNameLength = 12;

	float highscore;
	final float BOLTS_SCORE = 50;
	final float FUEL_SCORE = 10;
	final float MAX_TIME = 120;
	final float MAX_DEATHS = 10;
	
	Highscore()
	{
		highscoreTable = loadTable("data/Highscores.csv", "header");
		nameTable = loadTable("data/PlayerNames.csv", "header");

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

		if(score >= highscoreTable.getInt(9, getLevelString(currentLevel)))
		{
			println("YOU GOT A HIGHSCORE");
			determineHighscorePlace(currentLevel);
			saveTable(highscoreTable, "data/Highscores.csv");
			saveTable(nameTable, "data/PlayerNames.csv");
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
		moveValuesDownTables(index, finishedLevel);
		highscoreTable.setInt(index, getLevelString(finishedLevel), score);
		enterPlayerName(index);
	}

	void moveValuesDownTables(int row, int finishedLevel)
	{
		for(int i = 8; i >= row; i--)
		{
			//move the highscores down the highscore table
			int originalScore = highscoreTable.getInt(i, getLevelString(finishedLevel));
			highscoreTable.setInt(i+1, getLevelString(finishedLevel), originalScore);

			//move the names down the name table
			String originalname = nameTable.getString(i, getLevelString(finishedLevel));
			nameTable.setString(i+1, getLevelString(finishedLevel), originalname);
		}
		nameTable.setString(row, getLevelString(finishedLevel), "");
	}

	void enterPlayerName(int index)
	{
		highscoreRow = index;
		isTypingName = true;
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
			fill(0);
			if(isTypingName)
			{
				if(i == highscoreRow)
					fill(blinkingTextColor, menu.textAlpha);
			}
			//textString = ("This %s is %i years old, and weighs %.1f pounds." % (animal, age, weight));
			if(i == 0)
				text((i+1) + " :   " + nameTable.getString(i, getLevelString(currentLevel)), 4, i * highscoreTableLineSpacing);
			else if(i == 9)
				text((i+1) + ": " + nameTable.getString(i, getLevelString(currentLevel)), 0, i * highscoreTableLineSpacing);
			else
				text(i+1 + ":   " + nameTable.getString(i, getLevelString(currentLevel)), 0, i * highscoreTableLineSpacing);
			text("Score:  " + highscoreTable.getInt(i, getLevelString(currentLevel)), 400, i * highscoreTableLineSpacing);
		}

		textAlign(CENTER);
		popMatrix();

		if(isTypingName)
		{
			text(topString, width/2, 100);
			text("Press enter to confirm your name", width/2, 500);
		}
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