class Camera
{
  float shiftX;
  float shiftY;
  float margin;

  Camera(){
    shiftX = 0;
    shiftY = 0;
    margin = 0.48;
  }

  void UpdateX(){
    if ((player.position.x - shiftX) / width > (1 - margin)){
      shiftX = ((player.position.x) / width - (1 - margin)) * width;
    }
    if ((player.position.x + -shiftX) / width < margin){
      shiftX = ((player.position.x) / width -  margin) * width;
    }
  }

  void UpdateY(){
    if ((player.position.y - shiftY) / height > (1 - margin)){
      shiftY = ((player.position.y) / height - (1 - margin)) * height;
    }
    if ((player.position.y + -shiftY) / height < margin){
      shiftY = ((player.position.y) / height - margin) * height;
    }
  }
}