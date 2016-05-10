//declarations

float santaX = 70;
float santaY = 450;

float sleighWidth = 170;
float sleighHeight = 100;
float sackSize = 150;
float bladeHeight = 5;
float spokeWidth = 5;

float roofX = 10;
float roofY = 700;
float roofHeight = 100;
float roofSize;

float chimneyY = 600;
float chimneyHeight = 100;
float chimneyWidth = 80;

float chimneyX;

float snowAmount = 500;
float[] snowX = new float [(int)snowAmount];
float[] snowY = new float [(int)snowAmount];
int[] snowSize = new int[(int)snowAmount];
float minSnowSize = 1;
float maxSnowSize = 10;

color c;
float boxSize = 50;
float boxX = santaX;
float boxY = santaY;
float ribbonWidth = boxSize;
float ribbonHeight = 10;
float ribbonSize = 20;

boolean presentFalling;

float lightSize = 30;
float lightY = 750;
float lightX = 0;

float outside;

int score = 0;
int time = 600;

//sound
import ddf.minim.*;
Minim minim;
AudioPlayer song;
AudioSnippet ho;
AudioPlayer santaSong;
AudioPlayer blueXmas;

PFont xmas;

boolean boundingBox()
{
  if (boxX + boxSize < chimneyX)
  {
    return true;
  }

  if (boxX > chimneyX + chimneyWidth)
  {
    return true;
  }

  if (boxY + boxSize < chimneyY)
  {
    return true;
  }

  if (boxY > chimneyY + chimneyHeight)
  {
    return true;
  }

  return false;
}


void drawSleigh(float santaX, float santaY)
{
  //sack
  stroke(54, 36, 18);
  strokeWeight(3);
  fill(77, 52, 26);
  ellipse(santaX, santaY - sleighHeight / 2, sackSize, sackSize);

  //santa
  fill(129, 10, 10);
  stroke(130, 10, 17);
  ellipse(santaX + sleighWidth / 1.5, santaY, 100, 100);//body
  fill(238, 204, 152);
  stroke(223, 189, 137);
  ellipse(santaX + sleighWidth / 1.5, santaY - 70, 60, 60); // head
  fill(129, 10, 10);
  stroke(129, 10, 10);
  ellipse(santaX + sleighWidth / 1.2, santaY - 60, 15, 15); //nose
  fill(0);
  noStroke();
  ellipse(santaX + sleighWidth / 1.5, santaY - 70, 20, 20);//eye
  fill(255);
  ellipse(santaX + sleighWidth / 1.55, santaY - 68, 10, 10);//eye
  ellipse(santaX + sleighWidth / 1.45, santaY - 73, 10, 10);//eye
  fill(129, 10, 10);
  arc(santaX + sleighWidth / 1.45, santaY - 50, 20, 20, 0, PI+QUARTER_PI, CHORD);//mouth

  //beard
  fill(255);
  ellipse(santaX + sleighWidth / 1.3, santaY - 50, 15, 15);
  ellipse(santaX + sleighWidth / 1.4, santaY - 55, 10, 10);
  ellipse(santaX + sleighWidth / 1.5, santaY - 55, 10, 10);
  ellipse(santaX + sleighWidth / 1.4, santaY - 30, 25, 25);
  ellipse(santaX + sleighWidth / 1.6, santaY - 30, 25, 25);
  ellipse(santaX + sleighWidth / 1.7, santaY - 40, 25, 25);
  ellipse(santaX + sleighWidth / 1.75, santaY - 50, 25, 25);


  fill(0);
  stroke(50);
  ellipse(santaX + sleighWidth, santaY - 20, 30, 30);

  //hat
  fill(129, 10, 10);
  stroke(129, 10, 10);
  triangle(santaX + santaX * 0.45, santaY - 90, santaX + santaX * 0.25, santaY - 90, santaX  + santaX * 0.33, santaY - 120);
  triangle(santaX  + santaX * 0.33, santaY - 120, santaX + santaX * 0.33, santaY - 110, santaX + santaX * 0.22, santaY - 110);
  fill(255);
  stroke(200);
  ellipse(santaX + santaX * 0.35, santaY - 90, 65, 20);
  ellipse(santaX + santaX * 0.22, santaY - 110, 20, 20);

  //sleigh
  stroke(106, 71, 17); 
  strokeWeight(10);
  fill(129, 10, 10);
  rect(santaX - sleighWidth / 2, santaY - sleighHeight / 2, sleighWidth, sleighHeight);//main sleigh
  rect(santaX + sleighWidth / 2, santaY, sleighWidth / 2, sleighHeight /2);//front seat
  stroke(150, 150, 150);
  fill(150, 150, 150);
  strokeWeight(5);
  rect(santaX - sleighWidth / 2, santaY + sleighHeight / 1.5f, sleighWidth + sleighWidth / 2, bladeHeight );//sleigh blade
  rect(santaX - sleighWidth / 4, santaY + sleighHeight / 2, spokeWidth, bladeHeight * 3);//spoke 1
  rect(santaX + sleighWidth / 2, santaY + sleighHeight / 2, spokeWidth, bladeHeight * 3);//spoke 2
}

