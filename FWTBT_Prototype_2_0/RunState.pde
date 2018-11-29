public class RunState extends State
{
  PVector velocity;
  float animationSpeed;
  float modAnimSpeed;
  float currentFrame;
  //int currentDirection;
  final int LEFT = 0, RIGHT = 1;
  
  public void OnStateEnter()
  {
    animationSpeed = 0.25f;
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
    velocity = player.velocity.copy();
    if(abs(velocity.x) < 150)
      modAnimSpeed = animationSpeed / 1.2f;
    else
    {
      modAnimSpeed = animationSpeed * (abs(velocity.x) / 200);    
    }

    currentFrame = (currentFrame + modAnimSpeed) % 8;    
    
    if(velocity.x == 0)
    {
      player.SetState(new IdleState());
    }
    if(velocity.y != 0)
    {
      player.SetState(new JumpState());
    }
    if(input.isRight/*velocity.x > 0*/)
    {
      currentDirection = RIGHT;
    }
    else if(input.isLeft/*velocity.x < 0*/)
    {
      currentDirection = LEFT;
    }
  }
  
  public void OnDraw()
  {
    
    pushMatrix();
    translate(player.position.x - camera.shiftX, player.position.y - camera.shiftY);
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
