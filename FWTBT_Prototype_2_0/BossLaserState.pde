class BossLaserState extends State
{
  //superclass reference
  Boss boss;

  //animation
  float animationSpeed;
  float currentFrame;

  //lock on
  float lockOnTime = 2.5f;
  float lockOnProgress;
  boolean lockedOnPlayer;

  //laser
  PVector laserPlayerTrackPos;
  PVector laserEndPos;
  float laserFollowSpeed;
  color laserColor = color(175, 175, 175);

  //colision
  float intersectionX, intersectionY;
  float laserHitDistance;
  PVector closestIntersection;
  boolean laserHit;

  BossLaserState(Boss currentBoss)
  {
    this.boss = currentBoss;
  }

  void OnStateEnter()
  {
    animationSpeed = 0.05f;
    currentFrame = 0f;

    lockOnProgress = 0f;
    lockedOnPlayer = false;

    closestIntersection = new PVector(0, 0);

    laserPlayerTrackPos = player.position.copy();

    laserEndPos = laserPlayerTrackPos.copy().sub(boss.position.copy());
    laserEndPos.normalize();
    laserEndPos.setMag(1200);
    laserEndPos.add(boss.position.copy());
  }

  void OnTick()
  {
    currentFrame = (currentFrame + animationSpeed) % 2;

    //shoot laser
    if (!lockedOnPlayer)
    {
      lockOnPlayer();
      checkLaserCollision();
    } 
    else 
    {
      updateLaserPosition(5f);
      checkLaserCollision();
    }

    //after laser attack return to idle state
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

    updateLaserPosition(4f);
  }

  void updateLaserPosition(float laserSpeed)
  {
    laserFollowSpeed = laserSpeed;
    laserPlayerTrackPos.x = lerp(laserPlayerTrackPos.x, player.position.x, laserFollowSpeed * deltaTime);
    laserPlayerTrackPos.y = lerp(laserPlayerTrackPos.y, player.position.y, laserFollowSpeed * deltaTime);

    laserEndPos = laserPlayerTrackPos.copy().sub(boss.position.copy());
    laserEndPos.normalize();
    laserEndPos.setMag(1200);
    laserEndPos.add(boss.position.copy());
  }

  void checkLaserCollision()
  {
    laserHitDistance = MAX_FLOAT;
    checkBoxCollision();
  }

  void checkBoxCollision()
  {
    for(int i = 0; i < boxManager.rows; i++)
    {
      for(int j = 0; j < boxManager.columns; j++)
      {
        if(boxManager.boxes[i][j].collides == 1)
        {
          //check if the laser hits a block that collides
          laserHit = lineRect(laserEndPos.x, laserEndPos.y, boss.position.x, boss.position.y, 
                boxManager.boxes[i][j].position.x-20f, boxManager.boxes[i][j].position.y-20f, 40f, 40f);
          
          if(laserHit)
            saveClosestIntersection();
        }
      }
    }
  }

  void saveClosestIntersection()
  {
    //check if the block that is hit is closer than the previously hit block(s)
    if(boss.position.dist(new PVector(intersectionX, intersectionY)) < laserHitDistance)
    {
      //save the new closest intersection point
      closestIntersection = new PVector(intersectionX, intersectionY);
      //save the new closest laserHitDistance
      laserHitDistance = boss.position.dist(closestIntersection);
    }
  }

  // LINE/RECTANGLE
  boolean lineRect(float x1, float y1, float x2, float y2, float rx, float ry, float rw, float rh) 
  {
    //when checking collision with a new box reset the intersection 
    //variables to a very high number
    intersectionX = MAX_FLOAT;
    intersectionY = MAX_FLOAT;

    // check if the line has hit any of the rectangle's sides
    // uses the Line/Line function below
    boolean top =    lineLine(x1,y1,x2,y2, rx,ry, rx+rw,ry);
    boolean left =   lineLine(x1,y1,x2,y2, rx,ry,rx, ry+rh);
    boolean right =  lineLine(x1,y1,x2,y2, rx+rw,ry, rx+rw,ry+rh);

    if(top || left || right)
      return true;

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
      //if the intersection with the current side of the rect is closer to the laser origin
      //than the previously saved intersection, store these coordinates as the new closest intersection
      if(x1 + (uA * (x2-x1)) < intersectionX && y1 + (uA * (y2-y1)) < intersectionY)
      {
        intersectionX = x1 + (uA * (x2-x1));
        intersectionY = y1 + (uA * (y2-y1));  
      }

      return true;
    }
    return false;
  }

  void OnDraw()
  {
    //draw movement animation
    pushMatrix();
    translate(boss.position.x/* - camera.shiftX*/, boss.position.y/* - camera.shiftY*/);
    //ellipse(0, 0, boss.bossSize, boss.bossSize);
    image(boss.bossSprite, 0, 0);
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
    line(boss.position.x, boss.position.y, closestIntersection.x, closestIntersection.y);
  }

  void OnStateExit()
  {
  }
}
