Player player;
BoxManager boxManager;
Input input = new Input();
PowerUpManager powerUpManager;
Enemy enemy;
GameManager gameManager;
Magnet magnet;
final int LEFT = 0, RIGHT = 1, UP = 2, DOWN = 3;

ArrayList<Anchor> anchors = new ArrayList<Anchor>();

State currentState;

float lastTime;
float deltaTime;

float counter = 0;
float loadingTime = 2.5f;

void setup()
{
  size(1280, 720);
  rectMode(CENTER);
  imageMode(CENTER);
  frameRate(60);

  //SetState(new MenuState());

  player= new Player();
  enemy = new Enemy(width/2, height-60);
  boxManager = new BoxManager();
  gameManager = new GameManager();
  magnet = new Magnet(LEFT);

  powerUpManager = new PowerUpManager();

  anchors.add(new Anchor(new PVector(width/2, height-75)));
}

void draw()
{
  //----------Time----------
  deltaTime = (millis() - lastTime) / 1000;
  lastTime = millis();

  //----------Updates----------
  counter += deltaTime;
  if (counter >= loadingTime)
  {
    player.Update();
    boxManager.Update();
    powerUpManager.Update();  
    //enemy.Update();
    gameManager.Update();
    magnet.Update();

    //----------Draws----------
    background(200, 200, 200);
    boxManager.DrawBoxes();
    player.Draw();
    //enemy.Draw();
    gameManager.Draw();
    magnet.Draw();
    
    for (int i = 0; i < anchors.size(); i++)
    {
      anchors.get(i).Draw();
    }
    
    powerUpManager.Draw();
  } 
  else
  {
    //draw loading text
    pushMatrix();
    textSize(48);
    text("Loading...", width/2 - 100, height/2);
    popMatrix();
  }
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
