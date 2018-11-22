class Particles
{
	PVector position;
	float vx;
	float size = 5;
	
	float vy;
	Particles(PVector pos)
	{
		position = pos.copy();
		vx = random(-3,3);
		vy = random(-1,4);
	}

	void Update()
	{
		position.x += vx;
		if(vx != 0)
		{
			if(vx > 0)
				vx -= 0.05;
			else
				vx += 0.05;
		}
		position.y -= vy;
		if(vy > -20)
			vy -= 0.1;



		if(position.y > height*((float) boxManager.rows / 32))
			deletThis();

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
			        	if(vy > -1 && vy < 1)
			        	{
			        		deletThis();
			        	} 
			        	position.y = boxManager.boxes[i][j].position.y - boxManager.boxes[i][j].size/2 - 0.1;
		      			vy *= -0.6;     
			        }
			    }
	        }
	    }		
	}

	void deletThis()
	{
		particle.remove(this);
	}

	void Draw()
	{
		fill(255,255,0);
		rect(position.x - camera.shiftX ,position.y - camera.shiftY,size,size);
		noFill();
	}
}