class CheckPointManager
{
	ArrayList<CheckPoint> checkPoints;
	//incremented by every checkpoint instantiated
	int amountOfCheckPoints;
	int currentCheckPoint;

	CheckPointManager()
	{
		checkPoints = new ArrayList<CheckPoint>();
		currentCheckPoint = 0;
	}

	void addCheckPoint()
	{
		amountOfCheckPoints++;
	}

	int getCurrentCheckPoint()
	{
		return currentCheckPoint;
	}

	void updateCheckPointManager()
	{
		for(int i = 0; i < amountOfCheckPoints; i++)
		{
			checkPoints.get(i).updateCheckPoint();
		}
	}

	void checkPointReached(int checkPoint)
	{
		if(checkPoint > currentCheckPoint)
			currentCheckPoint = checkPoint;
	}

	void drawCheckPointManager()
	{
		for(int i = 0; i < amountOfCheckPoints; i++)
		{
			checkPoints.get(i).drawCheckPoint();
		}
	}
}