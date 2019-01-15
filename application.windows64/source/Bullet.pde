class Bullets
{
	int direction;
	PVector position;
	float speed = 400;
	float size = 10;
	float rotation;
	int despawnTime = 700;
	Bullets(PVector pos,int dir,float rot)
	{
		direction = dir;
		position = pos.copy();
		rotation = rot;
		if(dir == LEFT && degrees(rotation) <= 170 && degrees(rotation) >= 0)
			rotation = radians(170);
		if(dir == LEFT && degrees(rotation) >= -170 && degrees(rotation) <= 0)
			rotation = radians(-170);					
		if(dir == RIGHT && degrees(rotation) <= -10)
			rotation = radians(-10);
		if(dir == RIGHT && degrees(rotation) >= 10)
			rotation = radians(10);						


	}

	void Update()
	{
		if(!pauseWorld)
		{
			position.x += cos(rotation)*(speed*deltaTime);
			position.y += sin(rotation)*(speed*deltaTime);
			checkOOB();
			CheckCollision();
			CheckKill();
			despawn();
		}
	}

	void checkOOB()
	{
		if(position.x > (width*(boxManager.rows/32.0)) || position.x < 0 || position.y > height*(boxManager.columns/18.0) || position.y < 0)
		{
			bullet.remove(this);
		}
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
	void CheckKill()
	{
	  if(position.x + size/2 > player.position.x - player.playerWidth/2 &&
	  position.x - size/2 < player.position.x + player.playerWidth/2 &&
	  position.y + size/2 > player.position.y - player.playerHeight/2 &&
	  position.y - size/2 < player.position.y + player.playerHeight/2)
	  {    
	    boxManager = new BoxManager(currentLevel);
	    gameManager.currencyValues[3]++;
	  }        
	}

	void despawn()
	{
		if(despawnTime == 0)
		{
			bullet.remove(this);
		}
		else despawnTime--;
	}

	void Draw()
	{
		pushMatrix();
		translate(position.x - camera.shiftX,position.y - camera.shiftY);
		fill(255,0,0);
		rect(0,0,size,size);
		popMatrix();
		noFill();
	}
}
