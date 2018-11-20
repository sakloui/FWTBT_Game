class Enemy {
  float x, y;
  float radius;
  float vx;
  float top, bottom, left, right;
  float boxSize = 40f;
  PVector[] boxesToCheck = new PVector[2];

  int enemyType;
  int bulletTimer = 40;

  Enemy(float spawnX, float spawnY, int type) 
  {
    radius = 20;
    x = spawnX;
    y = spawnY;
    vx = 1;
    boxesToCheck[0] = new PVector(0,0);
    boxesToCheck[1] = new PVector(0,0);   
    enemyType = type;
  }


  void CheckKillCollision()
  {
    if (x + radius > player.position.x - player.playerWidth/2 && 
      x - radius < player.position.x + player.playerWidth/2 && 
      y + radius > player.position.y - player.playerHeight/2 &&
      y - radius < player.position.y + player.playerHeight/2)
    {
      enemies.remove(this);
      boxManager = new BoxManager(currentLevel);
      gameManager.currencyValues[3]++;
    }    
  }
  void Update() 
  {
    CheckCollision();
    if(enemyType == 0)
      CheckFire();

    top = y - radius; 
    bottom = y + radius;
    left = x - radius;
    right = x + radius;
    x = x + vx * 3f;
    CheckKillCollision();
  }

  void Draw() 
  {
    fill(255, 100, 100);
    ellipse(x - camera.shiftX, y - camera.shiftY, radius * 2, radius * 2);
  }

  void CheckFire()
  {
    if(bulletTimer == 0)
    {
      if(vx == 1 && x - player.position.x < 0)
      {
        bullet.add(new Bullets(new PVector(x,y),RIGHT));
      }
      if(vx == -1 && x - player.position.x > 0)
      {
        bullet.add(new Bullets(new PVector(x,y),LEFT));
      }
      bulletTimer = 40;
    }
    else bulletTimer--;
  }

  void CheckCollision()
  {
    for (int i = 0; i < 2; i++)
    {
      if(boxManager.boxes != null)
      {
        Box box = boxManager.boxes[int(boxesToCheck[i].x)][int(boxesToCheck[i].y)];
        if(box != null)
          if (x + radius > (box.position.x - box.size/2) && 
            x - radius < (box.position.x + box.size/2) && 
            y + radius > (box.position.y - box.size/2) &&
            y - radius < (box.position.y + box.size/2))
          {
            if (box.collides == 1 ||
                box.collides == 5 ||
                box.collides == 15 ||
                box.collides == 16 ||
                box.collides == 17 ||
                box.collides == 18 ||
                box.collides == 22)
            {          
              vx *= -1f;      
            }
          }
      }
    }
  }
}

