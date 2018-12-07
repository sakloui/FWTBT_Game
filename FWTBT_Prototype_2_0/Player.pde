class Player
{
  //----------Body----------
  float playerWidth;
  float playerHeight;
  color playerColor;

  //----------Movement----------
  PVector position;
  PVector velocity;
  float speed = 200f;
  float climbSpeed = 250f;
  float jumpVel;
  float gravity;
  float maxGrav;

  PVector acceleration;
  PVector deceleration;
  float accelRate = 12f * 60;
  float decelRate = 20f * 60;
  float maxSpeed = 300f;
  float turnSpeed = 3f;

  boolean grounded = false;
  boolean canJump = false;

  //----------Collisions----------
  float top, bottom, right, left;
  float oldTop, oldBottom, oldRight, oldLeft;
  PVector[] corners = new PVector[6];
  PVector playerBottom;
  boolean collidedTop, collidedBottom, collidedRight, collidedLeft;

  //----------Animations----------
  PImage[] idle;
  PImage[] run;
  PImage[] slide;
  PImage[] jump;
  PImage[] fire;
  int currentDirection;
  float currentFrame;
  float currentRunFrame;
  float animationSpeed = 0.3f;

  //----------Player state checks----------
  boolean isClimbing = false;
  boolean isFire;
  boolean onMovingPlatform = false;
  boolean onOil = false;
  boolean oilCD = false;
  boolean isDead = false;

  //----------Other----------
  color textColor = color(0);
  
  float oilCounter;
  float oilTimer = 3f;

  int fireTime = 50;
  int fireFrame = 0;

  State playerState;

  Player()
  {
    playerWidth = 39;
    playerHeight = 60;
    playerColor = color(155, 0, 0);

    acceleration = new PVector(0, 0);
    acceleration.x = 650f;
    deceleration = new PVector(0, 0);
    deceleration.x = -750f;
    velocity = new PVector(0, 0);
    position = new PVector(width/2, height/2);

    jumpVel = 465f;
    gravity = 9.81f * 65;
    maxGrav = 350;

    currentDirection = 1;
    onOil = false;    

    SetupSprites();

    //set values once before SetOldPos() is called
    SetNewPos();

    this.SetState(new IdleState());
  }

  void SetupSprites()
  {
    //load all sprites from data folder
    idle = new PImage[2];
    String idleName;

    jump = new PImage[5];
    String jumpName;

    run = new PImage[8];
    String runName;

    fire = new PImage[7];
    String fireName;

    for (int i = 0; i < idle.length; i++)
    {
      idleName = "Sprites/Idle (" + i + ").png";
      idle[i] = loadImage(idleName);
    }

    for (int i = 0; i < jump.length; i++)
    {
      jumpName = "Sprites/Jump (" + i + ").png";
      jump[i] = loadImage(jumpName);
    }

    for (int i = 0; i < run.length; i++)
    {
      runName = "Sprites/Run (" + i + ").png";
      run[i] = loadImage(runName);
    }

    for (int i = 0; i < fire.length; i++)
    {
      fireName = "Sprites/RobotSpriteFlame" + i + ".png";
      fire[i] = loadImage(fireName);
    }    
  }

  void SetOldPos()
  {
    //save the old player position before moving the player
    oldTop = top;
    oldBottom = bottom;
    oldRight = right;
    oldLeft = left;
  }

  void SetPlayerCorners()
  {
    //save the corners of the player sprite to calculate the surrounding tiles
    corners[0] = new PVector(position.x - (playerWidth/2), position.y - (playerHeight/2));
    corners[1] = new PVector(position.x + (playerWidth/2), position.y - (playerHeight/2));
    corners[2] = new PVector(position.x - (playerWidth/2), position.y + (playerHeight/2));
    corners[3] = new PVector(position.x + (playerWidth/2), position.y + (playerHeight/2));
    corners[4] = new PVector(position.x + (playerWidth/2), player.position.y);
    corners[5] = new PVector(position.x - (playerWidth/2), player.position.y);

    //same the bottom for groundCheck
    playerBottom = new PVector(position.x, position.y + playerHeight/2);
  }

  void Move()
  {
    handleOilMovement();
    
    //accel movement
    if (input.isRight)
    {
      if ( walkingsound.position() == walkingsound.length() && grounded)
      {
        walkingsound.rewind();
        walkingsound.play();
      }
      else if(grounded)
      {
        walkingsound.play();
      }         
      if (velocity.x >= 0)
      {
        //increase velocity untill maxSpeed is reached
        velocity.x += acceleration.x * deltaTime;
        if (velocity.x > maxSpeed)
          velocity.x = maxSpeed;
      }
      else if (velocity.x + deceleration.x < 0)
      //if right key pressed but player is moving to the left
      {
        //change direction with extra speed (turnSpeed)
        velocity.x -= turnSpeed * deceleration.x * deltaTime;
      } 
      else
      //velocity is lower than 0 but not low enough to add deceleration.
      {
        velocity.x = 0;
      }
    } 
    else if (input.isLeft)
    {
      if ( walkingsound.position() == walkingsound.length() && grounded)
      {
        walkingsound.rewind();
        walkingsound.play();
      }
      else if(grounded)
      {
        walkingsound.play();
      }         
      if (velocity.x <= 0)
      {
        //increase velocity untill maxSpeed is reached
        velocity.x -= acceleration.x * deltaTime;
        if (velocity.x < -maxSpeed)
          velocity.x = -maxSpeed;
      } 
      else if (velocity.x - deceleration.x > 0)
      //if left key pressed but player is moving to the right
      {
        //change direction with extra speed (turnSpeed)
        velocity.x += turnSpeed * deceleration.x * deltaTime;
      } 
      else
      //velocity is higher than 0 but not high enough to add deceleration.
      {
        velocity.x = 0;
      }      
    }
    else
    //if no key is pressed
    {
      if (velocity.x + deceleration.x * deltaTime > 0)
      {
        //if player is moving to the right, decelerate player
        velocity.x += deceleration.x * deltaTime;
      }
      else if (velocity.x - deceleration.x * deltaTime < 0)
      {
        //if player is moving to the left, decelerate player
        velocity.x -= deceleration.x * deltaTime;
      } 
      else 
      {
        velocity.x = 0;
      }
    }

    //jump
    if (input.isUp && grounded)
    {
      if(!oilCD)
        velocity.y = -jumpVel;  
      else
      {
        velocity.y = -jumpVel/1.5;
        velocity.x = (velocity.x /4 * 3.5);  
      }
      grounded = false;
      onMovingPlatform = false;
      jumpsound.rewind();
      jumpsound.play();      
    }
  }

  void handleOilMovement()
  {
    if(onOil)
    {
      oilCD = true;
      oilCounter = 0f;
      acceleration.x = 75f;
      deceleration.x = -125f;
    }
    else
    {
      if(oilCD)
      {
        //if not on oil, but still oil under feet (cooldown not yet passed)
        acceleration.x = 125;
        deceleration.x = -200f;

        //reduce cooldown
        oilCounter += deltaTime;
        if(oilCounter >= oilTimer)
        {
          oilCD = false;
          oilCounter = 0f;  
        }
      }
      else
      {
        //no oil under feet, reset acceleration to normal
        acceleration.x = 650f;
        deceleration.x = -750f;  
      }
    }
  }

  void Climb()
  {
    //linear movement
    velocity.x = 0;
    velocity.y = 0;
    if (input.isRight)
    {       
      position.x += speed * deltaTime;
      velocity.x = 100f;
    } else if (input.isLeft)
    {
      position.x -= speed * deltaTime;
      velocity.x = -100f;  
    }

    if (input.isUp)
    {
      position.y -= climbSpeed * deltaTime;
      velocity.y = -200f;       
    }
    else if (input.isDown)
    {
      position.y += climbSpeed * deltaTime;       
    }
  }  

  void ApplyGravity()
  {
    if (!grounded)
    {
      //apply gravity
      velocity.y += gravity * deltaTime;

      //don't let player fall faster than maxGravity
      if (velocity.y > maxGrav)
        velocity.y = maxGrav;
    } 
    else
      velocity.y = 0;
  }

  void SetNewPos()
  {
    //save position after moving the player
    top = position.y - playerHeight/2;
    bottom = top + playerHeight;
    right = position.x + playerWidth/2;
    left = right - playerWidth;
  }

  void fireRocket()
  {   
    if(isFire)
    {
      if(fireTime == 0 || (velocity.y >= -0.5 && velocity.y <= 0.5))
      {
        isFire = false;
        fireTime = 50;
        fireFrame = 0;
      }
      else fireTime--;       
      if(fireFrame >= fire.length)
        fireFrame = 0;
      image(fire[fireFrame],position.x - camera.shiftX, position.y + playerHeight/2 - camera.shiftY,30,30);
      fireFrame++;
    }
  }

  void Update()
  {
    SetOldPos();
    SetPlayerCorners();
    if(!isClimbing)
    {
      if (powerUpManager.rocketArm == null || !powerUpManager.rocketArm.pullPlayer/* && !powerUpManager.rocketArm.returnGrapple*/)
      {
         Move();
      }
      else
      {
        velocity.x = 0f;
        velocity.y = 0f;
      }    
    }
    else
    {
      if (powerUpManager.rocketArm == null || !powerUpManager.rocketArm.pullPlayer && !powerUpManager.rocketArm.returnGrapple)
      {
         Climb();
      }
      else
      {
        velocity.x = 0f;
        velocity.y = 0f;
      }          
    }
    
    //update player idle, run or jump state
    playerState.OnTick();

    if(!isClimbing)
    {
      if (powerUpManager.rocketArm == null || !powerUpManager.rocketArm.pullPlayer/* && !powerUpManager.rocketArm.returnGrapple*/)
        ApplyGravity();
    
      //SetDirection();
      position.x += velocity.x * deltaTime;
      position.y += velocity.y * deltaTime;
    }

    SetNewPos();  
    if (velocity.x != 0 && (bottom != oldBottom || right != oldRight))
    //if the player moved
    {
      if(boxManager.bottomBox != null)
      {
        //check for boxes under the player
        ResolveCollision(boxManager.bottomBox, "Box");
      }
    }
   
  }

  void GetCollisionDirection(Rectangle box)
  {
    //check which side of the player collided
    //set that corresponding boolean to true and call ResolveCollision

    if (box.getCollides() == 0) return;
    if (oldBottom < box.getTop() && // was not colliding
      bottom >= box.getTop())// now is colliding
    {
      collidedBottom = true;
      //ResolveCollision(box);
    }
    if (oldTop >= box.getBottom() && // was not colliding
      top < box.getBottom())// now is colliding
    {
      collidedTop = true;
      //ResolveCollision(box);
    }
    if (oldLeft >= box.getRight() && // was not colliding
      left < box.getRight())// now is colliding
    {
      collidedLeft = true;

      //ResolveCollision(box);
    }   
    if (oldRight < box.getLeft() && // was not colliding
      right >= box.getLeft()) // now is colliding
    {
      collidedRight = true;
      //ResolveCollision(box);
    }


    if(box.getName() == "Box")
    {
      ResolveCollision(box, "Box");
    }
    else if(box.getName() == "MovingPlatform")
    {
      ResolveCollision(box, "MovingPlatform");
    }
  }

  void ResolveCollision(Rectangle box, String object)
  {
    if(object == "MovingPlatform")
    {
      if(velocity.y > 0)
      //only collide with moving platform when moving downward
      {
        if (collidedBottom)
        {
          position.y = box.getY() - box.getHeight()/2 - playerHeight/2 - 0.1f;
          velocity.y = 0;
          grounded = true;
          onMovingPlatform = true;
          collidedBottom = false;
        }
      }
      else
      {
        return;
      }
    }
    else
    {
      if (collidedTop)
      {
        //move the player under the box
        position.y = box.getY() + box.getHeight()/2 + playerHeight/2 + 0.1f;
        velocity.y = 0;
        collidedTop = false;
      }
      if (collidedBottom)
      {
        //move the player on top of the box
        position.y = box.getY() - box.getHeight()/2 - playerHeight/2 - 0.1f;
        velocity.y = 0;
        grounded = true;
        collidedBottom = false;
      } 
      else
      {
        //if not collidedBottom, player is in the air
        grounded = false;
      }
      if (collidedRight)
      {
        //move the player left of the box
        position.x = box.getX() - box.getWidth()/2 - playerWidth/2 - 0.1f;
        velocity.x = 0;
        collidedRight = false;

      }
      if (collidedLeft)
      {
        //move the player right of the box
        position.x = box.getX() + box.getWidth()/2 + playerWidth/2 + 0.1f;
        velocity.x = 0;
        collidedLeft = false;
      }
    }
    //save new position after changing the player position to outside the colliding box
    SetNewPos();
  }

  void Draw()
  {
    if (!isDead)
    {
      pushMatrix();
      fill(playerColor);
      noStroke();
      //draw the idle/run/jump animations
      playerState.OnDraw();
      translate(position.x, position.y);
      popMatrix();
      fireRocket();      
    }
  }

  void DebugText()
  {
    pushMatrix();
    textSize(20);
    fill(textColor);
    translate(100, 105);
    text("Velocity.x: " + velocity.x, 0, 0);
    text("Velocity.y: " + velocity.y, 0, 40);
    text("Acceleration.x: " + acceleration.x, 0, 80);
    text("Acceleration.y * deltaTime: " + (acceleration.y * deltaTime), 0, 120);
    text("Gravity: " + gravity, 0, 160);
    text("Turning: : " + maxSpeed, 0, 200);
    text("fps: " + frameRate, 0, 240);
    text("Pos.x: " + position.x, 0, 520);
    text("Pos y: " + position.y, 0, 560);
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
