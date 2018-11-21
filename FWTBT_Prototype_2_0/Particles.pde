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
		if(vy > - 20)
			vy -= 0.1;



		if(position.y > height*((float) boxManager.rows / 32))
			deletThis();
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