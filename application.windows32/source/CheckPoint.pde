class CheckPoint
{
	PVector position;
	float checkPointWidth, checkPointHeight;
	color checkPointColor;

	int checkPointIndex;
	boolean reachedCheckPoint;

	CheckPoint(PVector pos, int index)
	{
		position = pos;
		checkPointWidth = 40f;
		checkPointHeight = 60f;
		checkPointColor = color(150, 0, 0);
		reachedCheckPoint = false;

		checkPointIndex = index;
		checkPointManager.addCheckPoint();
	}

	void updateCheckPoint()
	{
		println(checkPointIndex + ": " + reachedCheckPoint);
		if(this.position.x + checkPointWidth/2 > player.position.x - player.playerWidth/2 && 
	       this.position.x - checkPointWidth/2 < player.position.x + player.playerWidth/2 && 
	       this.position.y + checkPointHeight/2 > player.position.y - player.playerHeight/2 &&
	       this.position.y - checkPointHeight/2 < player.position.y + player.playerHeight/2)
	    {
	    	this.reachedCheckPoint = true;
	    	checkPointManager.checkPointReached(checkPointIndex);
	    }

	    if(reachedCheckPoint)
	    	checkPointColor = color(0, 200, 0);
	}

	void drawCheckPoint()
	{
		pushMatrix();
		translate(position.x, position.y+10f);
		fill(checkPointColor);
		rect(0, 0, checkPointWidth, checkPointHeight);
		popMatrix();
	}
}
