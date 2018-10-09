public class RunState extends State
{
   PVector velocity;
  float animationSpeed;
  float currentFrame;
  int currentDirection;
  final int LEFT = 0, RIGHT = 1;
  
  public void OnStateEnter()
  {
    
    animationSpeed = 0.4f;
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
    println("Run state");
    velocity = player.velocity.copy();
    currentFrame = (currentFrame + animationSpeed) % 8;    
    
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
    translate(player.position.x, player.position.y);
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
