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
  int grappleDistance = 240;
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
    for(int i = 0; i < anchors.size(); i++)
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
    normPos = position.copy().normalize();
    if(!facingRight && normPos.x > 0)
      normPos.x *= -1;
    player.position.x += normPos.x * speed;
  }

  void ReturnGrapple()
  {
    Move();
    if (!savedPositions.isEmpty())
    {
      if (Math.abs(position.x - savedPositions.get(savedPositions.size()-1).x) <= 5f)
        savedPositions.remove(savedPositions.size()-1);
    }

    if (Math.abs(position.x - oldPos.x) <= 3f)
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

    if (grapple || returnGrapple)
    {
      for (int i = 0; i < savedPositions.size(); i++)
      {
        rect(savedPositions.get(i).x - camera.shiftX, savedPositions.get(i).y - camera.shiftY, size*2, size);
      }
      fill(255, 0, 0);
      if (!facingRight)
        triangle(position.x - size - offset - camera.shiftX, position.y - camera.shiftY, position.x - offset - camera.shiftX, position.y - size/2 - camera.shiftY, position.x - offset - camera.shiftX, position.y + size/2 - camera.shiftY);
      else if (facingRight)
        triangle(position.x + size + offset - camera.shiftX, position.y - camera.shiftY, position.x + offset - camera.shiftX, position.y - size/2 - camera.shiftY, position.x + offset - camera.shiftX, position.y + size/2 - camera.shiftY);
    }
  }
}
