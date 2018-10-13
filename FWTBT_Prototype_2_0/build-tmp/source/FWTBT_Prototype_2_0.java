import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class FWTBT_Prototype_2_0 extends PApplet {




//------Classes------
Menu menu;
Player player;
BoxManager boxManager;
//------Image stuff------
PImage map;
PImage tile;
PImage background;
//------Font stuff------
PFont font;

//------Variables------
float lastTime,deltaTime;
boolean isMenu;
int currentLevel;

int amount = 32;
float boxSize = 40;



//------Sounds------
Minim minim;
Minim minim2;
AudioPlayer click;
AudioPlayer click2;
AudioPlayer mainMusic;
//------Keys------
boolean isUp,isDown,isRight,isLeft,isSpace,isP;

public void setup()
{
  
  rectMode(CENTER);
  imageMode(CENTER);
  ellipseMode(CENTER);
  background(0);
  extraSetup();

  player= new Player();

}

public void draw()
{
  //------Time------
  deltaTime = (millis() - lastTime) / 1000; //Calculates the diffrence in time between frames
  lastTime = millis();

  //------Background Stuff------
  background(0);

  //------Gamestate------


  if(isMenu)
  {
    menu.draw();
  }
  else
  {
    if(isP){isMenu = true;mainMusic.rewind();mainMusic.play();}
    image(background,width/2,height/2);

    player.Update();
    boxManager.Update();


    //----------Draws----------
    boxManager.DrawBoxes();
    player.Draw();

  }

}


public void updateGrid()
{
  for(int i = 0; i < boxManager.rows; i++)
  {
    for(int j = 0; j < boxManager.columns; j++)
    {
      if(boxManager.boxes[i][j].collides == 9){
        boxManager.boxes[i][j].collides = 0;
      }
    }
  }
}


 public boolean SetMove(int k, boolean b)
  {
    switch(k)
    {
    case 'W':
    case UP:
      return isUp = b;
    case 'S':
    case DOWN:
      return isDown = b;
    case 'A':
    case LEFT:
      return isLeft = b;
    case 'D':
    case RIGHT:
      return isRight = b;
    case 32:
      return isSpace = b;
    case 'P':
      return isP = b;
    default:
      return b;
    }
  }

public void keyPressed()
{
  SetMove(keyCode, true);
}

public void keyReleased()
{
  SetMove(keyCode, false);
}
class Box
{
  PVector position;
  float size;
  int groundColor = color(255);
  
  float top, bottom, right, left;
  
  int collides;
  int dist = 20;
  
  Box(PVector position, float size, int collide)
  {
    this.position = position.copy();
    this.size = size;
    collides = collide;
    SetPosValues();
    if(collides == 3)player.position.set(position);
  }
  
  public void SetPosValues()
  {
    top = position.y - size/2;
    bottom = top + size;
    right = position.x + size/2;
    left = right - size;
  }
  
  public void CheckCollision()
  {
    if(position.x + size/2 > player.position.x - player.playerWidth/2 && 
       position.x - size/2 < player.position.x + player.playerWidth/2 && 
       position.y + size/2 > player.position.y - player.playerHeight/2 &&
       position.y - size/2 < player.position.y + player.playerHeight/2)
       {
         
         player.GetCollisionDirection(this);
       }

  }
  public void CheckCollisionInvis()
  {
    if(position.x + size/2 > player.position.x - player.playerWidth/2 && 
       position.x - size/2 < player.position.x + player.playerWidth/2 && 
       position.y + size/2 > player.position.y - player.playerHeight/2 &&
       position.y - size/2 < player.position.y + player.playerHeight/2)
       {
         if(collides == 6){
         // println("oh");
         collides = 0;
         }
         if(collides == 8){
           updateGrid();
         }
       }

  }  
  
  public void Draw()
  {
    if (collides != 0)
    {
      pushMatrix();   
      //if(collides == 0)
      //  fill(groundColor);
      if(collides == 2)
        fill(255, 0, 0);
      if(collides == 3)
        fill(0, 255, 0); 
      if(collides == 4)
        fill(255, 255, 0); 
      if(collides == 5)
        fill(0, 0, 255);  
      if(collides == 7)
        fill(150,150,150);
      if(collides == 8){
        fill(255,255,100);
        CheckCollisionInvis();
      }
      if(collides == 9)
        fill(0,0,255);
      stroke(0);
      strokeWeight(2);
      translate(position.x, position.y);
      noStroke();
      rect(0, 0, size, size);
      if(collides == 1)
        image(tile,0,0, size, size);
      if(collides == 6){
        image(tile,0,0, size, size); 
        CheckCollisionInvis();
      }
      popMatrix();
    }
    if((collides == 2 || collides == 5 || collides == 9) && dist(player.position.x,player.position.y,position.x,position.y) <= dist)
    {
      menu.menuState = 0;
      menu.createMainMenu();
      menu.currentSel = 0;
      menu.button[0].selected = true;
      menu.button[0].update();
      isMenu = true;
      mainMusic.rewind();
      mainMusic.play();
    }
    if(collides == 4 && dist(player.position.x,player.position.y,position.x,position.y) <= dist)
    {
      currentLevel++;
      boxManager = new BoxManager(currentLevel);
      menu.level.selectedLevel++;
      
    }
  }
}
class BoxManager
{
  int amount = 32;
  float boxSize = 40;
  int rows = 32;
  int columns = 18;
  Box[][] boxes = new Box[rows][columns];

  ArrayList<Box> over = new ArrayList<Box>();
  ArrayList<Box> surrounding = new ArrayList<Box>();
  Box bottomBox;

  int[] xTile = new int[6];
  int[] yTile = new int[6];
  int xBottom, yBottom;

  BoxManager(int level)
  {
    map = loadImage("level"+level+".png");
    
    if(map == null)
    {
      menu.level.selectedLevel--;
      isMenu = true;
      mainMusic.rewind();
      mainMusic.play();
      return;
    }
    rows = map.width;
    columns = map.height;    
  
    boxes = new Box[rows][columns];
    if(rows > 32){
      boxSize = 40/(map.width/32);
      player.playerWidth = 40/(map.width/32);
      player.playerHeight = 60/(map.height/18);
      player.jumpVel = 15f/(map.height/18);
      player.SetupSprites();
    }
    else 
    {
      boxSize = 40;
      player.playerWidth = 40;
      player.playerHeight = 60;  
      player.jumpVel = 10f; 
      player.SetupSprites();
    }    
    //select the boxes that the player collides with 
    PlaceCollisionBoxes();
  }

  public void PlaceCollisionBoxes()
  {

        
        
    for(int i = 0; i < rows; i++)
      {
        for(int j = 0; j < columns; j++)
        {
          int coll = 0;
          int p = i + (j * rows);
          if(map.pixels[p] == color(0,0,0)){
            coll = 1; 
          }
          if(map.pixels[p] == color(255,100,0)){
            coll = 2; 
          }
          if(map.pixels[p] == color(0,255,0)){
            coll = 3; 
          }      
          if(map.pixels[p] == color(255,255,0)){
            coll = 4; 
          }   
          if(map.pixels[p] == color(0,0,255)){
            coll = 5; 
          }      
          if(map.pixels[p] == color(0,160,255)){
            coll = 6; 
          }      
          if(map.pixels[p] == color(150,150,150)){
            coll = 7; 
          }
          if(map.pixels[p] == color(255,255,100)){
            coll = 8;
          }
          if(map.pixels[p] == color(0,0,100)){
            coll = 9;
          }      
          boxes[i][j] = new Box(new PVector(boxSize/2 + boxSize*i, boxSize/2 + boxSize*j), boxSize, coll);
          if(rows > 32)boxes[i][j].dist = 30/(rows/32);
          
        }
      } 
  }

  public void Update()
  {
    over = new ArrayList<Box>();
    surrounding = new ArrayList<Box>();

    CalculateCurrentTiles();
    SetOverCells();
    SetSurroundingCells();
    SetGridColor();
    CheckCollisions();
  }

  public void CalculateCurrentTiles()
  {
    //get the tiles where the corners of the player are located in
    float xPercentage, yPercentage;
    for (int i = 0; i < player.corners.length; i++)
    {
      xPercentage = player.corners[i].x / width * 100;
      xTile[i] = floor(rows / 100f * xPercentage);  
      yPercentage = player.corners[i].y / height * 100;
      yTile[i] = floor(columns / 100f * yPercentage);
    }
    xPercentage = player.playerBottom.x / width * 100;
    xBottom = floor(rows / 100f * xPercentage);  
    yPercentage = player.playerBottom.y / height * 100;
    yBottom = floor(columns / 100f * yPercentage);    
  }

  public void SetOverCells()
  {
    for (int i = 0; i < 6; i++)
    {
      if (xTile[i] >= 32 || xTile[i] <= 0);
      else if (yTile[i] >= 18 || yTile[i] <= 0);
      else
      {
        Box box = boxes[xTile[i]][yTile[i]];

        if (!over.contains(box))
        {
          over.add(box);
        }
      }
    }    
  }

  public void SetSurroundingCells()
  {
    for (int i = 0; i < 6; i++)
    {
      //if cell is within the array of cells
      if (xTile[i] >= rows || xTile[i] + 1 >= rows || xTile[i] <= 0 || xTile[i] - 1 < 0);
      else if (yTile[i] >= columns || yTile[i] + 1 >= columns || yTile[i] <= 0 || yTile[i] - 1 < 0);
      else
      {
        Box boxTop = boxes[xTile[i]][yTile[i]-1];
        Box boxBottom = boxes[xTile[i]][yTile[i]+1];
        Box boxRight = boxes[xTile[i]-1][yTile[i]];
        Box boxLeft = boxes[xTile[i]+1][yTile[i]]; 
        Box boxTopLeft = boxes[xTile[i]-1][yTile[i]-1];
        Box boxTopRight = boxes[xTile[i]+1][yTile[i]-1];
        Box boxBottomLeft = boxes[xTile[i]-1][yTile[i]+1];
        Box boxBottomRight = boxes[xTile[i]+1][yTile[i]+1];

        if (!surrounding.contains(boxTop) && !over.contains(boxTop))
        {
          surrounding.add(boxTop);
        }
        if (!surrounding.contains(boxBottom) && !over.contains(boxBottom))
        {
          surrounding.add(boxBottom);
        }
        if (!surrounding.contains(boxRight) && !over.contains(boxRight))
        {
          surrounding.add(boxRight);
        }
        if (!surrounding.contains(boxLeft) && !over.contains(boxLeft))
        {
          surrounding.add(boxLeft);
        }

        if (!surrounding.contains(boxTopLeft) && !over.contains(boxTopLeft))
        {
          surrounding.add(boxTopLeft);
        }
        if (!surrounding.contains(boxTopRight) && !over.contains(boxTopRight))
        {
          surrounding.add(boxTopRight);
        }
        if (!surrounding.contains(boxBottomLeft) && !over.contains(boxBottomLeft))
        {
          surrounding.add(boxBottomLeft);
        }
        if (!surrounding.contains(boxBottomRight) && !over.contains(boxBottomRight))
        {
          surrounding.add(boxBottomRight);
        }
      }
    }
    if (xBottom + 1 >= rows || xBottom - 1 < 0);
    else if (yBottom + 1 >= columns || yBottom - 1 < 0);
    else
      bottomBox = boxes[xBottom][yBottom];    
  }

  public void SetGridColor()
  {   
    ////background cells
    //for (int i = 0; i < rows; i++)
    //{
    //  for (int j = 0; j < columns; j++)
    //  {
    //    if(boxes[i][j].collides == 0)
    //    boxes[i][j].collides = 50;
    //  }
    //}

    ////over cells
    //for (int i = 0; i < over.size(); i++)
    //{
    //  if(over.get(i).collides == 50){
    //  over.get(i).collides = 0;
    //  over.get(i).groundColor = color(255);
    //}
    //}
  }

  public void CheckCollisions()
  {
    //check for collisions on the surrounding cells that the player can collide with
    for (int i = 0; i < surrounding.size(); i++)
    {
      //set the surrounding cells color
      surrounding.get(i).groundColor = color(150, 0, 150);
      //check for collisions
      if (surrounding.get(i).collides == 1)
        surrounding.get(i).CheckCollision();
    }
  }

  public void DrawBoxes()
  {
    for (int i = 0; i < rows; i++)
    {
      for (int j = 0; j < columns; j++)
      {
        boxes[i][j].Draw();
      }
    }

    for (int i = 0; i < surrounding.size(); i++)
    {
      surrounding.get(i).Draw();
    }
  }
}
class Buttons
{
  //------Position------
  private float x;
  private float y;
  private float r;
  private float rv;
  //------Object variables------
  String text;
  String type;
  boolean selected;
  boolean selectedLevel;
  
  //------Images-------
  private PImage buttonUp;
  private PImage buttonDown;
  
  //------Color------
  private int rgb;
  
  Buttons(float x, float y, String text, String type ,int rgb)
  {
   this.x = x;
   this.y = y;
   this.text = text;
   this.rgb = rgb;
   this.type = type;
   buttonUp = loadImage("Menu/grey_button_up.png");
   buttonDown = loadImage("Menu/grey_button_down.png");
   r = 0;
   rv = 0.05f;
  }
  
  
  public void createButton()
  {
    pushMatrix();
    fill(rgb);
    image(buttonUp,x,y);
    text(text,x,y);
    popMatrix();
  }
  public void update()
  {
    if(type == "button")
    {
      if(selected)
      {
        pushMatrix();
        fill(rgb);
        image(buttonDown,x,y);
        text(text,x,y+2);
        popMatrix();
      }
      else
      {
        pushMatrix();
        fill(rgb);
        image(buttonUp,x,y);
        text(text,x,y);
        popMatrix();
      }
    }
    if(type == "text")
    {
      pushMatrix();
      textSize(28+mainMusic.left.get(1)*10);
      translate(x,y+2);
      rotate(radians(r));
      text(text,0,0);
      popMatrix();
      textSize(28);
      if(r > 5)rv = -rv;
      if(r < -5)rv = -rv;
      r += rv;
    }
  }
}
public class IdleState extends State
{
   PVector velocity;
  float animationSpeed;
  float currentFrame;
  int currentDirection;
  final int LEFT = 0, RIGHT = 1;
  
  public void OnStateEnter()
  {
    
    animationSpeed = 0.3f;
    if(player == null)
    {
      currentDirection = 1;
    }
    else
    {
      currentDirection = player.currentDirection;
    }
  }
   public void OnTick()
  {
     currentFrame = (currentFrame + animationSpeed) % 10;
    velocity = player.velocity.copy();
    if(velocity.x == 0 && velocity.y == 0) return;
    
    if(velocity.y != 0)
    {
      player.SetState(new JumpState());
    }
    else if(velocity.x != 0)
    {
      player.SetState(new RunState());
    }
    
  }
   public void OnDraw()
  {
    
    pushMatrix();
    translate(player.position.x, player.position.y);
    if(currentDirection == RIGHT)
    {
      image(player.idle[PApplet.parseInt(currentFrame)], 0, 0);
    }
    else if(currentDirection == LEFT)
    {
      pushMatrix();
      scale(-1.0f, 1.0f);
      image(player.idle[PApplet.parseInt(currentFrame)],0 ,0);
      popMatrix();
    }
    popMatrix();
  }
   public void OnStateExit()
   {
     
   }
 }   
public class JumpState extends State
{
 PVector velocity;
  float animationSpeed;
  float currentFrame;
  int currentDirection;
  final int LEFT = 0, RIGHT = 1, UP = 2, DOWN = 3;
  
  public void OnStateEnter()
  {
    
    animationSpeed = 0.1f;
    if(player == null)
    {
      currentDirection = 1;
    }
    else
    {
      currentDirection = player.currentDirection;
    }
  }
   public void OnTick()
  {
    currentFrame = (currentFrame + animationSpeed) % 10;
    velocity = player.velocity.copy();
    
    if(velocity.x == 0 && velocity.y == 0)
    {
      player.SetState(new IdleState());
    }
    else if(velocity.y == 0 && velocity.x != 0)
    {
      player.SetState(new RunState());
    }
    if(velocity.x > 0)
    {
      currentDirection = RIGHT;
    }
    else if(velocity.x < 0)
    {
      currentDirection = LEFT;
    }
    if(velocity.y < 0)
    {
      //currentDirection = UP;
    }
    else if(velocity.y > 0)
    {
      //currentDirection = DOWN;
    }
   }
   public void OnDraw()
  {
    
    pushMatrix();
    translate(player.position.x, player.position.y);
    if(currentDirection == RIGHT)
    {
      image(player.jump[PApplet.parseInt(currentFrame)], 0, 0);
    }
    else if(currentDirection == LEFT)
    {
       pushMatrix();
       scale(-1.0f, 1.0f);
       image(player.jump[PApplet.parseInt(currentFrame)],0 ,0);
       popMatrix();
    }
    popMatrix();
  }
   public void OnStateExit()
  {
    
    player.currentDirection = currentDirection;
  }
}
class Levels
{
  
  //------Position------
  private float x;
  private float y;
  
  //------Object variables------
  private String text;
  private String type;
  private int selectedLevel;
  private int rgb;
  private int levels;
  private int[] level;
  
  //------Images------
  private PImage greyPanel;
  private PImage map2;
  private PImage map3;
  
  Levels(int levels,int rgb)
  {
   this.rgb = rgb;
   this.levels = levels;
   level = new int[levels];
   selectedLevel = 0;
   greyPanel = loadImage("grey_panel.png");
  }
  
  
  public void createLevel()
  {
    for(int i = 0; i < level.length;i++)
    {
      image(greyPanel,width/2,height/2);
      
    }
  }
  public void updateLevel()
  {
    if(isRight && selectedLevel < levels-1)
    {
      click.rewind();
      click.play();      
      selectedLevel++;
      isRight = false;
    }
    if(isLeft && selectedLevel > 0)
    {
      click.rewind();
      click.play();      
      selectedLevel--;
      isLeft = false;
    }
    for(int i = 0; i < level.length;i++)
    {
      if(i == selectedLevel)
      {
      pushMatrix();
      image(greyPanel,width/2,height/2,300,400);
      map = loadImage("level" + (selectedLevel + 1) + ".png");
      image(map,width/2,height/2,200,150);
      text("level " + (i+1),width/2,height/2);
      popMatrix();
      }
      if(i == selectedLevel + 1)
      {
      pushMatrix();
      image(greyPanel,width/4*3,height/2,150,200);
      map2 = loadImage("level" + (selectedLevel + 2) + ".png");
      image(map2,width/4*3,height/2,100,75);      
      textSize(16);
      text("level " + (i+1),width/4*3,height/2);
      textSize(28);
      popMatrix();
      }
      if(i == selectedLevel - 1)
      {
      pushMatrix();
      image(greyPanel,width/4,height/2,150,200);
      if(selectedLevel != 0)
      {
      map3 = loadImage("level" + (selectedLevel) + ".png");
      image(map3,width/4,height/2,100,75);   
      }
      textSize(16);
      text("level " + (i+1),width/4,height/2);
      textSize(28);
      popMatrix();
      }
    }
  }
  
}
class Menu
{

  //------Menu------
  private int menuState;
  //------Classes------
  private Buttons[] button;
  private Levels level;
  private Options options;
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
  
  public void update()
  {
    
    
  }
  
  public void draw()
  {
    updateMenu();
    if(menuState == 1)level.updateLevel();
  }
  public void createMainMenu()
  {
   
    for(int i = 0; i < button.length;i++)
    {
      button[i] = null;
    }
    level = null;
    options = null;
    button[0] = new Buttons(width/2,height/2-75,"Play","button",74);
    button[0].createButton();
    button[1] = new Buttons(width/2,height/2,"Options","button",74);
    button[1].createButton();
    button[2] = new Buttons(width/2,height/2+75,"Exit","button",74);
    button[2].createButton();    
    button[4] = new Buttons(width/2,height/2-200,"For whom the bell tolls","text",74);
    button[4].createButton();
  }
  public void createOptions()
  {
    for(int i = 0; i < button.length;i++)
    {
      button[i] = null;
    }

    level = null;
    options = null;

    options.createOptions();
    button[0] = new Buttons(width/2,height/2+75,"Back","button",74);
    button[0].createButton();


  }
  public void createLevelSelect()
  {
    for(int i = 0; i < button.length;i++)
    {
      button[i] = null;
    
    }
    level = null;
    options = null;

    level = new Levels(8 ,74);
    level.createLevel();
    button[0] = new Buttons(width/2,height-125,"Select","button",74);
    button[0].createButton();
    button[1] = new Buttons(width/2,height-50,"Back","button",74);
    button[1].createButton();  
  }
  public void updateMenu()
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
        if(button[currentSel].text == "Select"){currentLevel = level.selectedLevel+1;boxManager = new BoxManager(currentLevel);isMenu = false;mainMusic.pause();player.velocity.y = 0;}
        if(button[currentSel].text == "Options"){button[currentSel].selected = false;currentSel = 0;createOptions();button[currentSel].selected = true;return;}
        if(button[currentSel].text == "Back"){button[currentSel].selected = false;button[currentSel].selected = false;currentSel = 0;createMainMenu();button[currentSel].selected = true;menuState = 0;return;}
      }
  }
    
}
class Objects
{
  //------Position------
  private float x;
  private float y;
  
