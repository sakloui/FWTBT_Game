class Levels
{
  
  //------Position------
  private float x;
  private float y;
  
  //------Object variables------
  private String text;
  private String type;
  private boolean selectedLevel;
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
   greyPanel = loadImage("grey_panel.png");
  }
  
  
  void createLevel()
  {
    for(int i = 0; i < level.length;i++)
    {
      
      
    }
  }
  
  
}
