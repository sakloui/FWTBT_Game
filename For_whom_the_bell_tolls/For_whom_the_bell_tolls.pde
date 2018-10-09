Player player;
BoxManager boxManager;
Input input = new Input();

State currentState;

float lastTime;
float deltaTime;

void setup()
{
  size(1280, 720);
  rectMode(CENTER);
  imageMode(CENTER);
  frameRate(100);

  //SetState(new MenuState());
  player= new Player();
  boxManager = new BoxManager();
}

void draw()
{
  //----------Time----------
  deltaTime = (millis() - lastTime) / 1000;
  lastTime = millis();

  //----------Updates----------
  player.Update();
  boxManager.Update();

  //----------Draws----------
  background(200, 200, 200);
  boxManager.DrawBoxes();
  player.Draw(); 
}

void SetState(State state)
{
  if (currentState != null)
  {
    currentState.OnStateExit();
  }

  currentState = state;

  if (currentState != null)
  {
    currentState.OnStateEnter();
  }
}

void keyPressed()
{
  input.KeyDown(keyCode, true);
}

void keyReleased()
{
  input.KeyDown(keyCode, false);
}
