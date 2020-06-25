ArrayList<Integer> x = new ArrayList<Integer>(), y = new ArrayList<Integer>();

int w = 30, h = 30, blocks = 20, direction = 2, foodx = 15, foody = 15, fc1 = 255, fc2 = 255, fc3 = 255, speed = 8;
int[] x_direction = {0,0,1,-1}, y_direction = {1,-1,0,0};
boolean gameover = false;

void setup(){
  size(600,600); //draws our window
  x.add(0); 
  y.add(15);
}

void draw(){

  background(0);
  fill(56,168,50);  
  for(int i = 0; i < x.size(); i++) rect(x.get(i) * blocks, y.get(i) * blocks, blocks, blocks);
  if(!gameover){
    fill(fc1, fc2, fc3); //food color: Starts off as white but changes randomly
    ellipse(foodx * blocks + 10, foody * blocks + 10, blocks, blocks); //creates snake "food"
    textAlign(LEFT); //score
    textSize(25);
    fill(255);
    text("Score: " + x.size(), 10, 10, width - 20, 50);
  if(frameCount % speed == 0){
      x.add(0, x.get(0) + x_direction[direction]);
      y.add(0, y.get(0) + y_direction[direction]); 
     
     //checks if snake is out of bounds 
    if(x.get(0) < 0 || y.get(0) < 0 || x.get(0) >= w || y.get(0) >= h) gameover = true;
    
    //checks if the snake is touching itself
    for(int i = 1; i < x.size(); i++)
      if(x.get(0) == x.get(i) && y.get(0) == y.get(i)) gameover = true; 
    
    if(x.get(0) == foodx && y.get(0) == foody){
      //%5 represents how much food must be eaten to increase speed of the game
      if(x.size() % 5 == 0 && speed >= 2) speed -= 1; //snake speed increase 
      foodx = (int) random(0, w);
      foody = (int) random(0, h);
      fc1 = (int) random(255); fc2 = (int) random(255); fc3 = (int) random(255);
    }
    else {
      x.remove(x.size() - 1);
      y.remove(y.size() - 1);
    }
   }
  }
  else{
    fill(255, 3, 28); //red color
    textSize(30);
    textAlign(CENTER);
    text("GAME OVER\n Your score was: " + x.size() + "\n Press ENTER", width / 2 , height / 3);
    if(keyCode == ENTER){
      x.clear();
      y.clear();
      x.add(0);
      y.add(15);
      direction = 2;
      speed = 8;
      gameover = false;
    }
  }
}

void keyPressed() { 
  //determines direction of snake when user presses a button
  int newdir=keyCode == DOWN? 0:(keyCode == UP?1:(keyCode == RIGHT?2:(keyCode == LEFT?3:-1))); 
  if (newdir != -1) direction = newdir;
}
