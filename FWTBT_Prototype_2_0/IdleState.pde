public class IdleState extends State
{
   PVector velocity;
  float animationSpeed;
  float currentFrame;
  //int currentDirection;
  final int LEFT = 0, RIGHT = 1;
  
  public void OnStateEnter()
  {
    
    animationSpeed = 0.05f;
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
     currentFrame = (currentFrame + animationSpeed) % 2;
    velocity = player.velocity.copy();
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
    
    pushMatrix();
    translate(player.position.x - camera.shiftX, player.position.y - camera.shiftY);
    if(currentDirection == RIGHT)
    {
      image(player.idle[int(currentFrame)], 0, 0);
    }
    else if(currentDirection == LEFT)
    {
      pushMatrix();
      scale(-1.0, 1.0);
      image(player.idle[int(currentFrame)],0 ,0);
      popMatrix();
    }
    popMatrix();
  }
   public void OnStateExit()
   {
     
   }
 }   
