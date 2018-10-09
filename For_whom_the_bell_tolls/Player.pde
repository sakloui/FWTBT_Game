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
  PVector[] corners = new PVector[6];
  //topLeft, topRight, bottomLeft, bottomRight;
  boolean collidedTop, collidedBottom, collidedRight, collidedLeft;

  //----------Other----------
  color textColor = color(0);
  boolean grounded = false;
  boolean canJump = false;
  int Health = 3;
  boolean isDead;
  Player()
  {
    playerWidth = 40;
    playerHeight = 60;
    playerColor = color(155, 0, 0);

    velocity = new PVector(0, 0);
    position = new PVector(width/2, height - 100);
    speed = 150f;
    
    jumpVel = 6f;
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
  
  void SetPlayerCorners()
  {
    corners[0] = new PVector(position.x - (playerWidth/2), position.y - (playerHeight/2));
    corners[1] = new PVector(position.x + (playerWidth/2), position.y - (playerHeight/2));
    corners[2] = new PVector(position.x - (playerWidth/2), position.y + (playerHeight/2));
    corners[3] = new PVector(position.x + (playerWidth/2), position.y + (playerHeight/2));
    corners[4] = new PVector(position.x + (playerWidth/2), player.position.y);
    corners[5] = new PVector(position.x - (playerWidth/2), player.position.y);
    
    /*
    topLeft = new PVector(position.x - (playerWidth/2), position.y - (playerHeight/2));
    topRight = new PVector(position.x + (playerWidth/2), position.y - (playerHeight/2));
    bottomLeft = new PVector(position.x - (playerWidth/2), position.y + (playerHeight/2));
    bottomRight = new PVector(position.x + (playerWidth/2), position.y + (playerHeight/2));
    */
  }
  
  void Move()
  {
    if (input.isRight)
    {
      velocity.x = speed * deltaTime;
    }    
    if (input.isLeft)
    {
      velocity.x = -speed * deltaTime;
    }
    
    if(!input.isRight && !input.isLeft)
    {
      velocity.x = 0;
    }
    
    /*
    if (input.isUp && grounded)
    {
      velocity.y -= jumpVel;
      grounded = false;
    }
    */

    
    if (input.isUp)
    {
      velocity.y = -speed * deltaTime;
    } 
    if (input.isDown)
    {
      velocity.y = speed * deltaTime;
    } 
    if(!input.isUp && !input.isDown)
    {
      velocity.y = 0;
    }
    
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
    SetPlayerCorners();
    Move();
    //ApplyGravity();
    position.add(velocity);
    SetNewPos();
    
    if(Health <= 0) {
      isDead = true;
    }
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
    else
      grounded = false;
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
    textSize(20);
    fill(textColor);
    translate(100, 100);
    text("grounded: " + grounded, 0, 0);
    popMatrix();
    
    pushMatrix();
    fill(playerColor);
    noStroke();
    translate(position.x, position.y);
    if(!isDead) {
      rect(0, 0, playerWidth, playerHeight);
    } 
  
    popMatrix();
  }
  
}
