class Player
{
  //----------body----------
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
  float lastVelY;

  //----------collisions----------
  float top, bottom, right, left;
  float oldTop, oldBottom, oldRight, oldLeft;
  PVector[] corners = new PVector[6];
  PVector playerBottom;
  //topLeft, topRight, bottomLeft, bottomRight;
  boolean collidedTop, collidedBottom, collidedRight, collidedLeft;

  //----------Other----------
  color textColor = color(0);
  boolean grounded = false;
  boolean canJump = false;

  PImage[] idle;
  PImage[] run;
  PImage[] slide;
  PImage[] jump;
  PImage[] fire;
  int currentDirection;
  float currentFrame;
  float currentRunFrame;
  float animationSpeed = 0.3f;

  PVector acceleration;
  PVector deceleration;
  float accelRate = 12f * 60;
  float decelRate = 20f * 60;
  float maxSpeed = 300f;
  float turnSpeed = 3f;
  boolean isDead = false;
  boolean isClimbing = false;
  boolean inAir = false;
  boolean jumpHold = false;

  boolean isFire;
  int fireTime = 50;
  int fireFrame = 0;

  float cameraShake = 0;
  boolean isShaking = false;

  boolean onMovingPlatform = false;
  boolean onOil = false;
  boolean oilCD = false;
  float oilCounter;
  float oilTimer = 3f;


  State playerState;

