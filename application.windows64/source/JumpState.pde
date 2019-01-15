public class JumpState extends State
{
  PVector velocity;
  float animationSpeed;
  float currentFrame;
  final int LEFT = 0, RIGHT = 1, UP = 2, DOWN = 3;
  
  public void OnStateEnter()
  {
    //set the speed for the jump animation
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
    currentFrame = (currentFrame + animationSpeed) % player.jump.length;
    velocity = player.velocity.copy();
    
    //check if state switch is needed
    if(velocity.x == 0 && velocity.y == 0)
    {
      player.SetState(new IdleState());
    }
    else if(velocity.y == 0 && velocity.x != 0)
    {
      player.SetState(new RunState());
    }

    //determine facing direction by the player velocity
    if(velocity.x > 0)
    {
      currentDirection = RIGHT;
    }
    else if(velocity.x < 0)
    {
      currentDirection = LEFT;
    }
    if(velocity.y < 0)
    {
      ///jump animation
      //currentDirection = UP;
    }
    else if(velocity.y > 0)
    {
      ///falling animation
      //currentDirection = DOWN;
    }
   }

  
  public void OnDraw()
  {
    pushMatrix();
    translate(player.position.x - camera.shiftX, player.position.y - camera.shiftY);
    //draw the currect sprite from the array, flip the sprite if it needs to face left
    if(currentDirection == RIGHT)
    {
      image(player.jump[int(currentFrame)], 0, 0);
    }
    else if(currentDirection == LEFT)
    {
      pushMatrix();
      scale(-1.0, 1.0);
      image(player.jump[int(currentFrame)],0 ,0);
      popMatrix();
    }
    popMatrix();
  }

  public void OnStateExit()
  {
    player.currentDirection = currentDirection;
  }
}
