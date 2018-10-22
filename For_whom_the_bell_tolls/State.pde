public abstract class State
{
  public int currentDirection;
  
  public void OnStateEnter(){}
  
  public abstract void OnTick();
  
  public abstract void OnDraw();
  
  public void OnStateExit(){}
  
}
