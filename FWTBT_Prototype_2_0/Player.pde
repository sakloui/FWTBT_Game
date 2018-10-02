class Player
{
 //----------body----------
  float playerWidth;
  float playerHeight;
  color playerColor;

  //----------Movement----------
  PVector position;
  PVector velocity;
  float speed;
  float jumpVel;
  float gravity;
  float maxGrav;

  //----------collisions----------
  float top, bottom, right, left;
  float oldTop, oldBottom, oldRight, oldLeft;
  boolean collidedTop, collidedBottom, collidedRight, collidedLeft;

  //----------Other----------
  color textColor = color(0);
  boolean grounded = false;
  boolean canJump = false;

  Player()
  {
    playerWidth = 40;
    playerHeight = 60;
    playerColor = color(155, 0, 0);

    velocity = new PVector(0, 0);
    position = new PVector(width/2, height - 100);
    speed = 150f;
    
    jumpVel = 500f;
    gravity = 9.81f;
    maxGrav = 20f;
    
    //set values once for the first time SetOldPos() is called
    SetNewPos();
  }
  
  void SetOldPos()
  {
    oldTop = top;
    oldBottom = bottom;
    oldRight = right;
    oldLeft = left;
  }
  
  void Move()
  {
    if (isRight)
    {
      velocity.x = speed * deltaTime;
    }    
    if (isLeft)
    {
      velocity.x = -speed * deltaTime;
    }
    
    if(!isRight && !isLeft)
    {
      velocity.x = 0;
    }
    
    if (isUp && grounded)
    {
      velocity.y -= jumpVel * deltaTime;
      grounded = false;
    } 

    
    /*
    if (isUp)
    {
      velocity.y = -speed * deltaTime;
    } 
    if (isDown)
    {
      velocity.y = speed * deltaTime;
    } 
    if(!isUp && !isDown)
    {
      velocity.y = 0;
    }
    */
  }
  
  void ApplyGravity()
  {
    if(!grounded)
    {
      velocity.y += gravity * deltaTime;
      if(velocity.y > maxGrav)
        velocity.y = maxGrav * deltaTime;
    }
  }
  
  void SetNewPos()
  {
    top = position.y - playerHeight/2;
    bottom = top + playerHeight;
    right = position.x + playerWidth/2;
    left = right - playerWidth;
  }
  
  void Update()
  {
    SetOldPos();
    Move();
    ApplyGravity();
    position.add(velocity);
    println(velocity.y);
    SetNewPos();
  }
  
  void GetCollisionDirection(Box box)
  {
    if (oldBottom < box.top && // was not colliding
      bottom >= box.top)// now is colliding
    {
      collidedBottom = true;
      ResolveCollision(box);
    }
    if (oldTop >= box.bottom && // was not colliding
      top < box.bottom)// now is colliding
    {
      collidedTop = true;
      ResolveCollision(box);
    }
    if (oldLeft >= box.right && // was not colliding
      left < box.right)// now is colliding
    {
      collidedLeft = true;
      ResolveCollision(box);
    }
    if (oldRight < box.left && // was not colliding
      right >= box.left) // now is colliding
    {
      collidedRight = true;
      ResolveCollision(box);
    }
  }
  
  void ResolveCollision(Box box)
  {
    if (collidedTop)
    {
      println("top");
      position.y = box.position.y + box.size/2 + playerHeight/2 + 0.1f;
      velocity.y = 0;
      collidedTop = false;
    }
    if (collidedBottom)
    {
      println("bottom");
      position.y = box.position.y - box.size/2 - playerHeight/2 - 0.1f;
      velocity.y = 0;
      grounded = true;
      collidedBottom = false;
    }
    if (collidedRight)
    {
      //corr = box.position - player.position;
      //corr2 = box.size/2 + player.size/2 - corr;
      //player.position -= corrr2;
      println("right");
      position.x = box.position.x - box.size/2 - playerWidth/2 - 0.1f;
      velocity.x = 0;
      collidedRight = false;
    }
    if (collidedLeft)
    {
      println("left");
      position.x = box.position.x + box.size/2 + playerWidth/2 + 0.1f;
      velocity.x = 0;
      collidedLeft = false;
    }
    
    SetNewPos();
  }
  
  void Draw()
  {
    pushMatrix();
    textSize(28);
    fill(textColor);
    translate(100, 100);
    text("CanJump: " + canJump, 0, 0);
    popMatrix();
    
    pushMatrix();
    fill(playerColor);
    noStroke();
    translate(position.x, position.y);
    rect(0, 0, playerWidth, playerHeight);
    popMatrix();
  }
    
}
