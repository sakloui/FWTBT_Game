class Menu
{

  //------Menu------
  private int menuState;
  //------Classes------
  private Buttons[] button;
  private Levels level;
  private Sliders sliders;
  private ArrayList<Background> back = new ArrayList<Background>();
  //------Variables------
  private int amountOfLevels;
  private int currentSel;
  private int alpha;
  private boolean highscoreShown;
  private boolean mainmenuShown;
  private int timer = 40;
  private float textAlpha = 0f;
  private float textBlinkingSpeed = 7f;
  private boolean increaseAlpha;
  //------Sound------
  
  Menu()
  {
    menuState = 0;
    button = new Buttons[10];
    createMainMenu();
    button[0].selected = true;
    currentSel = 0;
    alpha = 0; 
    highscoreShown = false;
    amountOfLevels = 10;
  }
  
  void update()
  {
    if(input.isR){
      boxManager = new BoxManager(currentLevel);
      gameManager.currencyValues[3]++;
      gameManager.currencyValues[2] = 0;
      input.isR = false;
    }
  }
  
  void draw()
  {
    updateMenu();
    if(menuState == 1)level.updateLevel();
  }

  void createMainMenu()
  {
    highscoreShown = false;
    for(int i = 0; i < button.length;i++)
    {
      button[i] = null;
    }
    level = null;
    sliders = null;

    mainmenuShown = true;
    button[0] = new Buttons(width/2,height/2-75,"Play","button",74);
    //button[0].createButton();
    button[1] = new Buttons(width/2,height/2,"Options","button",74);
    //button[1].createButton();
    button[2] = new Buttons(width/2,height/2+75,"Exit","button",74);
    //button[2].createButton();    
    button[4] = new Buttons(width/2,height/2-200,"For whom the bell tolls","rotatingText",100);
    //button[4].createButton();
  }
  void createOptions()
  {
    mainmenuShown = true;
    highscoreShown = false;
    for(int i = 0; i < button.length;i++)
    {
      button[i] = null;
    }

    level = null;
    sliders = null;
    String[] text = {"Music volume", "Sound effects volume"};
    sliders = new Sliders(2,text,100);
    sliders.createSlider();
    button[0] = new Buttons(width/2,height/2+75,"Back","button",74);
    button[0].createButton();


  }
  void createLevelSelect()
  {
    bossLevelMusic.pause();
    if(levelmusic != null)
    levelmusic.pause();
    mainmenuShown = false;
    highscoreShown = false;
    for(int i = 0; i < button.length;i++)
    {
      button[i] = null;
    
    }
    level = null;
    sliders = null;

    level = new Levels(amountOfLevels ,74);
    level.createLevel();
    button[0] = new Buttons(width/2,height-125,"Select","button",74);
    button[0].createButton();
    button[1] = new Buttons(width/2,height-50,"Back","button",74);
    button[1].createButton();  
  }
  void createEndLevel()
  {
    input.isSpace = false;
    bossLevelMusic.pause();
    if(levelmusic != null)
    levelmusic.pause();
    println("create end level");
    mainmenuShown = false;
    for(int i = 0; i < button.length;i++)
    {
      button[i] = null;
    
    }
    level = null;
    sliders = null;
    PImage maptest = loadImage("level"+(boxManager.level+1)+".png");

    if(maptest != null)
    {
      button[0] = new Buttons(width/2,height-125,"Continue","button",74);
      button[0].createButton();
      //button[0].selected = true;  
      button[1] = new Buttons(width/2,height-50,"Main Menu","button",74);
      button[1].createButton();
      highscoreShown = true;
      highscore.showHighscore();          
    }
    else
    {
      button[0] = new Buttons(width/2,height-50,"Main Menu","button",74);
      button[0].createButton();
      //button[0].selected = true;
      highscoreShown = true;
      highscore.showHighscore();        
    }

  }  
  void createDied()
  {
    input.isSpace = false;
    bossLevelMusic.pause();
    mainmenuShown = false;
    highscoreShown = false;
    for(int i = 0; i < button.length;i++)
    {
      button[i] = null;
    
    }
    level = null;
    sliders = null;

    button[0] = new Buttons(width/2,height-125,"Retry","button",74);
    button[0].createButton();
    button[0].selected = true;  
    button[1] = new Buttons(width/2,height-50,"Main Menu","button",74);
    button[1].createButton();
    button[2] = new Buttons(width/2,height/2,"You died, continue?","text",50);
    button[2].createButton();   
    button[3] = new Buttons(width/2, height/2-50, "The highscore is: " + str(highscore.getHighscore(currentLevel-1)), "text", 50);           

  }  

  void registerName()
  {
    if (key==CODED)
    {
      if (keyCode==LEFT)
        println ("left");
      else if (keyCode==RIGHT)
        println ("right");
      else if (keyCode==UP)
        println ("up");
      else if (keyCode==DOWN)
        println ("down");
    }
    else
    {
      if (key==BACKSPACE)
      {
        if (playerName.length()>0)
          playerName=playerName.substring(0, playerName.length()-1);
      }
      else if(key== ' ')
      {
        //prompt message can't use space in name
        highscore.topString = "You can't use spaces in your name";
      }
      else if (key==RETURN || key==ENTER)
      {
        if(playerName.length()>0)
        {
          highscore.nameTable.setString(highscore.highscoreRow, highscore.getLevelString(currentLevel), playerName);
          saveTable(highscore.nameTable, "data/PlayerNames.csv");
          isTypingName = false;
          button[0].selected = true;
        }
        else
        {
          highscore.topString = "Please enter your name before you continue";
          return;
        }
      }
      else
      {
        if(playerName.length() < highscore.maxPlayerNameLength)
          playerName+=key;
        else
          highscore.topString = "Max name length reached";
      }
    }
  }

  void showPlayerName()
  {
    pushMatrix();
    translate(353, 138);
    textAlign(LEFT, CENTER);

    if(increaseAlpha)
      textAlpha += textBlinkingSpeed;
    else if(!increaseAlpha)
      textAlpha -= textBlinkingSpeed;

    if(textAlpha >= 255f && increaseAlpha)
    {
      textAlpha = 255f;
      increaseAlpha = false;
    }
    else if(textAlpha <= 75f && !increaseAlpha)
    {
      textAlpha = 75f;
      increaseAlpha = true;
    }

    fill(highscore.blinkingTextColor);
    text(playerName, 0, highscore.highscoreTableLineSpacing * (highscore.highscoreRow));
    
    textAlign(CENTER);
    popMatrix();
  }

  void updateMenu()
  { 
      if(mainmenuShown)
      {
        image(background,width/2,height/2,width, height);
        if(timer == 0)
        {
          back.add(new Background());
          timer = 40;
        }
        else timer--;
        
        for(int i = 0; i < back.size(); i++)
        {
          back.get(i).Update(); 
        }
        for(int i = 0; i < back.size(); i++)
        {
          back.get(i).Draw(); 
        }        
      }

      if(sliders != null)
      sliders.updateSlider();
      
      if(highscoreShown)
        highscore.showHighscore();

      for(int i = 0; i < button.length; i++)
      {
        if(button[i] != null)
        {
          button[i].update();
          if(button[i].selected)currentSel = i;
        }
      }


      //------Input handling------
      if(input.isUp)
      {
        click.rewind();
        click.play();
        if(currentSel <= 0)
        {
          input.isUp = false;
        }
        else
        { 
          button[currentSel].selected = false;
          button[currentSel].selected= false;
          button[currentSel-1].selected = true;
          currentSel--;
          input.isUp = false;
        }
        
      }
      if(input.isDown)
      {
        click.rewind();
        click.play();
        if(currentSel > button.length)
        {
          input.isDown = false;
        }
        else
        {
          if(button[currentSel+1] != null)
          {
            button[currentSel].selected = false;
            button[currentSel+1].selected = true;
            currentSel++;
            input.isDown = false;
          }
        }
        
      }
      if((input.isSpace || input.isK) && !isTypingName)
      {
        click2.rewind();
        click2.play();
        input.isSpace = false;
        input.isK = false;
        if(button[currentSel].text == "Play")
          {
            button[currentSel].selected = false;
            currentSel = 0;
            createLevelSelect();
            button[currentSel].selected = true;
            menuState = 1;return;
          }
        if(button[currentSel].text == "Exit")
          exit();
        if(button[currentSel].text == "Select")
          {
            if(levelmusic != null)
            levelmusic.pause();
            int r = round(random(0,1));
            if(r == 0)
            {
              if(levelmusic == levelmusic1)
                levelmusic.rewind();
              else levelmusic = levelmusic1;
            }
            else 
            {
              if(levelmusic == levelmusic2)
                levelmusic.rewind();
              else levelmusic = levelmusic2;
            };
            levelmusic.setGain(-40 + volume[0]);              
            mainmenuShown = false;
            back.clear();
            currentLevel = level.selectedLevel+1;
            boxManager = new BoxManager(currentLevel);
            isMenu = false;mainMusic.pause();
            player.velocity.y = 0;

          }
        if(button[currentSel].text == "Options")
          {
            button[currentSel].selected = false;
            currentSel = 0;
            createOptions();
            button[currentSel].selected = true;
            return;
          }
        if(button[currentSel].text == "Back")
          {
            button[currentSel].selected = false;
            currentSel = 0;
            createMainMenu();
            button[currentSel].selected = true;
            menuState = 0;
            return;
          }
        if(button[currentSel].text == "Main Menu")
          {
            if(levelmusic != null)
            levelmusic.pause();            
            button[currentSel].selected = false;
            currentSel = 0;
            createMainMenu();
            gameManager = new GameManager();
            button[currentSel].selected = true;
            menuState = 0;
            mainMusic.rewind();
            mainMusic.play();
            return;
          }
        if(button[currentSel].text == "Continue")
          {
            if(levelmusic != null)
            levelmusic.pause();
            int r = round(random(0,1));
            if(r == 0)
            {
              if(levelmusic == levelmusic1)
                levelmusic.rewind();
              else levelmusic = levelmusic1;
            }
            else 
            {
              if(levelmusic == levelmusic2)
                levelmusic.rewind();
              else levelmusic = levelmusic2;
            }
            levelmusic.setGain(-40 + volume[0]);              
            currentLevel++; 
            boxManager = new BoxManager(currentLevel); 
            gameManager = new GameManager();
            isMenu = false;

          }
        if(button[currentSel].text == "Retry")
          {
            gameManager.furthestCheckPoint = checkPointManager.getCurrentCheckPoint();
            boxManager = new BoxManager(currentLevel);
            gameManager.currencyValues[2] = 0;
            isMenu = false;
          }
      }
  }
    
}
