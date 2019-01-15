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
			CheckPoint checkPoint = checkPoints.get(i);
			checkPoint.updateCheckPoint();
		}
	}

	void setPreviousCheckPointsReached()
	{
		for(int i = 0; i < currentCheckPoint; i++)
		{
			if(i+1 < currentCheckPoint && checkPoints.get(i).reachedCheckPoint == false)
			{
				//println("currentCheckPoint: "+currentCheckPoint);
				checkPoints.get(i).reachedCheckPoint = true;
			}
		}
		println();
	}

	void restoreCheckPoints()
	{
		currentCheckPoint = gameManager.furthestCheckPoint;
		setPreviousCheckPointsReached();
	}

	void checkPointReached(int checkPoint)
	{
		if(checkPoint > currentCheckPoint)
			currentCheckPoint = checkPoint;

		setPreviousCheckPointsReached();
	}

	void drawCheckPointManager()
	{
		for(int i = 0; i < amountOfCheckPoints; i++)
		{
			checkPoints.get(i).drawCheckPoint();
		}
	}
}
