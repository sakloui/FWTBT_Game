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
  PImage[] charge;
  PImage[] blueCharge;
  PImage[] chargeImpact;
  PImage[] laserCharge;
  PImage[] laserFire;

  float health;
  float maxHealth;
  float healthOffset;

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
    maxHealth = 120f;
    health = maxHealth;
    setupSprites();
    this.SetState(new BossIdleState(this));
  }

  void setupSprites()
  {
    bossSprite = new PImage();
    String bossSpriteName;

    //load the sprites
    idle = new PImage[6];
    String idleName;

    charge = new PImage[4];
    String chargeName;

    blueCharge = new PImage[6];
    String blueChargeName;

    chargeImpact = new PImage[8];
    String chargeImpactName;

    laserCharge = new PImage[8];
    String laserChargeName;

    laserFire = new PImage[3];
    String laserFireName;

    bossSpriteName = "Sprites/BossBegin.png";
    bossSprite = loadImage(bossSpriteName);

    //load idle sprites
    for (int i = 0; i < idle.length; i++)
    {
      idleName = "Sprites/BossIdle"+(i+1)+".png";
      idle[i] = loadImage(idleName);
    }

    //load charge sprites
    for (int i = 0; i < charge.length; i++)
    {
      chargeName = "Sprites/BossCharge"+(i+1)+".png";
      charge[i] = loadImage(chargeName);
    }

    //load charge sprites
    for (int i = 0; i < blueCharge.length; i++)
    {
      blueChargeName = "Sprites/BossChargeBlue"+(i+1)+".png";
      blueCharge[i] = loadImage(blueChargeName);
    }

    //load chargeImpact sprites
    for (int i = 0; i < chargeImpact.length; i++)
    {
      chargeImpactName = "Sprites/FireImpact"+(i+1)+".png";
      chargeImpact[i] = loadImage(chargeImpactName);
    }

    //load laserCharge sprites
    for (int i = 0; i < laserCharge.length; i++)
    {
      laserChargeName = "Sprites/BossLaserCharge"+(i+1)+".png";
      laserCharge[i] = loadImage(laserChargeName);
    }

    //load laserFire sprites
    for (int i = 0; i < laserFire.length; i++)
    {
      laserFireName = "Sprites/BossLaserFire"+(i+1)+".png";
      laserFire[i] = loadImage(laserFireName);
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

    checkPlayerCollision();

    healthOffset = -(maxHealth - health) / 2;
  }

  void bossDraw()
  {
    this.currentState.OnDraw();

    drawHealth();
  }

  void takeDamage(float damage)
  {
    health -= damage;
    if(health < 0)
    {
      health = 0;
      death();
    }
  }

  void checkPlayerCollision()
  {
    if((boss.position.x-player.position.x) * (boss.position.x-player.position.x) + 
      (player.position.y-boss.position.y) * (player.position.y-boss.position.y)
      <= (60+30) * (60+30))
    {
      menu.currentSel = 0;
      menu.createDied();
      menu.menuState = 0;
      isMenu = true;
    }
  }

  void death()
  {

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