  //------Object variables------
  String text;
  boolean selected;
  
  //------Images-------
  private PImage buttonUp;
  private PImage buttonDown;
  
  //------Color------
  private int rgb;
  
  Objects(float x, float y, String text, int rgb)
  {
   this.x = x;
   this.y = y;
   this.text = text;
   this.rgb = rgb;
   buttonUp = loadImage("grey_button_up.png");
   buttonDown = loadImage("grey_button_down.png");
  }
  
  public void createButton()
  {
    pushMatrix();
    fill(rgb);
    image(buttonUp,x,y);
    text(text,x,y);
    popMatrix();
  }
  public void updateButton()
  {
    if(selected)
    {
      pushMatrix();
      fill(rgb);
      image(buttonDown,x,y);
      text(text,x,y+2);
      popMatrix();
    }
    else
    {
      pushMatrix();
      fill(rgb);
      image(buttonUp,x,y);
      text(text,x,y);
      popMatrix();
    }
        
  }
}
class Sliders
{
  
  //------Position------
  private float y;
  
  //------Object variables------
  private int selectedSlider;
  private int[] amount;
  private int rgb;
  private int sliders;
  private int[] level;
  
  //------Images------
  private PImage slider;
  private PImage pointer;
  
  Sliders(int sliders,int rgb)
  {
   this.rgb = rgb;
   this.sliders = sliders;
   level = new int[sliders];
   amount = new int[sliders];
   selectedSlider = 0;
   slider = loadImage("Menu/grey_slider.png");
   pointer = loadImage("Menu/grey_pointer.png");
   y = 0;
  }
  
  
  public void createSlider()
  {
    y = 0;
    for(int i = 0; i < level.length;i++)
    {
      amount[i] = 100;
      image(slider,width/2,height/2+y);
      y+=25;
    }
  }
  public void updateLevel()
  {
    if(isRight && amount[selectedSlider] < 100)
    {
      click.rewind();
      click.play();      
      amount[selectedSlider]++;
    }
    if(isLeft && amount[selectedSlider] > 0)
    {
      click.rewind();
      click.play();      
      amount[selectedSlider]--;
    }
    for(int i = 0; i < level.length;i++)
    {
      if(i == selectedSlider)
      {
      pushMatrix();
      image(slider,width/2,height/2+y,300,400);
      popMatrix();
      }
    }
  }
  
}
class Player
{
  //----------body----------
  int playerWidth;
  int playerHeight;
  int playerColor;

