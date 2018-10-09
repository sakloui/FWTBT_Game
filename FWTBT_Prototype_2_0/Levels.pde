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
  private PImage map2;
  private PImage map3;
  
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
      map = loadImage("level" + (selectedLevel + 1) + ".png");
      image(map,width/2,height/2,200,150);
      text("level " + (i+1),width/2,height/2);
      popMatrix();
      }
      if(i == selectedLevel + 1)
      {
      pushMatrix();
      image(greyPanel,width/4*3,height/2,150,200);
      map2 = loadImage("level" + (selectedLevel + 2) + ".png");
      image(map2,width/4*3,height/2,100,75);      
      textSize(16);
      text("level " + (i+1),width/4*3,height/2);
      textSize(28);
      popMatrix();
      }
      if(i == selectedLevel - 1)
      {
      pushMatrix();
      image(greyPanel,width/4,height/2,150,200);
      if(selectedLevel != 0)
      {
      map3 = loadImage("level" + (selectedLevel) + ".png");
      image(map3,width/4,height/2,100,75);   
      }
      textSize(16);
      text("level " + (i+1),width/4,height/2);
      textSize(28);
      popMatrix();
      }
    }
  }
  
}