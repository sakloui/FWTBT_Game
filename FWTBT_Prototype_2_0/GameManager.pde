class GameManager
{
  String[] currencyNames;
  float[] currencyValues;
  
  float textOffset = 30f;
  color textColor = color(0);
  
  PVector currencyPos = new PVector(5, 25);
  
  GameManager()
  {
    currencyNames = new String[5];
    currencyValues = new float[currencyNames.length];
    
    currencyNames[0] = "Bolts";
    currencyNames[1] = "Fuel";
    currencyNames[2] = "Time passed";
    currencyNames[3] = "Times died";
    currencyNames[4] = "Score";
    
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
    
  }
  
  void Draw()
  {
    pushMatrix();
    textSize(24);
    fill(textColor);
    translate(currencyPos.x, currencyPos.y);
    for(int i = 0; i < currencyNames.length; i++)
    {
      text(currencyNames[i] + ": " + currencyValues[i], 0, textOffset * i);
    }
    popMatrix();
  }
}
