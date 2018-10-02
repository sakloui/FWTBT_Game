class Objects
{
  //------Position------
  private float x;
  private float y;
  
  //------Object variables------
  String text;
  boolean selected;
  
  //------Images-------
  private PImage buttonUp;
  private PImage buttonDown;
  
  //------Color------
  private color rgb;
  
  Objects(float x, float y, String text, int rgb)
  {
   this.x = x;
   this.y = y;
   this.text = text;
   this.rgb = rgb;
   buttonUp = loadImage("grey_button_up.png");
   buttonDown = loadImage("grey_button_down.png");
  }
  
  void createButton()
  {
    pushMatrix();
    fill(rgb);
    image(buttonUp,x,y);
    text(text,x,y);
    popMatrix();
  }
  void updateButton()
  {
    if(selected)
    {
      pushMatrix();
      fill(rgb);
      image(buttonDown,x,y);
      text(text,x,y+2);
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
}
