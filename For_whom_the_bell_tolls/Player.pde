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

  PImage sheet;
  PImage[] idle;
  PImage[] run;
  PImage[] slide;
  PImage[] jump;
  boolean inMotion;
  int currentDirection;
  float currentFrame;
  float currentRunFrame;
  float animationSpeed = 0.3f;

  State playerState;

  final int UP = 0, LEFT = 1, DOWN = 2, RIGHT = 3;

  Player()
  {
    playerWidth = 40;
    playerHeight = 60;
    playerColor = color(155, 0, 0);

    velocity = new PVector(0, 0);
    position = new PVector(width/2, height - 100);
    speed = 150f;

    jumpVel = 7f;
    gravity = 9.81f;
    maxGrav = 20f;

    SetupSprites();

    //set values once for the first time SetOldPos() is called
    SetNewPos();
  }

  void SetupSprites()
  {
    idle = new PImage[10];
    String idleName;

    slide = new PImage[10];
    String slideName;

    jump = new PImage[10];
    String jumpName;

    run = new PImage[8];
    String runName;

    for (int i = 0; i < 10; i++)
    {
      //load idle sprites
      idleName = "Sprites/Idle (" + i + ").png";
      idle[i] = loadImage(idleName);
      idle[i].resize(80, 0);

      //load jump sprites
      jumpName = "Sprites/Jump (" + i + ").png";
      jump[i] = loadImage(jumpName);
      jump[i].resize(80, 0);
      //load slide sprites
      slideName = "Sprites/Slide (" + i + ").png";
      slide[i] = loadImage(slideName);
      slide[i].resize(80, 0);
    }

    for (int i = 0; i < 8; i++)
    {
      //load run sprites
      runName = "Sprites/Run (" + i + ").png";
      run[i] = loadImage(runName);
      run[i].resize(80, 0);
    }
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

    if (!input.isRight && !input.isLeft)
    {
      velocity.x = 0;
    }

    
    if (input.isUp && grounded)
    {
      velocity.y = -jumpVel;
      grounded = false;
    }
    

    /*
    if (input.isUp)
    {
      velocity.y = -speed * deltaTime;
    } 
    if (input.isDown)
    {
      velocity.y = speed * deltaTime;
    } 
    if (!input.isUp && !input.isDown)
    {
      velocity.y = 0;
    }
    */
  }

  void ApplyGravity()
  {
    if (!grounded)
    {
      velocity.y += gravity * deltaTime;
      if (velocity.y > maxGrav)
        velocity.y = maxGrav;
    }
    else
      velocity.y = 0;
  }

  void SetNewPos()
  {
    top = position.y - playerHeight/2;
    bottom = top + playerHeight;
    right = position.x + playerWidth/2;
    left = right - playerWidth;
  }
  
  void SetDirection()
  {
    currentFrame = (currentFrame + animationSpeed) % 10;
    currentRunFrame = (currentRunFrame + animationSpeed) % 8;
    inMotion = true;

    if (velocity.x == 0 && velocity.y == 0)
      inMotion = false;
    else if (velocity.y < 0)
      currentDirection = UP;
    else if (velocity.y > 0)
      currentDirection = DOWN;
    else if (velocity.x > 0 && velocity.y == 0)
      currentDirection = RIGHT;
    else if (velocity.x < 0 && velocity.y == 0)
      currentDirection = LEFT;
  }

  void Update()
  {
    SetOldPos();
    SetPlayerCorners();
    Move();
    ApplyGravity();
    SetDirection();
    position.add(velocity);
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
      position.y = box.position.y + box.size/2 + playerHeight/2 + 0.1f;
      velocity.y = 0;
      collidedTop = false;
    }
    if (collidedBottom)
    {
      position.y = box.position.y - box.size/2 - playerHeight/2 - 0.1f;
      velocity.y = 0;
      grounded = true;
      collidedBottom = false;
    } else
      grounded = false;
    if (collidedRight)
    {
      position.x = box.position.x - box.size/2 - playerWidth/2 - 0.1f;
      velocity.x = 0;
      collidedRight = false;
    }
    if (collidedLeft)
    {
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
    text("Velocity.y: " + velocity.y, 0, 0);
    popMatrix();

    pushMatrix();
    fill(playerColor);
    noStroke();
    translate(position.x, position.y);
    if(velocity.x == 0 && velocity.y == 0)
      image(idle[int(currentFrame)], 0, 0);
    else if(currentDirection == UP)
    {
      image(jump[int(currentFrame)], 0, 0);
    }
    else if(currentDirection == DOWN)
    {
      image(jump[int(currentFrame)], 0, 0);
    }
    else if(currentDirection == RIGHT)
    {
      image(run[int(currentRunFrame)], 0, 0);
    }
    else if(currentDirection == LEFT)
    {
       pushMatrix();
       scale(-1.0, 1.0);
       image(run[int(currentRunFrame)],0 ,0);
       popMatrix();
       //image(run[int(currentRunFrame)], 0, 0);
    }
      
    //rect(0, 0, playerWidth, playerHeight);
    popMatrix();
  }

  void SetState(State state)
  {
    if (playerState != null)
    {
      playerState.OnStateExit();
    }

    playerState = state;

    if (playerState != null)
    {
      playerState.OnStateEnter();
    }
  }
}
