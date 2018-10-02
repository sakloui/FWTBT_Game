class Levels
{
  
  //------Position------
  private float x;
  private float y;
  
  //------Object variables------
  private String text;
  private String type;
  private int selectedLevel;
  private color rgb;
  private int levels;
  private int[] level;
  
  //------Images------
  private PImage greyPanel;
  
  Levels(int levels,int rgb)
  {
   this.rgb = rgb;
   this.levels = levels;
   level = new int[levels];
   selectedLevel = 0;
   greyPanel = loadImage("grey_panel.png");
  }
  
  
  void createLevel()
  {
    for(int i = 0; i < level.length;i++)
    {
      image(greyPanel,width/2,height/2);
      
    }
  }
  void updateLevel()
  {
    if(isRight && selectedLevel < levels-1)
    {
      click.rewind();
      click.play();      
      selectedLevel++;
      isRight = false;
    }
    if(isLeft && selectedLevel > 0)
    {
      click.rewind();
      click.play();      
      selectedLevel--;
      isLeft = false;
    }
    for(int i = 0; i < level.length;i++)
    {
      if(i == selectedLevel)
      {
      pushMatrix();
      image(greyPanel,width/2,height/2,300,400);
      text("level " + (i+1),width/2,height/2);
      popMatrix();
      }
      if(i == selectedLevel + 1)
      {
      pushMatrix();
      image(greyPanel,width/4*3,height/2,150,200);
      textSize(16);
      text("level " + (i+1),width/4*3,height/2);
      textSize(32);
      popMatrix();
      }
      if(i == selectedLevel - 1)
      {
      pushMatrix();
      image(greyPanel,width/4,height/2,150,200);
      textSize(16);
      text("level " + (i+1),width/4,height/2);
      textSize(32);
      popMatrix();
      }
    }
  }
  
}
