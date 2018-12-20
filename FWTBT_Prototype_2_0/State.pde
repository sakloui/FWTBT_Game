public abstract class State
{
	//direction the player is facing
	public int currentDirection;

	//called once when the new state is assigned
	public void OnStateEnter(){}

	//update method where all the calculations are done
	public abstract void OnTick();

	//draw method where everything is drawn
	public abstract void OnDraw();

	//exit method that gets called once when a state is switching to another state
	public void OnStateExit(){} 
}
