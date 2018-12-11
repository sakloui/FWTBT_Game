public class RunState extends State
{
  PVector velocity;
  float animationSpeed;
  float currentFrame;
  final int LEFT = 0, RIGHT = 1;
  
  public void OnStateEnter()
  {
    //set the speed for the jump animation
    animationSpeed = 0.25f;

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
    velocity = player.velocity.copy();
    currentFrame = (currentFrame + animationSpeed) % 8;    
    
    //check if state switch is needed
    if(velocity.x == 0)
    {
      player.SetState(new IdleState());
    }
    if(velocity.y != 0)
    {
      player.SetState(new JumpState());
    }
    if(velocity.x > 0)
    {
      currentDirection = RIGHT;
    }
    else if(velocity.x < 0)
    {
      currentDirection = LEFT;
    }
  }
  
  public void OnDraw()
  {  
    pushMatrix();
    translate(player.position.x - camera.shiftX, player.position.y - camera.shiftY);
    //draw the currect sprite from the array, flip the sprite if it needs to face left
    if(currentDirection == RIGHT)
    {
      image(player.run[int(currentFrame)], 0, 0);
    }
    else if(currentDirection == LEFT)
    {
       pushMatrix();
       scale(-1.0, 1.0);
       image(player.run[int(currentFrame)],0 ,0);
       popMatrix();
    }
    popMatrix();
  }
  
  public void OnStateExit()
  {
    player.currentDirection = currentDirection;
  }
}
