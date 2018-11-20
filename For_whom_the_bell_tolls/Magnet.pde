class Magnet
{
  PVector position;
  color magnetColor = color(50, 50, 50);
  int magnetHeight = 40;
  int magnetWidth = 40;
  float dotProduct;
  int direction;
  PVector lookDirection;
  PVector offset;
  float attraction;
  float xDiff;
  float yDiff;
  PVector diff;
  float attractionPower = 50f;
  boolean isAttracting;
  boolean wasAttracting;
  boolean slowingDownPlayer;
  float slowingDownSpeed = 20f;
  
  Magnet(PVector spawnPos, int direction)
  {
    position = spawnPos.copy();
    this.direction = direction;
    switch(direction)
    {
      case LEFT:
        lookDirection = new PVector(-1, 0);
        break;
     case RIGHT:
        lookDirection = new PVector(1, 0);
        break;
     case UP:
        lookDirection = new PVector(0, -1);
        break;
     case DOWN:
        lookDirection = new PVector(0, 1);
        break;
    }
  }
  
  void Update()
  {
    //CheckCollision();
    
    CalculateAttraction();
    
    if(attraction >= 0.167f)
    {
      isAttracting = true;
      if(direction == LEFT || direction == UP || direction == DOWN)
        player.velocity.add(diff.copy());
      else
      {
        if(diff.x > 0)
          diff.x *= -1f;
        player.velocity.add(diff.copy());
      }
    }
    else
      isAttracting = false;
      
    CheckTransition();
      
    if(slowingDownPlayer)
      SlowDownPlayer();
      
    wasAttracting = isAttracting;
  }
  
  void CalculateAttraction()
  {
    offset = player.position.copy().sub(position.copy());
    
    dotProduct = lookDirection.x * offset.x + lookDirection.y * offset.y;
    
    xDiff = position.x - player.position.x;
    yDiff = position.y - player.position.y;
    //xDiff = Math.abs(position.x - player.position.x);
    //yDiff = Math.abs(position.y - player.position.y);
    diff = new PVector(xDiff, yDiff);
    diff.mult(deltaTime * attraction * attraction * attractionPower);
    attraction = ((1/position.dist(player.position)) * (1/position.dist(player.position))) * dotProduct * 40f;
  }
  
  void CheckTransition()
  {
    if(isAttracting == false && wasAttracting == true)
    {
      //println("switch");
      //println("isAttracting: " + isAttracting);
      //println("wasAttracting: " + wasAttracting);
      switch(direction)
      {
        case LEFT:
          if(player.velocity.x > player.maxSpeed)
          {
            slowingDownPlayer = true;
          }
          break;
        case RIGHT:
          if(player.velocity.x < -player.maxSpeed)
          {
            slowingDownPlayer = true;
          }
          break;
        case UP:
          if(player.velocity.y > player.maxGrav)
          {
            slowingDownPlayer = true;
          }
          break;
        case DOWN:
          if(player.velocity.y > player.maxGrav)
          {
            slowingDownPlayer = true;
          }
          break;
      }
      slowingDownPlayer = true;
    }
  }
  
  void SlowDownPlayer()
  {
    switch(direction)
    {
      case LEFT:
        if(player.velocity.x > player.maxSpeed)
        {
          player.velocity.x -= slowingDownSpeed;
        }
        else
          slowingDownPlayer = false;
        break;
      case RIGHT:
        if(player.velocity.x < -player.maxSpeed)
        {
          player.velocity.x += slowingDownSpeed;
        }
        else
          slowingDownPlayer = false;
        break;
      case UP:
        if(player.velocity.y > player.maxGrav)
        {
          player.velocity.y -= slowingDownSpeed;
        }
        else
          slowingDownPlayer = false;
        break;  
      case DOWN:
        if(player.velocity.y > player.maxGrav)
        {
          player.velocity.y -= slowingDownSpeed;
        }
        else
          slowingDownPlayer = false;
        break;
    }
  }
  
  void CheckCollision()
  {
    if(position.x + magnetWidth/2 > player.position.x - player.playerWidth/2 && 
       position.x - magnetWidth/2 < player.position.x + player.playerWidth/2 && 
       position.y + magnetHeight/2 > player.position.y - player.playerHeight/2 &&
       position.y - magnetHeight/2 < player.position.y + player.playerHeight/2)
       {
         player.position.sub(player.velocity.copy().mult(deltaTime));
       }
  }
  
  void Draw()
  {
    pushMatrix();
    fill(magnetColor);
    translate(position.x, position.y);
    rect(0, 0, magnetWidth, magnetHeight);
    popMatrix();
    
    pushMatrix();
    translate(width/2, 200);
    textSize(24);
    text("dotProduct: " + dotProduct, 0, 0);
    text("attraction: " + attraction, 0, 40);
    text("xDkiff: " + xDiff, 0, 80);
    text("yDiff: " + yDiff, 0, 120);
    text("isAttracting: " + isAttracting, 0, 160);
    text("slowingDownPlayer: " + slowingDownPlayer, 0, 200);
    text("Velocity: " + player.velocity.toString(), 0, 240);
    popMatrix();
  }
}
