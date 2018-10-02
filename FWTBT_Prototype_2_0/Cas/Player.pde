class Player
{
  //----------body----------
  float size;
  color playerColor;

  //----------Movement----------
  PVector position;
  PVector velocity;
  PVector acceleration;
  float accelRate;
  float decelRate;
  float maxSpeed;
  float gravity;
  float jumpVel;
  float maxGrav;
  float speed;

  //----------collisions----------
  float top, bottom, right, left;
  float oldTop, oldBottom, oldRight, oldLeft;
  boolean collidedTop, collidedBottom, collidedRight, collidedLeft;

  //----------Other----------
  color textColor = color(0);

  Player()
  {
    size = 40f;
    playerColor = color(155, 0, 0);

    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    position = new PVector(width/2, height/2);
    accelRate = 4f;
    decelRate = 4f;
    maxSpeed = 4f;
    gravity = 9.81f;
    maxGrav = 5f;
    jumpVel = 50f;
    speed = 125f;
  }

  void SetOldPos()
  {
    oldTop = top;
    oldBottom = bottom;
    oldRight = right;
    oldLeft = left;
  }

  void GetCollisionDirection(Box box)
  {
    if (oldBottom < box.top && // was not colliding
      bottom >= box.top)// now is colliding
    {
      collidedBottom = true;
      ResolveCollision();
    }
    if (oldTop >= box.bottom && // was not colliding
      top < box.bottom)// now is colliding
    {
      collidedTop = true;
      ResolveCollision();
    }
    if (oldLeft >= box.right && // was not colliding
      left < box.right)// now is colliding
    {
      collidedLeft = true;
      ResolveCollision();
    }
    if (oldRight < box.left && // was not colliding
      right >= box.left) // now is colliding
    {
      collidedRight = true;
      ResolveCollision();
    }
  }

  void ResolveCollision()
  {
    if (collidedTop)
    {
      println("top");
      PVector correction = new PVector(0, velocity.y);
      position.sub(correction);
    }
    if (collidedBottom)
    {
      println("bottom");
      PVector correction = new PVector(0, velocity.y);
      position.sub(correction);
    }
    if (collidedRight)
    {
      //corr = box.position - player.position;
      //corr2 = box.size/2 + player.size/2 - corr;
      //player.position -= corrr2;
      println("right");
      PVector correction = new PVector(velocity.x, 0);
      position.sub(correction);
    }
    if (collidedLeft)
    {
      println("left");
      PVector correction = new PVector(velocity.x, 0);
      position.sub(correction);
    }
  }

  void UpdateAABB()
  {
    top = position.y - size/2;
    bottom = top + size;
    right = position.x + size/2;
    left = right - size;
  }

  void Update()
  {
    //saves the position before moving the player
    //ResolveCollision();
    SetOldPos();
    Move();
    //HandleJump();
    //ApplyGravity();
    //position.add(velocity);
    //updates the new player position
    UpdateAABB();
    //reset colliding booleans
    //collidedTop = collidedBottom = collidedRight = collidedLeft = false;
  }

  /*
  void Move()
  {    
    if (input.isRight)
    {
      acceleration.x = accelRate;
      if(velocity.x + acceleration.x > maxSpeed)
        velocity.x = maxSpeed;
      else
        velocity.add(acceleration.mult(deltaTime));
    } 
    else if (input.isLeft)
    {
      acceleration.x = accelRate;
      if(velocity.x - acceleration.x < -maxSpeed)
        velocity.x = -maxSpeed;
      else
        velocity.sub(acceleration.mult(deltaTime));
    }
    else
    {
      if (velocity.x > accelRate * deltaTime)
      {
        acceleration.x = decelRate;
        velocity.sub(acceleration.mult(deltaTime));
      } 
      else if (velocity.x < -accelRate * deltaTime)
      {
        acceleration.x = decelRate;
        velocity.add(acceleration.mult(deltaTime));
      } 
      else
      {
        acceleration.x = 0;
        velocity.x = 0;
      }
    }
  }
  */

  void Move()
  {
    if (input.isRight)
    {
      if(collidedRight)
        velocity.x = 0;
      else
      {
        if(collidedLeft)
          collidedLeft = false;
        velocity.x = speed * deltaTime;
      }
        
    } 
     if (input.isLeft)
    {
      if(collidedLeft)
        velocity.x = 0;
      else
      {
        if(collidedRight)
          collidedRight = false;
        velocity.x = -speed * deltaTime;
      }
    } 
    if(!input.isRight && !input.isLeft)
    {
      velocity.x = 0;
    }
    
    if (input.isUp)
    {
      if(collidedTop)
        velocity.y = 0;
      else
      {
        if(collidedBottom)
          collidedBottom = false;
        velocity.y = -speed * deltaTime;
      }
    } 
     if (input.isDown)
    {
      if(collidedBottom)
        velocity.y = 0;
      else
      {
        if(collidedTop)
          collidedTop = false;
        velocity.y = speed * deltaTime;
      }
    } 
    if(!input.isUp && !input.isDown)
    {
      velocity.y = 0;
    }
    
    position.add(velocity);
  }

  void HandleJump()
  {
    if (input.isUp && IsGrounded())
    {
      //acceleration.y = -accelRate;
      velocity.y -= 250;
      println("jump");
    }
  }

  boolean IsGrounded()
  {
    if (position.y >= height - size * 1.5f)
    {
      return true;
    } 
    else
      return false;
  }

  void ApplyGravity()
  {
    if (!IsGrounded())
    {
      if(velocity.y < maxSpeed/2)
        velocity.y += gravity * deltaTime;
    }
    else
    {
      velocity.y = 0;
    }
  }

  void Draw()
  {
    pushMatrix();
    fill(textColor);
    textSize(24);
    text("Grounded: " + IsGrounded(), 15, 35);
    text("velocity.y: " + velocity.y, 15, 85);
    text("position.y: " + position.y, 15, 135);
    popMatrix();

    pushMatrix();
    fill(playerColor);
    noStroke();
    translate(position.x, position.y);
    rect(0, 0, size, size);
    popMatrix();
  }
}
