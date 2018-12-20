class Boss
{
  PVector position;
  PVector spawnPosition;

  float aggroRange;
  float attackRange;
  float bossSize;

  //animation
  PImage bossSprite;
  PImage[] idle;
  PImage[] run;
  //PImage[] attack;

  int currentDirection;
  float currentFrame;
  float animationSpeed = 0.3f;

  boolean movingRight = false;

  final int LEFT = 0, RIGHT = 1;

  State currentState;

  Boss(PVector pos)
  {
    //set position
    spawnPosition = pos.copy();
    position = spawnPosition.copy();
    //set aggro- and attack range
    //set facing direction
    bossSize = 120f;
    setupSprites();
    this.SetState(new BossLaserState(this));
  }

  void setupSprites()
  {
    bossSprite = new PImage();
    String bossSpriteName;

    //load the sprites
    idle = new PImage[2];
    String idleName;

    run = new PImage[8];
    String runName;

    //attack = new PImage[5];
    //String attackName;

    bossSpriteName = "Sprites/BossBegin.png";
    bossSprite = loadImage(bossSpriteName);

    //load idle sprites
    for (int i = 0; i < idle.length; i++)
    {
      idleName = "Sprites/Idle (" + i + ").png";
      idle[i] = loadImage(idleName);
    }

    /*
      //load attack sprites
     for (int i = 0; i < attack.length; i++)
     {
     attackName = "Sprites/Attack (" + i + ").png";
     attack[i] = loadImage(attackName);
     }
     */

    //load run sprites
    for (int i = 0; i < 8; i++)
    {
      runName = "Sprites/Run (" + i + ").png";
      run[i] = loadImage(runName);
    }
  }

  void bossUpdate()
  {
    //set the direction the boss is facing
    if (position.x - player.position.x < 0)
      currentDirection = 1;
    else
      currentDirection = 0;
    this.currentState.OnTick();
  }

  void bossDraw()
  {
    this.currentState.OnDraw();
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
}
