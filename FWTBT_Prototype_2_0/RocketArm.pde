class RocketArm
{
  color rocketArmColor = color(213, 123, 50);
  int size = 10;
  PVector position;
  PVector oldPos;
  PVector normPos;
  PVector anchorPos;
  ArrayList<PVector> savedPositions = new ArrayList<PVector>();
  int fuelCost = 10;
  boolean grapple = false;
  boolean returnGrapple = false;
  PVector targetPos = new PVector(0, 0);
  int grappleDistance = 600;
  float offset = 4.9f;
  boolean pullPlayer = false;
  float speed = 15f;
  boolean facingRight = false;

  boolean pickedUp = false;

  RocketArm(PVector pos)
  {
    position = pos.copy();
  }

  void Update()
  {
    if(!pickedUp)
      CheckCollision();
    if(!savedPositions.isEmpty())
    if (grapple)
    {
      ShootGrapple();
    }
    if(pullPlayer)
    {
      PullPlayer();
    }
    if (returnGrapple)
    {
      ReturnGrapple();
    }
  }
  
  void Move()
  {
    position.x += player.velocity.x * deltaTime;
    position.y = player.position.y +10;
    oldPos.x = player.position.x;
    oldPos.y = player.position.y +10;
    
    for(int i = 0; i < savedPositions.size(); i++)
    {
      savedPositions.get(i).x += player.velocity.x * deltaTime;
      savedPositions.get(i).y = player.position.y +10;
    }
  }

  void ShootGrapple()
  {
    Move();
    //targetPos = anchors.get(0).position.copy().sub(position);
    if (!facingRight)
    {
      //if facing left
      targetPos = new PVector(-1, 0);
    } else if (facingRight)
    {
      //else if facing right
      targetPos = new PVector(1, 0);
    }

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
                  grapple = false;
                  returnGrapple = true;
                  targetPos.x *= -1;
                  return;
              }
          }
          }
      }   
    for(int i = 0; i < anchors.size(); i++)
    {
      if(anchors.get(i) != null)
      {
        if (position.dist(anchors.get(i).position.copy()) <= 20f)
        {
          pullPlayer = true;
          grapple = false;
          anchorPos = anchors.get(i).position.copy();
          return;
        } 
      }
    }
      
        if (Math.abs(position.x - oldPos.x) > grappleDistance)
        {
          grapple = false;
          returnGrapple = true;
          //flip grapple move direction
          targetPos.x *= -1;
          return;
        } 
        else
        {
          position.x += targetPos.x * speed;

          if (Math.abs(position.x - savedPositions.get(savedPositions.size()-1).x) >= offset)
          {
            savedPositions.add(new PVector(position.x, position.y));
          }
        }
      
  }

  void PullPlayer()
  {
    if (!savedPositions.isEmpty())
    {
    if (Math.abs(player.position.x - savedPositions.get(0).x) <= 10f)
      savedPositions.remove(0);
    }    

    //move the player towards the anchor    
    //for(int i = 0; i < anchors.size(); i++)
    {
      
      if(savedPositions.isEmpty())
      {
          savedPositions.removeAll(savedPositions);
          pullPlayer = false;
          if(facingRight)
            player.position.x = anchorPos.copy().x - player.playerWidth/2;
          else
            player.position.x = anchorPos.copy().x + player.playerWidth/2;

          player.position.y = anchorPos.y - player.playerHeight/2;          
      }
    }
    normPos = new PVector(0.7,1);
    if(!facingRight && normPos.x > 0)
      normPos.x *= -1;
    player.position.x += normPos.x * speed;
  }

  void ReturnGrapple()
  {
    Move();
    if (!savedPositions.isEmpty())
    {
      savedPositions.remove(savedPositions.size()-1);
    }

    if (Math.abs(position.x - player.position.x) <= 10f)
    {
      savedPositions.removeAll(savedPositions);
      returnGrapple = false;
    }

    position.x += targetPos.x * speed;
  }

  void CheckCollision()
  {
    if (position.x + size/2 > player.position.x - player.playerWidth/2 && 
      position.x - size/2 < player.position.x + player.playerWidth/2 && 
      position.y + size/2 > player.position.y - player.playerHeight/2 &&
      position.y - size/2 < player.position.y + player.playerHeight/2)
    {
      pickedUp = true;
      powerUpManager.fuelCount += 20;
    }
  }

  void Draw()
  {
    fill(rocketArmColor);

    if (!pickedUp)
    {
      pushMatrix();
      translate(position.x - camera.shiftX, position.y - camera.shiftY);
      rect(0, 0, size, size);
      popMatrix();
    }

    if (grapple || returnGrapple || pullPlayer)
    {
      for (int i = 0; i < savedPositions.size(); i++)
      {
        image(hookMiddle,savedPositions.get(i).x - camera.shiftX, savedPositions.get(i).y - camera.shiftY, size*2, size);
      }
      fill(255, 0, 0);
      if (!facingRight)
        triangle(position.x - size - offset - camera.shiftX, position.y - camera.shiftY, position.x - offset - camera.shiftX, position.y - size/2 - camera.shiftY, position.x - offset - camera.shiftX, position.y + size/2 - camera.shiftY);
      else if (facingRight)
        triangle(position.x + size + offset - camera.shiftX, position.y - camera.shiftY, position.x + offset - camera.shiftX, position.y - size/2 - camera.shiftY, position.x + offset - camera.shiftX, position.y + size/2 - camera.shiftY);
    }
  }
}
