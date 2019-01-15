class Introscherm
{
	float animationSpeed = 0.3f;
	float currentImage;
	boolean playIntroAnimation;

	void updateIntro()
	{
		if(input.isSpace)
		{
			playIntroAnimation = true;
		}
	}

	void drawIntro()
	{
		if(playIntroAnimation == false)
		{
			currentImage = (currentImage + animationSpeed) % introIdleScreen.length;
			image(introIdleScreen[int(currentImage)], 525, 575, 2048, 1152);
		}
		else 
		{
			currentImage = (currentImage + animationSpeed) % intro.length;
			image(intro[int(currentImage)], 525, 575, 2048, 1152);
			if(currentImage >= intro.length - 1 - animationSpeed)
			{
				displayIntro = false;
				menu.createMainMenu();
			}
		}
	}
}