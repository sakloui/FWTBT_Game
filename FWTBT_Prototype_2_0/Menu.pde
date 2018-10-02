class Menu
{
  //------Menu------
  private int menuState;

  //------Classes------
  private Objects[] object;
  
  //------Variables------
  private int currentSel;
  Menu()
  {
    menuState = 0;
    object = new Objects[10];
    createMainMenu();
    object[0].selected = true;
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
    for(int i = 0; i < object.length;i++)
    {
      object[i] = null;
    }
    object[0] = new Objects(width/2,height/2-75,"Play",74);
    object[0].createButton();
    object[1] = new Objects(width/2,height/2,"Options",74);
    object[1].createButton();
    object[2] = new Objects(width/2,height/2+75,"Exit",74);
    object[2].createButton();    

  }
  void createOptions()
  {
    for(int i = 0; i < object.length;i++)
    {
      object[i] = null;
    }
    object[0] = new Objects(width/3 ,height/2-75,"Option 1",74);
    object[0].createButton();
    object[1] = new Objects(width/3,height/2,"Option 2",74);
    object[1].createButton();
    object[2] = new Objects(width/3*2 ,height/2-75,"Option 3",74);
    object[2].createButton();
    object[3] = new Objects(width/3*2,height/2,"Back",74);
    object[3].createButton();


  }
  void updateMenu()
  { 
    
    for(int i = 0; i < object.length; i++)
    {
      if(object[i] != null)
      {
        object[i].updateButton();
        if(object[i].selected)currentSel = i;
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
      {
        object[currentSel].selected = false;
        object[currentSel-1].selected = true;
        currentSel--;
        isUp = false;
      }
      
    }
    if(isDown)
    {
      if(currentSel > object.length)
      {
        isDown = false;
      }
      else
      {
        if(object[currentSel+1] != null)
        {
          object[currentSel].selected = false;
          object[currentSel+1].selected = true;
          currentSel++;
          isDown = false;
        }
      }
      
    }
    if(isSpace)
    {
      println(object[currentSel].text);
      if(object[currentSel].text == "Exit")exit();
      if(object[currentSel].text == "Options"){object[currentSel].selected = false;currentSel = 0;createOptions();object[currentSel].selected = true;}
      if(object[currentSel].text == "Back"){object[currentSel].selected = false;currentSel = 0;createMainMenu();object[currentSel].selected = true;}
      isSpace = false;
    }
    //------End of input handling------
    
  }
    
}
