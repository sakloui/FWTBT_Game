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
      if(((player.position.x) / width - (1 - margin)) * width < ((boxManager.boxes[boxManager.rows-1][0].position.x+boxManager.boxSize/2)-width))
      shiftX = ((player.position.x) / width - (1 - margin)) * width;
      else shiftX = ((boxManager.boxes[boxManager.rows-1][0].position.x+boxManager.boxSize/2)-width);

    }
    if ((player.position.x + -shiftX) / width < margin){
      if(((player.position.x) / width -  margin) * width > 0)
      shiftX = ((player.position.x) / width -  margin) * width;
      else shiftX = 0;
    }

  }

  void UpdateY(){
    if ((player.position.y - shiftY) / height > (1 - margin)){
      if(((player.position.y) / height - (1 - margin)) * height < ((boxManager.boxes[0][boxManager.columns-1].position.y+boxManager.boxSize/2)-height))
      shiftY = ((player.position.y) / height - (1 - margin)) * height;
      else shiftY = ((boxManager.boxes[0][boxManager.columns-1].position.y+boxManager.boxSize/2)-height);
    }
    if ((player.position.y + -shiftY) / height < margin){
      if(((player.position.y) / height - margin) * height > 0)
      shiftY = ((player.position.y) / height - margin) * height;
      else shiftY = 0;
    }
  }
}
