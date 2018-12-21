class GameManager
{
  String[] currencyNames;
  float[] currencyValues;

  int furthestCheckPoint = 0;

  float textOffset = 30f;
  color textColor = color(0);

  PVector currencyPos = new PVector(width, 0);
  PVector imagePos = new PVector(20, 20);


  GameManager()
  {
    currencyNames = new String[6];
    currencyValues = new float[currencyNames.length];

    currencyNames[0] = "Bolts";
    currencyNames[1] = "Fuel";
    currencyNames[2] = "Time passed";
    currencyNames[3] = "Times died";
    currencyNames[4] = "Score";
    currencyNames[5] = "Framerate";

    currencyValues[0] = 0f;
    currencyValues[1] = 0f;
    currencyValues[2] = 0f;
    currencyValues[3] = 0f;
    currencyValues[4] = 0f;
  }

  void Update()
  {
    currencyValues[1] = powerUpManager.fuelCount;
    currencyValues[2] += deltaTime;
    currencyValues[5] = round(frameRate);

    updateCurrency();

  }

  void Draw()
  {
    pushMatrix();
    textFont(pixelFont);
    textSize(32);
    textAlign(RIGHT, BOTTOM);
    fill(255);
    translate(currencyPos.x, currencyPos.y);
    for(int i = 0; i < currencyNames.length; i++)
    {
      text(currencyNames[i] + ": " + round(currencyValues[i]), 0, textOffset * i);
    }
    popMatrix();
    textAlign(LEFT,CENTER);

    //images
    pushMatrix();
    imageMode(CORNERS);
    translate(imagePos.x, imagePos.y);

    if (currencyValues[1] < (powerUpManager.maxFuelCount/2.5)){
      image(uiScreen, 0, 0);
      image(uiScreenOverlay, 16, 40, 16+36, 40 + (69*(1 - currencyValues[1] / powerUpManager.maxFuelCount)));
    } else {
      image(uiScreenGreen, 0, 0);
      image(uiScreenOverlayGreen, 16, 40, 16+36, 40 + (69*(1 - currencyValues[1] / powerUpManager.maxFuelCount)));
    }

    image(uiScreen3,60,60);
    fill(79,0,0);
    text("DEATHS :" + int(currencyValues[3]),72.5,89);
    fill(255,0,0);
    text("DEATHS :" + int(currencyValues[3]),72.5,85);
    fill(255);   

    image(uiScreen4,0,120);
    fill(79,0,0);
    text("Time : " + int(currencyValues[2]/60) + ":" + int(currencyValues[2]) + ":" + (int((currencyValues[2] - int(currencyValues[2]))*100)),10,149);
    fill(255,0,0);
    text("Time : " + int(currencyValues[2]/60) + ":" + int(currencyValues[2]) + ":" + (int((currencyValues[2] - int(currencyValues[2]))*100)),10,145);
    fill(255);        

    int uiScreenOverlayCropPixels = int(140 * (currencyValues[4] / highscore.getHighscore(currentLevel-1)));

    PImage cropOverlay = uiScreen2Overlay.get(0, 0, uiScreenOverlayCropPixels, 32);
    PImage cropOverlayGreen = uiScreen2OverlayGreen.get(0, 0, uiScreenOverlayCropPixels, 32);

    int uiScreenOverlayPixels = int((60+8)*(1 + currencyValues[4] / highscore.getHighscore(currentLevel-1)));

    if (currencyValues[4] < highscore.getHighscore(currentLevel-1)){
      image(uiScreen2, 60, 0);
      image(cropOverlay, 60+8, 16, uiScreenOverlayCropPixels + 60+8, 16+32);
    } else {
      image(uiScreen2Green, 60, 0);
      image(cropOverlayGreen, 60+8, 16, uiScreenOverlayCropPixels + 60+8, 16+32);
    }


    popMatrix();
    textFont(font);    
    imageMode(CENTER);
    textAlign(CENTER,CENTER);
  }

  void resetValues()
  {
    currencyValues[0] = 0f;
    currencyValues[1] = 0f;
    currencyValues[4] = 0f;
  }

  void drawCurrency()
  {
    if(coins != null)
      for (int i = 0; i < coins.size(); ++i) {
        coins.get(i).Draw();
      }
  }
  void updateCurrency()
  {
    if(coins != null)
      for (int i = 0; i < coins.size(); ++i) {
        coins.get(i).Update();
      }
  }
}