  Player()
  {
    playerWidth = 25;
    playerHeight = 55;
    playerColor = color(155, 0, 0);

    acceleration = new PVector(0, 0);
    acceleration.x = 650f;
    deceleration = new PVector(0, 0);
    deceleration.x = -750f;
    velocity = new PVector(0, 0);
    position = new PVector(width/2, height/2);

    jumpVel = 640f;
    gravity = 9.81f * 144;
    maxGrav = 650f;

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

    slide = new PImage[5];
    String slideName;

    jump = new PImage[5];
    String jumpName;

    run = new PImage[8];
    String runName;

    fire = new PImage[7];
    String fireName;

    for (int i = 0; i < idle.length; i++)
    {
      //load idle sprites
      idleName = "Sprites/Idle (" + i + ").png";
      idle[i] = loadImage(idleName);
    }
    for (int i = 0; i < jump.length; i++)
    {
      //load jump sprites
      jumpName = "Sprites/Jump (" + i + ").png";
      jump[i] = loadImage(jumpName);
      // //load slide sprites
      // slideName = "Sprites/Slide (" + i + ").png";
      // slide[i] = loadImage(slideName);
      // slide[i].resize(80, 0);
    }

    for (int i = 0; i < 8; i++)
    {
      //load run sprites
      runName = "Sprites/Run (" + i + ").png";
      run[i] = loadImage(runName);
    }
    for (int i = 0; i < 7; i++)
    {
      //load run sprites
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

    /*
    topLeft = new PVector(position.x - (playerWidth/2), position.y - (playerHeight/2));
     topRight = new PVector(position.x + (playerWidth/2), position.y - (playerHeight/2));
     bottomLeft = new PVector(position.x - (playerWidth/2), position.y + (playerHeight/2));
     bottomRight = new PVector(position.x + (playerWidth/2), position.y + (playerHeight/2));
     */
  }

  void Move()
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
        ///acceleration.x += 20f * maxSpeed;
        velocity.x += acceleration.x * deltaTime;
        if (velocity.x > maxSpeed)
          velocity.x = maxSpeed;
      } else if (velocity.x + deceleration.x < 0)
      {
        ///deceleration.x -= 20f * turnSpeed;
        velocity.x -= turnSpeed * deceleration.x * deltaTime;
      } else
        ///velocity is lower than 0 but not low enough to add deceleration.
      {
        velocity.x = 0;
      }
    } else if (input.isLeft)
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
        //acceleration.x += 20f * maxSpeed;
        velocity.x -= acceleration.x * deltaTime;
        if (velocity.x < -maxSpeed)
          velocity.x = -maxSpeed;
      } else if (velocity.x - deceleration.x > 0)
      {
        ///deceleration.x -= 20f * turnSpeed;
        velocity.x += turnSpeed * deceleration.x * deltaTime;
      } else
        ///velocity is higher than 0 but not high enough to add deceleration.
      {
        velocity.x = 0;
      }      
    } else
    {
      if (velocity.x + deceleration.x * deltaTime > 0)
      {
        //deceleration.x -= 20f;
        velocity.x += deceleration.x * deltaTime;
      } else if (velocity.x - deceleration.x * deltaTime < 0)
      {
        //deceleration.x -= 20f;
        velocity.x -= deceleration.x * deltaTime;
      } else 
      {
        velocity.x = 0;
      }
    }

    /*
    if (input.isRight)
     {
     acceleration.x = accelRate;
     if (velocity.x > maxSpeed)
     velocity.x = maxSpeed;
     else
     velocity.add(acceleration.mult(deltaTime));
     } else if (input.isLeft)
     {
     acceleration.x = accelRate;
     if (velocity.x < -maxSpeed)
     velocity.x = -maxSpeed;
     else
     {
     velocity.sub(acceleration.mult(deltaTime));
     }
     } 
     else
     {
     if (velocity.x > decelRate * turnSpeed && input.isLeft)
     {
     decelRate *= turnSpeed;
     } 
     if (velocity.x > decelRate * deltaTime)
     {
     acceleration.x = decelRate;
     velocity.sub(acceleration.mult(deltaTime));
     decelRate /= turnSpeed;
     }
     else if (velocity.x < decelRate * turnSpeed && input.isRight)
     {
     decelRate *= turnSpeed;
     }
     if (velocity.x < -decelRate * deltaTime)
     {
     if (input.isRight)
     {
     decelRate *= turnSpeed;
     }
     acceleration.x = decelRate;
     velocity.add(acceleration.mult(deltaTime));
     decelRate /= turnSpeed;
     } 
     else
     {
     acceleration.x = 0;
     velocity.x = 0;
     }
     }
     */

    /*
    //standard left right
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
     */

    /*
    //standard up-down
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

    //jump
    if (input.isSpace && grounded)
    {
      if(!oilCD)
        velocity.y = -jumpVel;  
      else
      {
        velocity.y = -jumpVel/1.5;
        velocity.x = (velocity.x /4 * 3.5);  
      }


      grounded = false;
      inAir = true;
      int rand = ceil(random(1,6));
      for(int i = 0; i < rand; i++)
      {
        particle.add(new Particles(new PVector(position.x,position.y+playerHeight/2-1),random(-4,4), random(3,4),0.1, color(150,75,0,100)));
      }        
      onMovingPlatform = false;
      jumpsound.rewind();
      jumpsound.play();      
    }

    if(input.isSpace)
      jumpHold=true;
    else
      jumpHold = false;

    if(!grounded && velocity.y<-150 && !jumpHold && !powerUpManager.rocketJumpActive)
    {
      velocity.y/=1.1;
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
    } else
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

      if(!grounded)
        lastVelY = velocity.y;

      if(inAir && grounded){
        isShaking = true;
        cameraShake = 3*(lastVelY/maxGrav);      
        inAir = false;
        int rand = ceil(random(1,4));
        for(int i = 0; i < rand; i++)
        {
          particle.add(new Particles(new PVector(position.x,position.y+playerHeight/2-1),random(-4,4), random(2,4),0.1, color(255,255,0,100)));
        }
      }   

    SetOldPos();
    SetPlayerCorners();
    if(!isClimbing)
    {
      if (powerUpManager.rocketArm == null ||!powerUpManager.rocketArm.pullPlayer/* && !powerUpManager.rocketArm.returnGrapple*/)
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
      if (powerUpManager.rocketArm == null ||!powerUpManager.rocketArm.pullPlayer && !powerUpManager.rocketArm.returnGrapple)
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
    if(isShaking)
    {
      if (cameraShake > -0.1 && cameraShake < 0.1)
      {
        isShaking = false;
        cameraShake = 0;
      }
      camera.shiftY += cameraShake;
      cameraShake *= -0.9;
    }
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



    if(boxManager.bottomBox != null && boxManager.boxBottomRight != null && boxManager.boxBottomLeft != null)
    {
      if (boxManager.bottomBox.collides != 1 ||
          boxManager.bottomBox.collides != 5 ||
          boxManager.bottomBox.collides != 15 ||
          boxManager.bottomBox.collides != 16 ||
          boxManager.bottomBox.collides != 17 ||
          boxManager.bottomBox.collides != 18 ||
          boxManager.bottomBox.collides != 12 ||
          boxManager.bottomBox.collides != 10 ||
          boxManager.bottomBox.collides != 14)
      {    
        grounded = false;
      }
    }   
    
  }

   void GetCollisionDirection(Rectangle box)
  { 
    //check which side of the player collided
    //set that corresponding boolean to true and call ResolveCollision

    if (box.getCollides() == 0)
    {
      grounded = false;
      return;
    } 
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
      {
      //only collide with moving platform when moving downward        
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
      //draw the idle/run/jump animations      
      pushMatrix();
      fill(playerColor);
      noStroke();
      playerState.OnDraw();
      translate(position.x, position.y);
      //rect(0, 0, playerWidth, playerHeight);
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
