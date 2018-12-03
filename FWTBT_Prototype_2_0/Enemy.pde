class Enemy {
  float x, y;
  float radius;
  float vx;
  float top, bottom, left, right;
  float boxSize = 40f;
  PVector[] boxesToCheck = new PVector[2];

  int enemyType;
  int bulletTimer = 40;
  int cycle = 0;
  int timer = 0;

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
    if(enemyType == 1)
      CheckFire();

    top = y - radius; 
    bottom = y + radius;
    left = x - radius;
    right = x + radius;
    if(enemyType != 3 && enemyType != 4)
    {
      x = x + vx * 3f;
    }
    CheckKillCollision();
  }

  void Draw() 
  {
    fill(255, 100, 100);
    if(cycle == 3)
      cycle = 0;

    pushMatrix();
    translate(x - camera.shiftX, y - camera.shiftY);
    scale(vx, 1.0);
    if(enemyType != 5 && enemyType != 6)
      image(basicEnemy[cycle],0,0);
    else if(enemyType == 5)
    {
      image(electricOrb[cycle], 0, 0);  
    }
    else if (enemyType == 6) 
    {
      image(electricOrbPurple[cycle], 0, 0)
    }
    
    popMatrix();
    if(timer == 5)
    {
      cycle++;
      timer = 0;
    }
    timer++;
  }

  void CheckFire()
  {
    if(bulletTimer == 0)
    {
      if(vx == 1 && x - player.position.x < 0)
      {
        bullet.add(new Bullets(new PVector(x,y),RIGHT,atan2(player.position.y - y,player.position.x - x)));
      }
      if(vx == -1 && x - player.position.x > 0)
      {
        bullet.add(new Bullets(new PVector(x,y),LEFT,atan2(player.position.y - y,player.position.x - x)));
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

