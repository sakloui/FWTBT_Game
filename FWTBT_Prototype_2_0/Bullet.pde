class Bullets
{
	int direction;
	PVector position;
	float speed = 400;
	float size = 10;
	Bullets(PVector pos,int dir)
	{
		direction = dir;
		position = pos.copy();
	}

	void Update()
	{
		if(direction == LEFT)
			position.x -= speed*deltaTime;
		if(direction == RIGHT)
			position.x += speed*deltaTime;

		checkOOB();
		CheckCollision();
	}

	void checkOOB()
	{
		if(position.x > width || position.x < 0 || position.y > height || position.y < 0)
			bullet.remove(this);
	}

	void CheckCollision()
	{
   		for (int i = 0; i < boxManager.rows; i++)
	    {
	    	for (int j = 0; j < boxManager.columns; ++j) 
	    	{
			    if(position.x + size/2 > boxManager.boxes[i][j].position.x - boxManager.boxes[i][j].size/2 &&
			       position.x - size/2 < boxManager.boxes[i][j].position.x + boxManager.boxes[i][j].size/2 &&
			       position.y + size/2 > boxManager.boxes[i][j].position.y - boxManager.boxes[i][j].size/2 &&
			       position.y - size/2 < boxManager.boxes[i][j].position.y + boxManager.boxes[i][j].size/2)
			    {  	    		
			        if (boxManager.boxes[i][j].collides == 1 ||
			            boxManager.boxes[i][j].collides == 5 ||
			            boxManager.boxes[i][j].collides == 15 ||
			            boxManager.boxes[i][j].collides == 16 ||
			            boxManager.boxes[i][j].collides == 17 ||
			            boxManager.boxes[i][j].collides == 18)
			        {          
		      			bullet.remove(this);     
			        }
			    }
	        }
	    }
	}	

	void Draw()
	{
		pushMatrix();
		translate(position.x - camera.shiftX,position.y - camera.shiftY);
		fill(255);
		rect(0,0,size,size);
		popMatrix();
		noFill();
	}
}