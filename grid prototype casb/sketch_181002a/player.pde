class Player{
   int x;
   int y;
   int vx;
   int vy;
   int playerWidth;
   int playerHeight;
   int gravity;
  
  Player (){
    x = 100;
    y = 100;
    vx = 0;
    vy = 0;
    gravity = 1;
    playerWidth = 100;
    playerHeight = 100;
  }

  void gravity(){
    vy -= gravity;
    y -= vy;
  }
  
  void collision(){  
    if(y + playerHeight >= height){
    y = height - playerHeight;
    vy = 0;
    }   
  }
  
  void render(){
    fill(255,255,255);
    rect(x, y, playerWidth, playerHeight);
  }
}
