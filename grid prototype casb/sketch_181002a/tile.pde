class Tile{
   int x;
   int y;
   int r;
   int g;
   int b;
   int tileWidth;
   int tileHeight;
  
  Tile (){
    tileWidth = width / img.width;
    tileHeight = height / img.height;
  }
}
