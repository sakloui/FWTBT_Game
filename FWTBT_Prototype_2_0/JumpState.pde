public class JumpState extends State
{
 PVector velocity;
  float animationSpeed;
  float currentFrame;
  //int currentDirection;
  final int LEFT = 0, RIGHT = 1, UP = 2, DOWN = 3;
  
  public void OnStateEnter()
  {
    
    animationSpeed = 0.1f;
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
    currentFrame = (currentFrame + animationSpeed) % 10;
    velocity = player.velocity.copy();
    
    if(velocity.x == 0 && velocity.y == 0)
    {
      player.SetState(new IdleState());
    }
    else if(velocity.y == 0 && velocity.x != 0)
    {
      player.SetState(new RunState());
    }
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
      //currentDirection = UP;
    }
    else if(velocity.y > 0)
    {
      //currentDirection = DOWN;
    }
   }
   public void OnDraw()
  {
    
    pushMatrix();
    translate(player.position.x - camera.shiftX, player.position.y - camera.shiftY);
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