  //----------Movement----------
  PVector position;
  PVector velocity;
  float speed;
  float jumpVel;
  float gravity;
  float maxGrav;

  //----------collisions----------
  float top, bottom, right, left;
  float oldTop, oldBottom, oldRight, oldLeft;
  PVector[] corners = new PVector[6];
  PVector playerBottom;
  //topLeft, topRight, bottomLeft, bottomRight;
  boolean collidedTop, collidedBottom, collidedRight, collidedLeft;

  //----------Other----------
  int textColor = color(0);
  boolean grounded = false;
  boolean canJump = false;

  PImage sheet;
  PImage[] idle;
  PImage[] run;
  PImage[] slide;
  PImage[] jump;
  boolean inMotion;
  int currentDirection;
  float currentFrame;
  float currentRunFrame;
  float animationSpeed = 0.3f;

  State playerState;



  Player()
  {
    playerWidth = 40;
    playerHeight = 60;
    playerColor = color(155, 0, 0);

    velocity = new PVector(0, 0);
    position = new PVector(width/2, height - 100);
    speed = 150f;

    jumpVel = 5f;
    gravity = 9.81f;
    maxGrav = 20f;

    currentDirection = 1;
    
    SetupSprites();

    //set values once for the first time SetOldPos() is called
    SetNewPos();
    
    this.SetState(new IdleState());
  }

