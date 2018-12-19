class BossLaserState extends State
{
  float animationSpeed;
  float currentFrame;

  float lockOnTime = 2.5f;
  float lockOnProgress;

  boolean lockedOnPlayer;

  PVector laserEndPos;
  PVector intersection;

  color laserColor = color(175, 175, 175);

  //colision
  boolean hit;
  float intersectionX, intersectionY;

  void OnStateEnter()
  {
    animationSpeed = 0.05f;
    currentFrame = 0f;

    lockOnProgress = 0f;
    lockedOnPlayer = false;

    laserEndPos = player.position.copy();
  }

  void OnTick()
  {
    currentFrame = (currentFrame + animationSpeed) % 2;

    //shoot laser
    if (!lockedOnPlayer)
    {
      lockOnPlayer();
    } 
    else 
    {
      shootLaser();
      checkCollision();
    }

    //if player is within attack range
    //SetState(new BossAttackState());
  }

  void lockOnPlayer()
  {
    //handle timer for locking on the player
    lockOnProgress += deltaTime;
    if ( lockOnProgress >= lockOnTime)
    {
      laserColor = color(255, 0, 0);
      lockedOnPlayer = true;
    }

    //update laser position
    laserEndPos.x = lerp(laserEndPos.x, player.position.x, 5f * deltaTime);
    laserEndPos.y = lerp(laserEndPos.y, player.position.y, 5f * deltaTime);
  }

  void shootLaser()
  {
    laserEndPos.x = lerp(laserEndPos.x, player.position.x, 4f * deltaTime);
    laserEndPos.y = lerp(laserEndPos.y, player.position.y, 4f * deltaTime);
  }

  void checkCollision()
  {
    float distance = MAX_FLOAT;
    boolean laserHit;
    hit = false;
    //loop through all blocks
    for(int i = 0; i < boxManager.rows; i++)
    {
      for(int j = 0; j < boxManager.columns; j++)
      {
        if(boxManager.boxes[i][j].collides == 1)
        {
          //check if the laser hits a block
          laserHit = lineRect(laserEndPos.x, laserEndPos.y, boss.position.x, boss.position.y, 
                boxManager.boxes[i][j].position.x-20f, boxManager.boxes[i][j].position.y-20f, 40f, 40f);
          if(laserHit)
          {
            //the laser has hit atleast one block
            hit = true;
            //check if the block that is hit is closer than the previously hit block(s)
            if(boss.position.dist(new PVector(intersectionX, intersectionY)) < distance)
            {
              //save the new closest intersection point
              intersection = new PVector(intersectionX, intersectionY);
              //save the new closest distance
              distance = boss.position.dist(intersection);
            }
          }
        }
      }
    }
  }

  // LINE/RECTANGLE
  boolean lineRect(float x1, float y1, float x2, float y2, float rx, float ry, float rw, float rh) 
  {
    // check if the line has hit any of the rectangle's sides
    // uses the Line/Line function below
    boolean top =    lineLine(x1,y1,x2,y2, rx,ry, rx+rw,ry);
    if(top)return true;
    boolean left =   lineLine(x1,y1,x2,y2, rx,ry,rx, ry+rh);
    if(left)return true;
    boolean right =  lineLine(x1,y1,x2,y2, rx+rw,ry, rx+rw,ry+rh);
    if(right)return true;

    return false;
  }

  // LINE/LINE
  boolean lineLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) 
  {
    // calculate the direction of the lines
    float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

    // if uA and uB are between 0-1, lines are colliding
    if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) 
    {
      // optionally, draw a circle where the lines meet
      intersectionX = x1 + (uA * (x2-x1));
      intersectionY = y1 + (uA * (y2-y1));

      return true;
    }
    return false;
  }

  void OnDraw()
  {
    //draw movement animation
    pushMatrix();
    translate(boss.position.x/* - camera.shiftX*/, boss.position.y/* - camera.shiftY*/);
    ellipse(0, 0, boss.bossSize, boss.bossSize);
    if (boss.currentDirection == boss.RIGHT)
    {
      //image(boss.run[int(currentFrame)], 0, 0);
    } else if (boss.currentDirection == boss.LEFT)
    {
      pushMatrix();
      scale(-1.0, 1.0);
      //image(boss.run[int(currentFrame)], 0, 0);
      popMatrix();
    }
    popMatrix();
    
    strokeWeight(10);
    stroke(laserColor);
    //draw Laser
    if(hit)
    {
      line(boss.position.x, boss.position.y, intersection.x, intersection.y);
    }
    else
    {
      line(boss.position.x, boss.position.y, laserEndPos.x, laserEndPos.y);
    }
  }

  void OnStateExit()
  {
  }
}
