class Levels
{
  
  //------Position------
  private float x;
  private float y;
  
  //------Object variables------
  private String text;
  private String type;
  int selectedLevel;
  private color rgb;
  private int levels;
  private int[] level;
  
  //------Images------
  private PImage greyPanel;
  private PImage[] map;
  
  Levels(int levels,int rgb)
  {
   this.rgb = rgb;
   this.levels = levels;
   level = new int[levels];
   map = new PImage[levels+1];
   selectedLevel = 0;
   greyPanel = loadImage("Menu/grey_panel.png");
  }
  
  
  void createLevel()
  {
    for(int i = 0; i < level.length;i++)
    {
      image(greyPanel,width/2,height/2);
      map[i] = loadImage("thumbnail" + (i+1) + ".png");
      
    }
  }
  void updateLevel()
  {
    if(input.isRight && selectedLevel < levels-1)
    {
      click.rewind();
      click.play();      
      selectedLevel++;
      input.isRight = false;
    }
    if(input.isLeft && selectedLevel > 0)
    {
      click.rewind();
      click.play();      
      selectedLevel--;
      input.isLeft = false;
    }
    for(int i = 0; i < level.length;i++)
    {
      if(i == selectedLevel)
      {
        pushMatrix();
        image(greyPanel,width/2,height/2,300,400);
        if(map[selectedLevel] != null)
          image(map[selectedLevel],width/2,height/2,200,150);
        text("level " + (i+1),width/2,height/2-100);

        int score = highscore.getHighscore(selectedLevel);

        text("score: " + score,width/2,height/2+100);
        popMatrix();
      }
      if(i == selectedLevel + 1)
      {
        pushMatrix();
        image(greyPanel,width/4*3,height/2,150,200);
        if(map[selectedLevel + 1] != null)
          image(map[selectedLevel + 1],width/4*3,height/2,100,75);      
        textSize(16);
        text("level " + (i+1),width/4*3,height/2-50);

        if(selectedLevel != menu.amountOfLevels)
        {
          int score = highscore.getHighscore(selectedLevel + 1);
          text("score: " + score,width/4*3,height/2+50);    
        }

        textSize(28);
        popMatrix();
      }
      if(i == selectedLevel - 1)
      {
        pushMatrix();
        image(greyPanel,width/4,height/2,150,200);
        if(selectedLevel != 0)
        {
        if(map[selectedLevel - 1] != null)
          image(map[selectedLevel - 1],width/4,height/2,100,75);   
        }
        textSize(16);
        text("level " + (i+1),width/4,height/2-50);

        if(selectedLevel != 0)
        {
          int score = highscore.getHighscore(selectedLevel - 1);
          text("score: " + score,width/4,height/2+50); 
        }

        textSize(28);
        popMatrix();
      }
    }
  }
  
}
