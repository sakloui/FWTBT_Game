public class IdleState extends State
{
  PVector velocity;
  float animationSpeed;
  float currentFrame;

  boolean startedGrapple = false;
  final int LEFT = 0, RIGHT = 1;
  
  public void OnStateEnter()
  {
    //set the speed for the idle animation
    animationSpeed = 0.05f;

    //get the direction the player is facing to draw the sprite in the correct direction
    if(player == null)
    {
      currentDirection = 1;
    }
    else
    {
      currentDirection = player.currentDirection;
    }
  }
  
  public void OnTick()
  {
    //currentFrame is the sprite that's selected from the array of sprites
    //currentFrame is incremented untill it reaches the length of the array, then it restarts
    currentFrame = (currentFrame + animationSpeed) % 2;
    velocity = player.velocity.copy();
    
    //check if state switch is needed
    //if the velocity is 0, exit the method and don't read the other two checks
    if(velocity.x == 0 && velocity.y == 0) return;
    
    if(velocity.y != 0)
    {
      player.SetState(new JumpState());
    }
    else if(velocity.x != 0)
    {
      player.SetState(new RunState());
    }
  }

  public void OnDraw()
  {
    debug.log("Grounded: ", player.grounded);
    pushMatrix();
    translate(player.position.x - camera.shiftX, player.position.y - camera.shiftY);
    //draw the currect sprite from the array, flip the sprite if it needs to face left
    
    if(powerUpManager.rocketArm.grapple && !startedGrapple)
    {
      startedGrapple = true; 
      currentFrame = 0; 
    }
    else if(powerUpManager.rocketArm.grapple)
    {
      if(currentFrame >= 1)
          currentFrame = 1;
      if(powerUpManager.rocketArm.pullPlayer)
        currentFrame = 2;

      if(player.grounded)
      {
        if(currentDirection == RIGHT)
        {
          //println("1");
          image(grappleGrounded[int(currentFrame)], 0, 0);
        }
        else if(currentDirection == LEFT)
        {
          //println("2");
          pushMatrix();
          scale(-1.0, 1.0);
          image(grappleGrounded[int(currentFrame)], 0, 0);
          popMatrix();
        }
      }
      else 
      {
        if(currentDirection == RIGHT)
        {
          //println("3");
          image(grappleMidAir[int(currentFrame)], 0, 0);
        }
        else if(currentDirection == LEFT)
        {
          //println("4");
          pushMatrix();
          scale(-1.0, 1.0);
          image(grappleMidAir[int(currentFrame)], 0, 0);
          popMatrix();
        }
      }
    }
    else
    {
      if(currentDirection == RIGHT)
      {
        //println("5");
        image(player.idle[int(currentFrame)], 0, 0);
      }
      else if(currentDirection == LEFT)
      {
        //println("6");
        pushMatrix();
        scale(-1.0, 1.0);
        image(player.idle[int(currentFrame)],0 ,0);
        popMatrix();
      }
    }
    popMatrix();
  }

  public void OnStateExit()
  { 

  }
 }   
