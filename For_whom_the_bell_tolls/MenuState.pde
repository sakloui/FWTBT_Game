public class MenuState extends State
{
  //----------button dimensions----------
  int buttonWidth = 200;
  int buttonHeight = 75;

  //----------text dimensions----------
  int textOffset = -5;

  //----------colors----------
  color buttonColor = color(255, 0, 0);
  color textColor = color(0, 255, 0);

  //----------other----------
  int buttonIndex = 0;
  float upCounter, downCounter;
  float menuScrollDelay = 0.125f;
  boolean isUpCounting, isDownCounting;

  public void OnStateEnter()
  {
  }

  public void OnTick()
  {
    MenuScroll();
    if (input.isK)
    {
      switch(buttonIndex)
      {
      case 0:
        //open the game state
        //SetState(new GameState());
        break;
      case 1:
        //open settings menu
        //SetState(new PowerUpState());
        break;
      case 2:
        //exit application
        exit();
        break;
      default:
        println("ERROR: buttonIndex out of range");
        break;
      }
    }
  }

  public void MenuScroll()
  {
    if (!input.isUp)
    {
      isUpCounting = false;
      upCounter = 0;
    }
    if (input.isUp)
    {
      if (isUpCounting)
      {
        upCounter += deltaTime;
        if (upCounter > menuScrollDelay)
        {
          upCounter -= menuScrollDelay;
          if (buttonIndex == 0)
          {
            buttonIndex = 2;
          } else
          {
            buttonIndex--;
          }
        }
      } else
      {
        if (buttonIndex == 0)
        {
          buttonIndex = 2;
        } else
        {
          buttonIndex--;
        }
        isUpCounting = true;
      }
    }

    if (!input.isDown)
    {
      isDownCounting = false;
      downCounter = 0;
    }
    if (input.isDown)
    {
      if (isDownCounting)
      {
        downCounter += deltaTime;
        if (downCounter > menuScrollDelay)
        {
          downCounter -= menuScrollDelay;
          if (buttonIndex == 2)
          {
            buttonIndex = 0;
          } else
          {
            buttonIndex++;
          }
        }
      } else
      {
        if (buttonIndex == 2)
        {
          buttonIndex = 0;
        } else
        {
          buttonIndex++;
        }
        isDownCounting = true;
      }
    }
  }

  public void OnDraw()
  {
    pushMatrix();

    translate(width/2, height/2);
    textSize(32);
    strokeWeight(4);

    //play button
    if (buttonIndex == 0)
    {
      stroke(255, 255, 0);
    } else
    {
      noStroke();
    }
    fill(buttonColor);
    rect(0, -100, buttonWidth, buttonHeight, 10);
    fill(textColor);
    text("Play", 0, -100 + textOffset);

    //settings button
    if (buttonIndex == 1)
    {
      stroke(255, 255, 0);
    } else
    {
      noStroke();
    }
    fill(buttonColor);
    rect(0, 0, buttonWidth, buttonHeight, 10);
    fill(textColor);
    text("Settings", 0, 0 + textOffset);

    //exit button
    if (buttonIndex == 2)
    {
      stroke(255, 255, 0);
    } else
    {
      noStroke();
    }

    fill(buttonColor);
    rect(0, 100, buttonWidth, buttonHeight, 10);
    fill(textColor);
    text("Exit", 0, 100 + textOffset);

    popMatrix();
  }

  public void OnStateExit()
  {
  }
}