void setup()
{
  size (1280, 800);
  background(0);
  smooth();

  santaX = width / 4;
  roofSize = 700;
  c = color(random(0, 255), random(0, 255), random(0, 255));

  for (int i = 0; i < 100; i ++)
  {
    snowX[i] = random(0, width);
    snowY[i] = random(0, height);
  }

  //sounds
  minim = new Minim(this);

  song = minim.loadFile("Bells1.mp3");
  song.play();
  song.loop();

  ho = minim.loadSnippet("hohoho.wav");

  santaSong = minim.loadFile("SantaSong.mp3");

  blueXmas = minim.loadFile("BlueXmas.mp3");

  xmas = loadFont("PWJoyeuxNoel-48.vlw");
}


void draw()
{
  background(0);

  stroke(255);
  fill(255);

  //SLEIGH
  drawSleigh(santaX, santaY);

  //SNOW
  for (int i = 0; i < snowX.length; i ++)
  {
    noStroke();
    fill(255);
    ellipse(snowX[i], snowY[i], 10, 10);
    snowY[i] += 10;
    snowX[i] -= 5; 
    if (snowY[i] > height)
    {
      snowY[i] = 0;
    }
    if (snowX[i] < 0)
    {
      snowX[i] = width;
    }
  }

  //SANTA CONTROLS
  if (keyPressed)
  {

    if (key == 'w' && santaY >= 150)
    {
      santaY -= 10;
    }

    if (key == 's' && santaY <= 450)
    {
      santaY += 10;
    }
  }


  //PRESENT DROP CONTROLS
  if (keyPressed)
  {

    if (key == ' ' && !presentFalling)
    {
      fill(c);
      boxX = santaX;
      boxY = santaY;

      presentFalling = true;

      //HOHOHO
      ho.play();
    }
  }


  //PRESENTS
  if (presentFalling)
  {
    fill(c);
    rect(boxX, boxY, boxSize, boxSize);
    fill(129, 10, 10);
    rect(boxX, boxY + 20, ribbonWidth, ribbonHeight);
    rect(boxX + 20, boxY, ribbonHeight, ribbonWidth);
    ellipse(boxX + boxSize / 2, boxY, ribbonSize, ribbonSize);
    ellipse(boxX + boxSize / 4, boxY, ribbonSize, ribbonSize);
    ellipse(boxX + boxSize - boxSize / 4, boxY, ribbonSize, ribbonSize);
    boxY += 10;
    boxX -= 5;


    if (boxY > roofY)
    {
      presentFalling = false;
    }
  }


  //ROOFS
  for (int i = 0; i < 10000; i += 1200)
  {
    chimneyX = roofX + i + chimneyWidth;
    fill(255);
    rect(roofX + i, roofY, roofSize, roofHeight);
    fill(129, 10, 10);
    rect(chimneyX, chimneyY, chimneyWidth, chimneyHeight);  


    //lights
    for (int l = 0; l < 700; l +=30)
    {
      fill( random(255), random(255), random(255), random(255));
      ellipse(roofX + i + l, lightY, lightSize, lightSize);
    }

    roofX -= 2;

    // SCORE ADD
    if (presentFalling && !boundingBox())
    {
      println("collides !!!");
      score ++;
      presentFalling = false;
      
      //HOHOHO
      ho.play();
    }
  }

  //COUNTDOWN
  time --;

  //game text
  textSize(32);
  fill(255);
  text("Happy children: " + score, 30, 50);

  textSize(32);
  fill(255);
  text("Santa's time: " + time, 30, 100);

  //GAMEOVER SCREEN
  if (time <= 0 && score <= 4)
  {
    fill(0);
    rect(0, 0, width, height);

    textSize(32);
    fill(255);
    text("Game over for Santa", 450, height / 2);

    //sad music
    song.close();
    blueXmas.play();

    //rain
    for (int i = 0; i < snowX.length; i ++)
    {
      noStroke();
      fill(0, 0, 255);
      ellipse(snowX[i], snowY[i], 5, 5);
      snowY[i] += 20;
      snowX[i] ++; 
      if (snowY[i] > height)
      {
        snowY[i] = 0;
      }
      if (snowX[i] < 0)
      {
        snowX[i] = width;
      }
    }
  }



  //WIN SCREEN
  if (time <= 0 && score >= 5)
  {
    fill(0);
    rect(0, 0, width, height);

    textSize(100);
    fill(255);
    text("Santa Wins!", 280, height / 2);

    textFont(xmas, 100);
    fill(random(0, 255), random(0, 255), 0) ;
    text("Happy Holidays Klavs!", 50, height / 2 + 100);
    santaSong.play();
    song.close();

    for (int i = 0; i < snowX.length; i ++)
    {
      noStroke();
      fill(255);
      ellipse(snowX[i], snowY[i], 10, 10);
      snowY[i] += 10;
      snowX[i] -= 5; 
      if (snowY[i] > height)
      {
        snowY[i] = 0;
      }
      if (snowX[i] < 0)
      {
        snowX[i] = width;
      }
    }
  }
}

