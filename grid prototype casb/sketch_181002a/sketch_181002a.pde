Player player;
Tile tile;
PImage img;
Tile[] map;
int gravity = 3;

void setup(){
  player = new Player();  
  img = loadImage("map.png");
  img.loadPixels();
  map = new Tile[img.pixels.length];
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int p = x + (y * img.width);
      map[p] = new Tile();
      if(img.pixels[p] == color(0,0,0)){
        map[p].x = x * map[p].tileWidth;
        map[p].y = y * map[p].tileHeight;
        map[p].r = 255;
        map[p].g = 255;
        map[p].b = 0;
        
      } else {
        map[p].x = x * map[p].tileWidth;
        map[p].y = y * map[p].tileHeight;
        map[p].r = 0;
        map[p].g = 0;
        map[p].b = 0;
      }
    }
  }
  fullScreen(P2D);
}

void draw(){
  background(255, 0, 0);
  
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int p = x + (y * img.width);
      fill(map[p].r,map[p].g, map[p].b);
      rect(map[p].x, map[p].y, map[p].tileWidth, map[p].tileHeight);
    }
  }

<<<<<<< HEAD
=======
  
  
  
>>>>>>> 2fa6334b50e347a6e63cef0faefa6c62d7aabcd7
  player.gravity();
  player.collision();
  player.render();
  
<<<<<<< HEAD
}
=======
} //<>//
>>>>>>> 2fa6334b50e347a6e63cef0faefa6c62d7aabcd7
