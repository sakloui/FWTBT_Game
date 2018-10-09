class Enemy {
  float x, y;
  float radius;
  float vx;
  float top, bottom, left, right;
 
  Enemy() {
    radius = 30;
    x = 100;
    y = height - boxSize -radius;
    vx = 1;
    
  }
    void CheckCollision()
  {
    if(x + radius > player.position.x - player.playerWidth/2 && 
       x - radius < player.position.x + player.playerWidth/2 && 
       y + radius > player.position.y - player.playerHeight/2 &&
       y - radius < player.position.y + player.playerHeight/2)
       {
         player.Health -= 1;
       }
  }

  void Update() {
    CheckCollision();
    top = y - radius; 
    bottom = y + radius;
    left = x - radius;
    right = x + radius;
    x = x + vx;
  }

  void Draw() {
    fill(255, 100, 100);
    ellipse(x, y, radius * 2, radius * 2);
    
    if (x > 16*boxSize){
      vx = -vx;
    }
    
    if ( x < 1*boxSize) {
     vx *= -1;
    }
  }
}
