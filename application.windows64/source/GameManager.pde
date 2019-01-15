class GameManager
{
  String[] currencyNames;
  float[] currencyValues;

  int furthestCheckPoint = 0;

  float textOffset = 30f;
  color textColor = color(0);

  PVector currencyPos = new PVector(width, 0);
  PVector imagePos = new PVector(0, 0);

  float seconds;
  float counter;
  float maxTime;

  float highS;

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
    if(!pauseWorld)
    {
      highS = highscore.getHighscore(currentLevel-1);
      currencyValues[1] = powerUpManager.fuelCount;
      currencyValues[2] += deltaTime;
      currencyValues[5] = round(frameRate);
      seconds += deltaTime;    

      if(seconds >= 60)
        seconds = 0;


      updateCurrency();
    }
  }

  void Draw()
  {

    textFont(pixelFont);
    textSize(32);
    //pushMatrix();
    // fill(255);
    // translate(currencyPos.x, currencyPos.y);
    // for(int i = 0; i < currencyNames.length; i++)
    // {
    //   text(currencyNames[i] + ": " + round(currencyValues[i]), 0, textOffset * i);
    // }
    //popMatrix();
    textAlign(LEFT,CENTER);

    //images
    pushMatrix();
    imageMode(CORNERS);
    translate(imagePos.x, imagePos.y);

    if (currencyValues[1] < 10){
      image(uiScreenEmpty, 0 ,0);
    } else if (currencyValues[1] < (powerUpManager.maxFuelCount/2.5)){
      image(uiScreen, 0, 0);
      image(uiScreenOverlay, 16, 40, 16+36, 40 + (69*(1 - currencyValues[1] / powerUpManager.maxFuelCount)));
    } else {
      image(uiScreenGreen, 0, 0);
      image(uiScreenOverlayGreen, 16, 40, 16+36, 40 + (69*(1 - currencyValues[1] / powerUpManager.maxFuelCount)));
    }

    // image(uiScreen3,60,60);
    // fill(79,0,0);
    // text("DEATHS :" + int(currencyValues[3]),72.5,89);
    // fill(255,0,0);
    // text("DEATHS :" + int(currencyValues[3]),72.5,85);
    // fill(255);   



    // image(uiScreen4,0,120);
    // fill(79,0,0);
    // text("TiME : " + int(currencyValues[2]/60) + ":" + int(seconds) + ":" + (int((currencyValues[2] - int(currencyValues[2]))*100)),10,149);
    // fill(255,0,0);
    // text("TiME : " + int(currencyValues[2]/60) + ":" + int(seconds) + ":" + (int((currencyValues[2] - int(currencyValues[2]))*100)),10,145);
    // fill(255);        

    int uiScreenOverlayCropPixels = constrain(int(140 * (currencyValues[4] / highS)),0,140);

    PImage cropOverlayHighscore = uiScreen2Overlay.get(0, 0, uiScreenOverlayCropPixels, 32);
    PImage cropOverlayGreen = uiScreen2OverlayGreen.get(0, 0, uiScreenOverlayCropPixels, 32);

    int uiScreenOverlayPixels = int((56+8)*(1 + currencyValues[4] / highS));

    if (currencyValues[4] < highS){
      image(uiScreen2, 56, 0);
      image(cropOverlayHighscore, 56+8, 16, uiScreenOverlayCropPixels + 56+8, 16+32);
    } else {
      image(uiScreen2Green, 56, 0);
      image(cropOverlayGreen, 56+8, 16, uiScreenOverlayCropPixels + 56+8, 16+32);
    }

    //PowerUps
    //rocketArm

    //equiped?
    if(powerUpManager.rocketArmActive){

      //on cooldown?
      if (powerUpManager.rocketArmCD){
        image(rocketArmCooldown, 56, 52);

        int rocketArmCooldownOverlayCropPixels = int(56 * (powerUpManager.rocketArmCounter / powerUpManager.rocketArmDelay));
        PImage cropOverlayRocketArm = rocketArmCooldownOverlay.get(0, 0, rocketArmCooldownOverlayCropPixels, 48);

        image(cropOverlayRocketArm, 56 + 8, 52 + 16);
      } else {
        image(rocketArmReady, 56, 52);
      }
    } else {
      image(rocketArmNotEquiped, 56, 52);
    }

    //rocketJump

    //equiped?
    if(powerUpManager.rocketJumpActive){

      //on cooldown?
      if(powerUpManager.rocketJumpCD){
        image(rocketJumpCooldown, 56 + 72, 52);

        int rocketJumpCooldownOverlayCropPixels = int(34 * (powerUpManager.rocketJumpCounter / powerUpManager.rocketJumpDelay));
        PImage cropOverlayRocketJump = rocketJumpCooldownOverlay.get(0, 0, rocketJumpCooldownOverlayCropPixels, 48);

        image(cropOverlayRocketJump, 56 + 72 + 8, 56 + 12);
      } else {
        image(rocketJumpReady, 56 + 72, 52);
      }

    } else {
      image(rocketJumpNotEquiped, 56 + 72 , 52);
    }


    popMatrix();
    pushMatrix();
    translate(width-372, -120);

    if(counter < 1)
    counter = currencyValues[3]/highscore.MAX_DEATHS;

    pushStyle();
    tint(lerp(0,79,counter),lerp(78,0,counter),0);  
    image(uiScreen3Overlay,220,127.5);  
    noTint();
    popStyle();

    image(uiScreen3,216,120);
    fill(lerp(0, 79, counter),lerp(79, 0, counter),0);
    text("DEATHS :" + int(currencyValues[3]),226,149);
    fill(lerp(0, 255, counter),lerp(255, 0, counter),0);
    text("DEATHS :" + int(currencyValues[3]),226,145);
    fill(255);   

    if(maxTime < 1)
      maxTime = currencyValues[2]/highscore.MAX_TIME;

    pushStyle();
    tint(lerp(0,79,maxTime),lerp(78,0,maxTime),0);  
    image(uiScreen4Overlay,6,127.5); 
    noTint(); 
    popStyle();

    image(uiScreen4,0,120);
    fill(lerp(0, 79, maxTime),lerp(79, 0, maxTime),0);
    text("TiME : " + floor(currencyValues[2]/60) + ":" + int(seconds) + ":" + (int((currencyValues[2] - int(currencyValues[2]))*100)),10,149);
    fill(lerp(0, 255, maxTime),lerp(255, 0, maxTime),0);
    text("TiME : " + floor(currencyValues[2]/60) + ":" + int(seconds) + ":" + (int((currencyValues[2] - int(currencyValues[2]))*100)),10,145);
    fill(255);        

    popMatrix();
    textSize(28);
    textFont(font);    
    imageMode(CENTER);
    textAlign(CENTER,CENTER);
  }

  void resetValues()
  {
    currencyValues[0] = 0f;
    currencyValues[1] = 0f;
    currencyValues[4] = 0f;
    highS = highscore.getHighscore(currentLevel-1);    
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
