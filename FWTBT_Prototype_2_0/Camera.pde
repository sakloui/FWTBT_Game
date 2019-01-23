class Camera
{
  float shiftX;
  float shiftY;
  float margin;
  float shiftXOrigin;
  float shiftYOrigin;
  float focusX;
  float focusY;

  Camera(){
    shiftX = 0;
    shiftY = 0;
    shiftXOrigin = 0;
    shiftYOrigin = 0;
    focusX = 0;
    focusY = 0;
    margin = 0.48;
  }

  void UpdateX(){

    //Checkt of player aan de rechterkant buiten de marge is
    if ((player.position.x - shiftX) / width > (1 - margin)){

      //Checkt of als de shift value word veranderd dan de rand van het level niet zichtbaar is
      if(((player.position.x) / width - (1 - margin)) * width < ((boxManager.boxes[boxManager.rows-1][0].position.x+boxManager.boxSize/2)-width)){

        //Shift value zodat de player weer binnen de marge valt
        shiftX = ((player.position.x) / width - (1 - margin)) * width;
      } else {

        //Checkt of als de shift value word veranderd dan de rand van het level zichtbaar is
        shiftX = ((boxManager.boxes[boxManager.rows-1][0].position.x+boxManager.boxSize/2)-width);
      }
    }

    //Checkt of player aan de linkerkant buiten de marge is
    if ((player.position.x + -shiftX) / width < margin){

      //Checkt of als de shift value word veranderd dan de rand van het level niet zichtbaar is
      if(((player.position.x) / width -  margin) * width > 0){

        //Shift value zodat de player weer binnen de marge valt
        shiftX = ((player.position.x) / width -  margin) * width;
      } else {

        //Shift value zodat de rand van de wereld niet zichtbaar is
        shiftX = 0;
      }
    }
  }

  void UpdateY(){

    //Checkt of player aan de onderkant kant buiten de marge is
    if ((player.position.y - shiftY) / height > (1 - margin)){

      //Checkt of als de shift value word veranderd dan de rand van het level niet zichtbaar is
      if(((player.position.y) / height - (1 - margin)) * height < ((boxManager.boxes[0][boxManager.columns-1].position.y+boxManager.boxSize/2)-height)){

        //Shift value zodat de player weer binnen de marge valt
        shiftY = ((player.position.y) / height - (1 - margin)) * height;
      } else {

        //Shift value zodat de rand van de wereld niet zichtbaar is
        shiftY = ((boxManager.boxes[0][boxManager.columns-1].position.y+boxManager.boxSize/2)-height);
      }
    }

    //Checkt of player aan de bovenkant buiten de marge is
    if ((player.position.y + -shiftY) / height < margin){

      //Checkt of als de shift value word veranderd dan de rand van het level niet zichtbaar is
      if(((player.position.y) / height - margin) * height > 0){

        //Shift value zodat de player weer binnen de marge valt
        shiftY = ((player.position.y) / height - margin) * height;
      } else {

        //Shift value zodat de rand van de wereld niet zichtbaar is
        shiftY = 0;
      }
    }
  }
}
