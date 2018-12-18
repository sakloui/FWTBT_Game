class Laser
{
	//----------Properties----------
	color laserColor;
	float laserLength;

	//----------Position----------
	PVector spawnPos;
	PVector endPoint;

	//----------Other----------
	//the laser rotates from minAngle to maxAngle and vice versa
	float minAngle, maxAngle;
	float direction;
	float rotationSpeed;
	float angle;

	boolean movingUp;

	final int LEFT = 0, RIGHT = 1, MIXED = 2;

	Laser(PVector pos, float minAngle, float maxAngle, float speed, float length, int dir)
	{
		//startPoint of the laser, the laser rotates around the spawnPos
		spawnPos = pos.copy();
		this.minAngle = minAngle;
		this.maxAngle = maxAngle;
		rotationSpeed = speed;
		laserLength = length;
		direction = dir;
		if(dir == RIGHT)
			movingUp = true;
		else if(direction == LEFT)
			movingUp = false;	
		laserColor = color(255, 0, 0);
		endPoint = new PVector(0, 0);
		
		angle = minAngle;

		//the tip of the laser 
		endPoint.x = spawnPos.x + (cos(radians(angle)) * laserLength);
		endPoint.y = spawnPos.y + (sin(radians(angle)) * laserLength);
	}

	void updateLaser()
	{
		moveLaser();
		checkCollision();
	}

	void moveLaser()
	{
		if(direction == LEFT)
			angle -= rotationSpeed * deltaTime;
		else if(direction == RIGHT)
			angle += rotationSpeed * deltaTime;
		else if(direction == MIXED)
		{
			if(movingUp && angle >= maxAngle)
				movingUp = false;
			else if(movingUp && angle < maxAngle)
				angle += rotationSpeed * deltaTime; 
			if(!movingUp && angle <= minAngle)
				movingUp = true;
			else if(!movingUp && angle > minAngle)
				angle -= rotationSpeed * deltaTime;
		}
		
		endPoint.x = spawnPos.x + (cos(radians(angle)) * laserLength);
		endPoint.y = spawnPos.y + (sin(radians(angle)) * laserLength);
	}

	void checkCollision()
	{
		if(isIntersecting(spawnPos.x, spawnPos.y, endPoint.x, endPoint.y, player.position.x, player.top + 10, player.position.x, player.bottom))
		{
			println("Intersecting " + deltaTime);
		}
	}

	boolean isIntersecting(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) 
	{
		float denominator = ((x2 - x1) * (y4 - y3)) - ((y2 - y1) * (x4 - x3));
		float numerator1 = ((y1 - y3) * (x4 - x3)) - ((x1 - x3) * (y4 - y3));
		float numerator2 = ((y1 - y3) * (x2 - x1)) - ((x1 - x3) * (y2 - y1));

		// Detect coincident lines (has a problem, read below)
		if (denominator == 0) return numerator1 == 0 && numerator2 == 0;

		float r = numerator1 / denominator;
		float s = numerator2 / denominator;

		return (r >= 0 && r <= 1) && (s >= 0 && s <= 1);
	}

	void drawLaser()
	{
		pushMatrix();
		strokeWeight(10);
		stroke(laserColor);
		line(endPoint.x, endPoint.y, spawnPos.x, spawnPos.y);

		//strokeWeight(4);
		//stroke(255);
		//line(player.position.x, player.top + 10, player.position.x, player.bottom);

		text("angle: " + angle, width/2, 100);
		text("minAngle: " + minAngle, width/2, 200);
		text("maxAngle: " + maxAngle, width/2, 300);

		fill(255, 255, 0);
		noStroke();
		ellipse(spawnPos.x, spawnPos.y, 10, 10);
		fill(255);
		ellipse(endPoint.x, endPoint.y, 10, 10);

		popMatrix();
	}
}