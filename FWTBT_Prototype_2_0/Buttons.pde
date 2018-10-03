class Buttons
{
  //------Position------
  private float x;
  private float y;
  
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
  void update()
  {
    if(type == "button")
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
}
