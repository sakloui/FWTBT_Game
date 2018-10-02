class Menu
{
  //------Menu------

  //------Classes------
  private Buttons[] button;
  private Levels level;
  //------Variables------
  private int currentSel;
  Menu()
  {
    button = new Buttons[10];
    createMainMenu();
    button[0].selected = true;
    currentSel = 0;
  }
  
  void update()
  {
    
    
  }
  
  void draw()
  {
    updateMenu();
  }
  void createMainMenu()
  {
    for(int i = 0; i < button.length;i++)
    {
      button[i] = null;
    }
    level = null;
    button[0] = new Buttons(width/2,height/2-75,"Play","button",74);
    button[0].createButton();
    button[1] = new Buttons(width/2,height/2,"Options","button",74);
    button[1].createButton();
    button[2] = new Buttons(width/2,height/2+75,"Exit","button",74);
    button[2].createButton();    

  }
  void createOptions()
  {
    for(int i = 0; i < button.length;i++)
    {
      button[i] = null;
    }

    level = null;

    button[0] = new Buttons(width/2 ,height/2-75,"Option 1","button",74);
    button[0].createButton();
    button[1] = new Buttons(width/2,height/2,"Option 2","button",74);
    button[1].createButton();
    button[2] = new Buttons(width/2,height/2+75,"Back","button",74);
    button[2].createButton();


  }
  void createLevelSelect()
  {
    for(int i = 0; i < button.length;i++)
    {
      button[i] = null;
    
    }
    level = null;
    level = new Levels(10,74);
    level.createLevel();
    button[0] = new Buttons(width/2,height-100,"Back","button",74);
    button[0].createButton();  
  }
  void updateMenu()
  { 
    
    for(int i = 0; i < button.length; i++)
    {
      if(button[i] != null)
      {
        button[i].update();
        if(button[i].selected)currentSel = i;
      }
    }
    //------Input handling------
    if(isUp)
    {
      if(currentSel <= 0)
      {
        isUp = false;
      }
      else
      { //<>//
        button[currentSel].selected = false;
        button[currentSel].selected= false;
        button[currentSel-1].selected = true;
        currentSel--;
        isUp = false;
      }
      
    }
    if(isDown)
    {
      if(currentSel > button.length)
      {
        isDown = false;
      }
      else
      {
        if(button[currentSel+1] != null)
        {
          button[currentSel].selected = false;
          button[currentSel+1].selected = true;
          currentSel++;
          isDown = false;
        }
      }
      
    }
    if(isSpace)
    {
      isSpace = false;
      println(button[currentSel].text);
      if(button[currentSel].text == "Play"){button[currentSel].selected = false;currentSel = 0;createLevelSelect();button[currentSel].selected = true;return;}
      if(button[currentSel].text == "Exit")exit();
      if(button[currentSel].text == "Options"){button[currentSel].selected = false;currentSel = 0;createOptions();button[currentSel].selected = true;return;}
      if(button[currentSel].text == "Back"){button[currentSel].selected = false;button[currentSel].selected = false;currentSel = 0;createMainMenu();button[currentSel].selected = true;return;}
    }
    //------End of input handling------
    
  }
    
}
