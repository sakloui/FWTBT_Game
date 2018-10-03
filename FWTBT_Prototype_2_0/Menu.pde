class Menu
{

  //------Menu------
  private int menuState;
  //------Classes------
  private Buttons[] button;
  private Levels level;
  //------Variables------
  private int currentSel;
  //------Sound------

  
  Menu()
  {
    menuState = 0;
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
    if(menuState == 1)level.updateLevel();
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
    button[4] = new Buttons(width/2,height/2-200,"For whom the bell tolls","text",74);
    button[4].createButton();
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
    level = new Levels(7 ,74);
    level.createLevel();
    button[0] = new Buttons(width/2,height-125,"Select","button",74);
    button[0].createButton();
    button[1] = new Buttons(width/2,height-50,"Back","button",74);
    button[1].createButton();  
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
        click.rewind();
        click.play();
        if(currentSel <= 0)
        {
          isUp = false;
        }
        else
        { 
          button[currentSel].selected = false;
          button[currentSel].selected= false;
          button[currentSel-1].selected = true;
          currentSel--;
          isUp = false;
        }
        
      }
      if(isDown)
      {
        click.rewind();
        click.play();
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
        click2.rewind();
        click2.play();
        isSpace = false;
        println(button[currentSel].text);
        if(button[currentSel].text == "Play"){button[currentSel].selected = false;currentSel = 0;createLevelSelect();button[currentSel].selected = true;menuState = 1;return;}
        if(button[currentSel].text == "Exit")exit();
        if(button[currentSel].text == "Select"){currentLevel = level.selectedLevel+1;loadMap(currentLevel);isMenu = false;mainMusic.pause();}
        if(button[currentSel].text == "Options"){button[currentSel].selected = false;currentSel = 0;createOptions();button[currentSel].selected = true;return;}
        if(button[currentSel].text == "Back"){button[currentSel].selected = false;button[currentSel].selected = false;currentSel = 0;createMainMenu();button[currentSel].selected = true;menuState = 0;return;}
      }
  }
    
}
