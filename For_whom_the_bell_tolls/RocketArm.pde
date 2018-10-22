class RocketArm
{
  color rocketArmColor = color(213, 123, 50);
  int size = 10;
  PVector position;
  PVector oldPos;
  ArrayList<PVector> savedPositions = new ArrayList<PVector>();
  int fuelCost = 10;
  boolean grapple = false;
  boolean returnGrapple = false;
  PVector targetPos = new PVector(0, 0);
  int grappleDistance = 250;
  float offset = 4.9f;

  float speed = 5f;

  boolean pickedUp = false;

  RocketArm(PVector pos)
  {
    position = pos.copy();
  }

  void Update()
  {
    CheckCollision();
    if (grapple)
    {
      ShootGrapple();
    }
    if (returnGrapple)
    {
      ReturnGrapple();
    }
  }

  void ShootGrapple()
  {
    //targetPos = anchors.get(0).position.copy().sub(position);
    if (player.playerState.currentDirection == 0)
    {
      //if facing left
      targetPos = new PVector(-1, 0);
    } else if (player.playerState.currentDirection == 1)
    {
      //else if facing right
      targetPos = new PVector(1, 0);
    }

    if (position.dist(anchors.get(0).position.copy()) <= 10f)
    {
      //move the player towards the anchor
      if (!savedPositions.isEmpty())
      {
        if (Math.abs(player.position.x - savedPositions.get(0).x) <= 10f)
          savedPositions.remove(0);
      }
      if (Math.abs(player.position.x - anchors.get(0).position.x) <= 3f)
      {
        grapple = false;
        return;
      }
      
      player.position.x += targetPos.x * speed;
    } 
    else if (Math.abs(position.x - oldPos.x) > grappleDistance)
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

  void ReturnGrapple()
  {
    if (!savedPositions.isEmpty())
    {
      if (Math.abs(position.x - savedPositions.get(savedPositions.size()-1).x) <= 5f)
        savedPositions.remove(savedPositions.size()-1);
    }
    
    if(Math.abs(position.x - oldPos.x) <= 3f)
    {
      if(!savedPositions.isEmpty())
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
      translate(position.x, position.y);
      rect(0, 0, size, size);
      popMatrix();
    }

    if (grapple || returnGrapple)
    {
      for (int i = 0; i < savedPositions.size(); i++)
      {
        rect(savedPositions.get(i).x, savedPositions.get(i).y, size, size);
      }
      fill(255, 0, 0);
      if(player.playerState.currentDirection == 0)
        triangle(position.x - size - offset, position.y, position.x - offset, position.y - size/2, position.x - offset, position.y + size/2);
      else if(player.playerState.currentDirection == 1)
        triangle(position.x + size + offset, position.y, position.x + offset, position.y - size/2, position.x + offset, position.y + size/2);
    }
  }
}
