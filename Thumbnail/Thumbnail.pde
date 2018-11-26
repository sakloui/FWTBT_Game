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

PImage[] basicEnemy;

int currentLevel = 1;
int maxLevels = 6;

void setup()
{
	size(1280,720,P2D);
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
	saveFrame("Data/thumbnail-####.png");	
	if(currentLevel == maxLevels)
		exit();	
	currentLevel++;
}