  public void SetupSprites()
  {
    idle = new PImage[10];
    String idleName;

    slide = new PImage[10];
    String slideName;

    jump = new PImage[10];
    String jumpName;

    run = new PImage[8];
    String runName;

    println(playerWidth);
    for (int i = 0; i < 10; i++)
    {
      //load idle sprites
      idleName = "Sprites/Idle (" + i + ").png";
      idle[i] = loadImage(idleName);
      idle[i].resize(playerWidth*2, 0);

      //load jump sprites
      jumpName = "Sprites/Jump (" + i + ").png";
      jump[i] = loadImage(jumpName);
      jump[i].resize(playerWidth*2, 0);
      //load slide sprites
      slideName = "Sprites/Slide (" + i + ").png";
      slide[i] = loadImage(slideName);
      slide[i].resize(playerWidth*2, 0);
    }

    for (int i = 0; i < 8; i++)
    {
      //load run sprites
      runName = "Sprites/Run (" + i + ").png";
      run[i] = loadImage(runName);
      run[i].resize(playerWidth*2, 0);
    }
  }

  public void SetOldPos()
  {
    oldTop = top;
    oldBottom = bottom;
    oldRight = right;
    oldLeft = left;
  }

  public void SetPlayerCorners()
  {
    corners[0] = new PVector(position.x - (playerWidth/2), position.y - (playerHeight/2));
    corners[1] = new PVector(position.x + (playerWidth/2), position.y - (playerHeight/2));
    corners[2] = new PVector(position.x - (playerWidth/2), position.y + (playerHeight/2));
    corners[3] = new PVector(position.x + (playerWidth/2), position.y + (playerHeight/2));
    corners[4] = new PVector(position.x + (playerWidth/2), player.position.y);
    corners[5] = new PVector(position.x - (playerWidth/2), player.position.y);

    playerBottom = new PVector(position.x, position.y + playerHeight/2);
    /*
    topLeft = new PVector(position.x - (playerWidth/2), position.y - (playerHeight/2));
    topRight = new PVector(position.x + (playerWidth/2), position.y - (playerHeight/2));
    bottomLeft = new PVector(position.x - (playerWidth/2), position.y + (playerHeight/2));
    bottomRight = new PVector(position.x + (playerWidth/2), position.y + (playerHeight/2));
    */
  }

