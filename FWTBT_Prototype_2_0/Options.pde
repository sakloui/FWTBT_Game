class Sliders
{
  
  //------Position------
  private float y;
  
  //------Object variables------
  private int selectedSlider;
  private color rgb;
  private int sliders;
  private int[] level;
  
  //------Images------
  private PImage slider;
  private PImage pointer;
  
  Sliders(int sliders)
  {
   this.sliders = sliders;
   level = new int[sliders];
   selectedSlider = 0;
   slider = loadImage("Menu/grey_slider.png");
   pointer = loadImage("Menu/grey_pointer.png");
   y = 0;
  }
  
  
  void createSlider()
  {
    y = 0;
    for(int i = 0; i < level.length;i++)
    {
      image(slider,width/2,height/2-100+y,380,10);
      image(pointer,width/2-190+(380*volume[i]/46),height/2-75+y);
      y+=75;
    }
  }
  void updateSlider()
  {
    if(input.isUp && selectedSlider > 0)
      selectedSlider--;
    if(input.isDown && selectedSlider < level.length-1)
      selectedSlider++;
    if(input.isRight && volume[selectedSlider] < 46)
    {
      click.rewind();
      click.play();      
      volume[selectedSlider]+=0.46;
    }
    if(input.isLeft && volume[selectedSlider] > 0.5)
    {
      click.rewind();
      click.play();      
      volume[selectedSlider]-=0.46;
    }
    y = 0;
    for(int i = 0; i < level.length;i++)
    {
      image(slider,width/2,height/2-100+y,380,10);
      pushMatrix();
      image(pointer,width/2-190+(380*volume[i]/46),height/2-75+y);
      fill(200);
      println((volume[i]/46)*100);
      text(floor((volume[i]/46)*100),width/2-185+(380*volume[i]/46),height/2-50+y);
      popMatrix();
      y+=75;
    }
    updateSound();
  }
  void updateSound()
  {
    //Music
    mainMusic.setGain(-40 + volume[0]);
    if(levelmusic != null)
    levelmusic.setGain(-40 + volume[0]);

    //Sound effects
    click.setGain(-40 + volume[1]);
    click2.setGain(-40 + volume[1]);
    jumpsound.setGain(-40 + volume[1]);
    walkingsound.setGain(-40 + volume[1]);
    interactionsound.setGain(-40 + volume[1]);
  }
}
  