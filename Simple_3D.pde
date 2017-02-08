import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
import peasy.test.*;

PeasyCam cam;

int ballX, ballY, ballZ;
boolean released, mouseIsPressed, dirSet, fullRelease;
boolean wPress, sPress, aPress, dPress;
int x1, y1, x2, y2;
PVector dir = new PVector(0, 0, 0);
PVector hit = new PVector(0, 0, 0);
float camZ=500, camX;
void setup()
{
  noStroke();
  fullScreen(P3D);
  camX=width/2;
}
void draw()
{
  cam = new PeasyCam(this, camX, height/2, camZ, 50);

  background(0);
  if (key==' ')
  {
    released=false;
    mouseIsPressed=false;
    dirSet=false;
    fullRelease=false;
    ballZ=0;
    dir.x=0;
    dir.y=0;
    dir.z=0;
  }
  if (released)
  {
    if (dirSet==false)
    {
      dir.x=(x1-x2);
      dir.y=(y1-y2);
      //dir.z=(y1-y2);
      dirSet=true;
    }
    ballX+=dir.x;
    ballY+=dir.y;
    ballZ+=dir.z;
    dir.y+=0.5;
    if (ballY>=height)
    {
      dir.y=(dir.y*-1)/1.2;
    }
    if (ballX>width||ballX<0)
    {
      dir.x*=-1;
    }
    if (ballY<=0)
    {
      dir.y*=-1;
    }
    if (ballZ<-6000)
    {
      //dir.z*=-1;
      dir.z=50;
      //dir.y*=-1;
      dir.x+=random(-5, 5);
    }
    if (mousePressed==false)
    {
      fullRelease=true;
    }
    float distance=dist(mouseX+(camX-width/2), mouseY, camZ-500, ballX, ballY, ballZ);
    if (mousePressed&&distance<200)
    {
      hit.x=(mouseX+(camX-width/2))-ballX;
      hit.y=mouseY-ballY;
      hit.normalize();
      dir.x-=hit.x;
      dir.y-=hit.y*5;
      dir.z-=10;
    }
  } else
  {
    ballX=mouseX;
    ballY=mouseY;
    if (mousePressed&&mouseIsPressed==false)
    {
      mouseIsPressed=true;
    } else if (mouseIsPressed&&mousePressed==false)
    {
      released=true;
    }
  }
  pushMatrix();
  translate(ballX, ballY, ballZ);
  sphere(30);
  popMatrix();
  stroke(255);
  line(0, height, 0, 0, height, -6000);
  noStroke();
  x2=x1;
  y2=y1;
  x1=mouseX;
  y1=mouseY;
  if(wPress)
  {
    camZ-=10;
  }
  if(sPress)
  {
    camZ+=10;
  }
  if(aPress)
  {
    camX-=10;
  }
  if(dPress)
  {
    camX+=10;
  }
}
void keyPressed()
{
  if(key=='w')
  {
    wPress=true;
  }
  if(key=='s')
  {
    sPress=true;
  }
  if(key=='a')
  {
    aPress=true;
  }
  if(key=='d')
  {
    dPress=true;
  }
}
void keyReleased()
{
  if(key=='w')
  {
    wPress=false;
  }
  if(key=='s')
  {
    sPress=false;
  }
  if(key=='a')
  {
    aPress=false;
  }
  if(key=='d')
  {
    dPress=false;
  }
}