  public void Move()
  {
    if (isRight)
    {
      velocity.x = speed * deltaTime;
    }    
    if (isLeft)
    {
      velocity.x = -speed * deltaTime;
    }

    if (!isRight && !isLeft)
    {
      velocity.x = 0;
    }

    
    if (isUp && grounded)
    {
      velocity.y = -jumpVel;
      grounded = false;
    }
    

    /*
    if (input.isUp)
    {
      velocity.y = -speed * deltaTime;
    } 
    if (input.isDown)
    {
      velocity.y = speed * deltaTime;
    } 
    */
    if (grounded)
    {
      velocity.y = 0;
    }
  }

  public void ApplyGravity()
  {
    if (!grounded)
    {
      velocity.y += gravity * deltaTime;
      if (velocity.y > maxGrav)
        velocity.y = maxGrav;
    }
  }

  public void SetNewPos()
  {
    top = position.y - playerHeight/2;
    bottom = top + playerHeight;
    right = position.x + playerWidth/2;
    left = right - playerWidth;
    if(top != oldTop)
    {
      //ResolveCollision();
    }
  }
  
  public void SetDirection()
  {
    
    inMotion = true;

    if (velocity.x == 0 && velocity.y == 0)
      inMotion = false;
    else if (velocity.x > 0 && velocity.y == 0)
      currentDirection = RIGHT;
    else if (velocity.x < 0 && velocity.y == 0)
      currentDirection = LEFT;
    else if (velocity.x == 0 && velocity.y < 0)
      currentDirection = TOP;
    else if (velocity.x == 0 && velocity.y > 0)
      currentDirection = DOWN;
  }

