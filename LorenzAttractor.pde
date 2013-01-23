/**
 * Lorenz Attractor
 * 	by Benjamin Callam 3/28/04
 * 	Clicking (in certain places) will add another particle to the attractor
 * 
 */

Lorenz[] elements;
int t = 80;

void setup()
{
  size(600, 600);
  //fill(255, 204);
  frameRate(30);
  colorMode(RGB);
  colorMode(HSB, 100);
  smooth();
  randomSeed(0);
  elements = new Lorenz[1];
  elements[0] = new Lorenz((random(100)-50)/2, (random(100)-25)/2, (random(80))/2, null, int(random(255))); 
}


void draw()
{
  background(0);
  //println("array size: " + elements.length);
  for(int i =0;i < elements.length; i++) {
    elements[i].display();
    elements[i].evaluateTime();
    elements[i] = elements[i].generateLorenz(elements[i]) ;
  }
}

void mousePressed()  {

  randomSeed(elements.length); 
  elements = (Lorenz[]) append(elements, (new Lorenz((random(100)-50)/2, (random(100)-25)/2, (random(80))/2, null, int(random(255))))) ; 
 

}

class Lorenz
{
  float x0, x1; 
  float y0, y1; 
  float z0, z1; 
  // Lorenz constants
  float h = 0.01;
  float a = 10.0;
  float b = 28.0;
  float c = 8.0 / 3.0;

  // Lifeperiod of circle
  float time;
  float timeOrigin;
  int colorSeed;

  // The child
  Lorenz child = null;

  // iterative construction function
  Lorenz(float xPos, float yPos, float zPos, Lorenz chld, int clrSeed) {
    x0 = xPos;
    y0 = yPos;
    z0 = zPos;
    child = chld;
    time = t;
    timeOrigin = t;
    colorSeed = clrSeed;
    //display();

    // Calculate next element
    x1=x0+h*a*(y0-x0);
    y1=y0+h*(x0*(b-z0)-y0);
    z1=z0+h*(x0*y0-c*z0);
  }

  Lorenz generateLorenz(Lorenz last){
    return (new Lorenz(x1,y1,z1,last, colorSeed));
  }

  // If time is expired, then return true
  boolean evaluateTime () {
    // see if the child is dead
    if( child != null){
      if(child.evaluateTime()) { 
        child = null;
      } 
    }
    time--;
    if(time<1)
      return true;
    else
      return false;
  }

  void display() {
    noStroke();
    fill(255-(255*(time/timeOrigin)),255-(255*(time/timeOrigin)),255-(255*(time/timeOrigin)),((time/timeOrigin)*100/4));
    ellipse(y0*8+(width/2), x0*8+(height/2), z0*2, z0*2);
    if(child!=null){    
      child.display();
    }
  }
}
