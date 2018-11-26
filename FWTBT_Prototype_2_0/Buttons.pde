class Buttons
{
  //------Position------
  private float x;
  private float y;
  private float r;
  private float rv;
  //------Object variables------
  String text;
  String type;
  boolean selected;
  boolean selectedLevel;
  
  //------Images-------
  private PImage buttonUp;
  private PImage buttonDown;
  
  //------Color------
  private color rgb;
  
  Buttons(float x, float y, String text, String type ,int rgb)
  {
   this.x = x;
   this.y = y;
   this.text = text;
   this.rgb = rgb;
   this.type = type;
   buttonUp = loadImage("Menu/grey_button_up.png");
   buttonDown = loadImage("Menu/grey_button_down.png");
   r = 0;
   rv = 0.05;
  }
  
  
  void createButton()
  {
    pushMatrix();
    fill(rgb);
    if(type != "text")
    image(buttonUp,x,y);
    text(text,x,y);
    popMatrix();
  }
  void update()
  {
    if(type == "button")
    {
      if(selected)
      {
        pushMatrix();
        fill(rgb);
        image(buttonDown,x,y);    
        text(text,x,y+3);
        popMatrix();
      }
      else
      {
        pushMatrix();
        fill(rgb);
        image(buttonUp,x,y);
        text(text,x,y);
        popMatrix();
      }
    }
    if(type == "rotatingText")
    {
      pushMatrix();
      fill(rgb);
      textSize(28+(mainMusic.left.get(1)*5));
      translate(x,y+2);
      rotate(radians(r));
      text(text,0,0);
      textSize(28);
      popMatrix();
      if(r > 5)rv = -rv;
      if(r < -5)rv = -rv;
      r += rv;
    }
    if(type == "text")
    {
      pushMatrix();
      fill(rgb);
      translate(x,y+2);
      text(text,0,0);
      popMatrix();
    }    
  }
}