  public void Update()
  {
    SetOldPos();
    SetPlayerCorners();
    Move();
    playerState.OnTick();
    ApplyGravity();
    //SetDirection();
    position.add(velocity);
    SetNewPos();
    if(bottom != oldBottom || right != oldRight)
    {
      ResolveCollision(boxManager.bottomBox); 
    }
  }

  public void GetCollisionDirection(Box box)
  {
    if (oldBottom < box.top && // was not colliding
      bottom >= box.top)// now is colliding
    {
      collidedBottom = true;
      ResolveCollision(box);
    }
    if (oldTop >= box.bottom && // was not colliding
      top < box.bottom)// now is colliding
    {
      collidedTop = true;
      ResolveCollision(box);
    }
    if (oldLeft >= box.right && // was not colliding
      left < box.right)// now is colliding
    {
      collidedLeft = true;
      ResolveCollision(box);
    }
    if (oldRight < box.left && // was not colliding
      right >= box.left) // now is colliding
    {
      collidedRight = true;
      ResolveCollision(box);
    }
  }

  public void ResolveCollision(Box box)
  {
    if (collidedTop)
    {
      position.y = box.position.y + box.size/2 + playerHeight/2 + 0.1f;
      velocity.y = 0;
      collidedTop = false;
    }
    if (collidedBottom)
    {
      position.y = box.position.y - box.size/2 - playerHeight/2 - 0.1f;
      velocity.y = 0;
      grounded = true;
      collidedBottom = false;
    } else
      grounded = false;
    if (collidedRight)
    {
      position.x = box.position.x - box.size/2 - playerWidth/2 - 0.1f;
      velocity.x = 0;
      collidedRight = false;
    }
    if (collidedLeft)
    {
      position.x = box.position.x + box.size/2 + playerWidth/2 + 0.1f;
      velocity.x = 0;
      collidedLeft = false;
    }
    SetNewPos();
  }

