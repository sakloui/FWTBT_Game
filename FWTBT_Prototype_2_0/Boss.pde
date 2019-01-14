class Boss
{
  PVector position;
  PVector spawnPosition;

  float aggroRange;
  float attackRange;
  float bossSize;

  float health;
  float maxHealth;
  float healthOffset;

  int currentDirection;
  float currentImage;
  float animationSpeed = 0.25f;

  boolean movingRight = false;
  boolean hasDied = false;
  boolean deleted;

  PVector explosionPosition = new PVector(0, 0);
  float bossTimeDeath;
  float bossDeathDuration = 3f;

  float positionChangeCounter;
  float positionChangeTimer = 0.25f;

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
    maxHealth = 1f;
    health = maxHealth;
    this.SetState(new BossIdleState(this));
  }

  void bossUpdate()
  {
    if(deleted)
      return;

    if(hasDied)
      death();
    else 
    {
      //set the direction the boss is facing
      if (position.x - player.position.x < 0)
        currentDirection = 1;
      else
        currentDirection = 0;

      this.currentState.OnTick();

      checkPlayerCollision();

      healthOffset = -(maxHealth - health) / 2;  
    }
  }

  void bossDraw()
  {
    if(deleted)
      return;

    this.currentState.OnDraw();

    if(health != 0)
      drawHealth();
    else {
      drawDeath();
    }
  }

  void takeDamage(float damage)
  {
    health -= damage;
    if(health < 0)
    {
      health = 0;
      hasDied = true;
      explosionPosition = new PVector(boss.position.x - random(-75, 75), boss.position.y - random(-75, 75));
    }
  }

  void checkPlayerCollision()
  {
    if((boss.position.x-player.position.x) * (boss.position.x-player.position.x) + 
      (player.position.y-boss.position.y) * (player.position.y-boss.position.y)
      <= (60+30) * (60+30))
    {
      /*
      menu.currentSel = 0;
      menu.createDied();
      menu.menuState = 0;
      isMenu = true;
      */
    }
  }

  void death()
  {
    currentImage = (currentImage + animationSpeed) % death.length;

    bossTimeDeath += deltaTime;
    positionChangeCounter += deltaTime;
    if(positionChangeCounter >= positionChangeTimer)
    {
      explosionPosition = new PVector(boss.position.x - random(-75, 75), boss.position.y - random(-25, 75));
      positionChangeCounter = 0f;
    }
    if(bossTimeDeath >= bossDeathDuration)
    {
      deleted = true;
      boxManager.boxes[2][16].collides = 4;
    }
  }

  void drawHealth()
  {
    pushMatrix();
    translate(boss.position.x, boss.position.y - 100);
    noStroke();
    fill(255, 0, 0);
    rect(0, 0, bossSize, 30);
    fill(0, 255, 0);
    rect(healthOffset, 0, health, 30);
    popMatrix();
  }

  void drawDeath()
  {
    image(death[int(currentImage)], explosionPosition.x, explosionPosition.y);
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
