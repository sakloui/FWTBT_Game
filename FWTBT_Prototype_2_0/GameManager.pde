class GameManager
{
  String[] currencyNames;
  float[] currencyValues;

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
    textSize(24);
    textAlign(RIGHT, BOTTOM);
    fill(255);
    translate(currencyPos.x, currencyPos.y);
    for(int i = 0; i < currencyNames.length; i++)
    {
      text(currencyNames[i] + ": " + round(currencyValues[i]), 0, textOffset * i);
    }
    popMatrix();
    textAlign(CENTER,CENTER);

    //images
    pushMatrix();
    imageMode(CORNERS);
    translate(imagePos.x, imagePos.y);

    image(uiScreen, 0, 0);
    image(uiScreenOverlay, 16, 32, 16+36, (32+76)*(1 - currencyValues[1] / powerUpManager.maxFuelCount));

    int uiScreenOverlayCropPixels = int(140 * (currencyValues[4] / highscore.getHighscore(currentLevel)));
    PImage cropOverlay = uiScreen2Overlay.get(0, 0, uiScreenOverlayCropPixels, 32);

    int uiScreenOverlayPixels = int((60+8)*(1 + currencyValues[4] / highscore.getHighscore(currentLevel)));
    image(uiScreen2, 60, 0);
    image(cropOverlay, 60+8, 16, uiScreenOverlayCropPixels + 60+8, 16+32);

    popMatrix();
    imageMode(CENTER);
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