  public void Draw()
  {
    pushMatrix();
    textSize(20);
    fill(textColor);
    translate(100, 100);
    text("grounded: " + grounded, 0, 0);
    popMatrix();

    pushMatrix();
    fill(playerColor);
    noStroke();
    playerState.OnDraw();
      
    //rect(0, 0, playerWidth, playerHeight);
    popMatrix();
  }

  public void SetState(State state)
  {
    if (playerState != null)
    {
      playerState.OnStateExit();
    }

    playerState = state;

    if (playerState != null)
    {
      playerState.OnStateEnter();
    }
  }
}
public class RunState extends State
{
   PVector velocity;
  float animationSpeed;
  float currentFrame;
  int currentDirection;
  final int LEFT = 0, RIGHT = 1;
  
  public void OnStateEnter()
  {
    
    animationSpeed = 0.4f;
    if(player == null)
    {
      currentDirection = 1;
    }
    else
    {
      currentDirection = player.currentDirection;
    }
  }
   public void OnTick()
  {
    velocity = player.velocity.copy();
    currentFrame = (currentFrame + animationSpeed) % 8;    
    
    if(velocity.x == 0)
    {
      player.SetState(new IdleState());
    }
    if(velocity.y != 0)
    {
      player.SetState(new JumpState());
    }
    if(velocity.x > 0)
    {
      currentDirection = RIGHT;
    }
    else if(velocity.x < 0)
    {
      currentDirection = LEFT;
    }
  }
   public void OnDraw()
  {
    
    pushMatrix();
    translate(player.position.x, player.position.y);
    if(currentDirection == RIGHT)
    {
      image(player.run[PApplet.parseInt(currentFrame)], 0, 0);
    }
    else if(currentDirection == LEFT)
    {
       pushMatrix();
       scale(-1.0f, 1.0f);
       image(player.run[PApplet.parseInt(currentFrame)],0 ,0);
       popMatrix();
    }
    popMatrix();
  }
   public void OnStateExit()
  {
    
    player.currentDirection = currentDirection;
  }
}
public void extraSetup()
{
  //------Classes------
  menu = new Menu();
  //player = new Player(50);
  //------Image stuff------
  tile = loadImage("Floor2.png");
  background = loadImage("background.png");
  //------Font stuff------
  font = createFont("kenvector_future.ttf", 28);
  textFont(font);
  textMode(SHAPE);
  textAlign(CENTER,CENTER);
  //------Variables------
  isMenu = true;
  
  //------Sounds------
  minim = new Minim(this);
  minim2 = new Minim(this);
  click = minim.loadFile("click.mp3");
  click.setGain(10);
  click2 = minim.loadFile("click2.mp3");
  if(month() == 10 && day() == 31)
  mainMusic = minim2.loadFile("mainMusic3.mp3");
  else {
    int rand = round(random(1,2));
    mainMusic = minim2.loadFile("mainMusic"+ rand +".mp3");
  }
  mainMusic.loop();
}
public abstract class State
{
  public void OnStateEnter(){}
  
  public abstract void OnTick();
  
  public abstract void OnDraw();
  
  public void OnStateExit(){}
  
}
  public void settings() {  size(1280,720,P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--hide-stop", "FWTBT_Prototype_2_0" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
