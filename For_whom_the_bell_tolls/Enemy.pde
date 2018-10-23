class Enemy {
  float x, y;
  float radius;
  float vx;
  float top, bottom, left, right;
  float boxSize = 40f;
  PVector[] boxesToCheck = new PVector[2];

  Enemy(float spawnX, float spawnY) 
  {
    radius = 20;
    x = spawnX;
    y = spawnY;
    vx = 1;
  }

  void CheckCollision()
  {
    if (x + radius > player.position.x - player.playerWidth/2 && 
      x - radius < player.position.x + player.playerWidth/2 && 
      y + radius > player.position.y - player.playerHeight/2 &&
      y - radius < player.position.y + player.playerHeight/2)
    {
      player.isDead = true;
    }

    for (int i = 0; i < 2; i++)
    {
      Box box = boxManager.boxes[int(boxesToCheck[i].x)][int(boxesToCheck[i].y)];
      if (box.collides)
      {
        if (x + radius > box.position.x - box.size/2 && 
          x - radius < box.position.x + box.size/2 && 
          y + radius > box.position.y - box.size/2 &&
          y - radius < box.position.y + box.size/2)
        {
          vx *= -1f;
        }
      }
    }
  }

  void Update() 
  {
    CheckCollision();

    top = y - radius; 
    bottom = y + radius;
    left = x - radius;
    right = x + radius;
    x = x + vx * 3f;
  }

  void Draw() 
  {
    fill(255, 100, 100);
    ellipse(x, y, radius * 2, radius * 2);
  }
}