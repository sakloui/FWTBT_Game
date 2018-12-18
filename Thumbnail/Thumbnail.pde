BoxManager boxManager;

PImage map;
PImage foregroundImage;

PImage biskitGames;

PImage background;

PImage tileBox;
PImage tileSteelPillar;
PImage tileSmallPlatformTopRight;
PImage tileSmallPlatformPillarRight;
PImage tileSmallPlatformTopLeft;
PImage tileSmallPlatformPillarLeft;
PImage tileMiniPlatformTop;
PImage steelPlatformLeft;
PImage steelPlatformMiddle;
PImage steelPlatformRight;
PImage steelPlatformMiddle2;
PImage overgrownLeft;
PImage overgrownMiddle;
PImage overgrownRight;
PImage hookMiddle;
PImage hookTop;
PImage exitDoor;
PImage enterDoor;
PImage ladder;

PImage wireStart;
PImage wireHeel;
PImage wireHeel2;
PImage wireCompleet;
PImage wireStartBroken;
PImage wireHeelBroken;
PImage wireHeel2Broken;
PImage wireCompleetBroken;

PImage[] basicEnemy;

PImage tutorialA;
PImage tutorialD;
PImage tutorialW;
PImage tutorialDeath;
PImage tutorialLadderW;
PImage tutorialLadderS;
PImage tutorialX;
PImage tutorialZ;
PImage tutorialK;
PImage tutorialL;

int currentLevel = 1;
int maxLevels = 8;

void setup()
{
	//need to scale stuff
	size(640,360,P2D);
	rectMode(CENTER);
	imageMode(CENTER);
	extraSetup();
	noStroke();
}

void draw()
{
	boxManager = new BoxManager(currentLevel);
	image(background,width/2,height/2,background.width, height);
	boxManager.Update();
	boxManager.DrawBoxes();
	boxManager.DrawForeground();
	saveFrame("Data/thumbnail##.png");	
	if(currentLevel == maxLevels)
	{
		exit();	
	}
	else currentLevel++;
}