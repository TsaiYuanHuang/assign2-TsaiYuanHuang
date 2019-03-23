PImage bgImg,lifeImg, soilImg, soldierImg,cabbageImg;
PImage title,gameover,startNormal,startHovered,restartHovered,restartNormal;
PImage groundhogLeft,groundhogRight,groundhogDown,groundhogIdleImg;
int xSoldier,ySoldier,rowSoldier,
xGroundhog,yGroundhog,rowGroundhog,
xCabbage,yCabbage,rowCabbage,lineCabbage;

int life;

final int TOTAL_LIFE = 2;
final int X_GROUNDHOG = 320;
final int Y_GROUNDHOG = 80;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
int gameState = GAME_START;


void setup(){
  size(640,480);
  
  //add images
  bgImg = loadImage("img/bg.jpg");
  groundhogIdleImg = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  lifeImg = loadImage("img/life.png");
  soilImg = loadImage("img/soil.png");
  soldierImg = loadImage("img/soldier.png");
  cabbageImg = loadImage("img/cabbage.png");
  title = loadImage("img/title.jpg");
  gameover = loadImage("img/gameover.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartHovered = loadImage("img/restartHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  
  //add initial values to variables
  rowSoldier = floor(random(2,6));
  xSoldier = -80;
  ySoldier = 80* rowSoldier;
  xGroundhog = X_GROUNDHOG;
  yGroundhog = Y_GROUNDHOG;
  rowCabbage = floor(random(2,6));
  lineCabbage = floor(random(0,8));
  xCabbage = 80*lineCabbage;
  yCabbage = 80*rowCabbage;
  life = TOTAL_LIFE;

}

void draw(){
  
  frameRate(60);

  
  switch(gameState){
    case 0:
      image(title,0,0);
      image(startNormal,248,360);
      //hover
      if(mouseX >= 248 && mouseX <= 392 && mouseY >=360 && mouseY <=420){
        image(startHovered,248,360);
        if(mousePressed){
          gameState = 1;
        }
      }
      break;
      
    case 1:
      //background image
      image(bgImg, 0, 0);
    
      //AABB detection_soldier & groundhog
      if(xGroundhog < xSoldier+80 && xGroundhog+80 > xSoldier &&
         yGroundhog < ySoldier+80 && yGroundhog+80 > ySoldier){
          xGroundhog = X_GROUNDHOG;
          yGroundhog = Y_GROUNDHOG;
          life--;
      }
    
      //AABB detection_groundhog & cabbage
      if(xGroundhog < xCabbage+80 && xGroundhog+80 > xCabbage &&
         yGroundhog < yCabbage+80 && yGroundhog+80 > yCabbage){
          yCabbage = height+1;
          life ++;
      }
      
      //grass
      fill(124, 204, 25);
      noStroke();
      rect(0, 145, 640, 15);
      
      //sun
      fill(255, 255, 0);
      noStroke();
      ellipse(590, 50, 130, 130);
      fill(253, 184, 19);
      noStroke();
      ellipse(590, 50, 120, 120);
      
      //soil img
      image(soilImg, 0, 160);
      
      //cabbage
      image(cabbageImg,xCabbage,yCabbage);
        
      //soldier animation
      xSoldier += 3;
      if(xSoldier >= 640){
        xSoldier = -80;
      }
      image(soldierImg, xSoldier, ySoldier);
      

      //groundhogimg
      image(groundhogIdleImg,xGroundhog,yGroundhog);


      
      //life    
      if(life == 3){
        image(lifeImg, 10, 10); 
        image(lifeImg, 80, 10);
        image(lifeImg, 150, 10);
      }
      
      if(life == 2){
        image(lifeImg, 10, 10); 
        image(lifeImg, 80, 10);
      }
      
      if(life == 1){
        image(lifeImg, 10, 10); 
        image(lifeImg, 80, -80);
      }
      if(life == 0){
        image(lifeImg, 10, -80); 
        image(lifeImg, 80, -80);
        gameState = 2;
      }  
      break;
      
    case 2:
      image(gameover,0,0);
      image(restartNormal,248,360);
      //hover
      if(mouseX >= 248 && mouseX <= 392 && mouseY >=360 && mouseY <=420){
        image(restartHovered,248,360);
        if(mousePressed){
          life = TOTAL_LIFE;
          rowCabbage = floor(random(2,6));
          lineCabbage = floor(random(0,8));
          xCabbage = 80*lineCabbage;
          yCabbage = 80*rowCabbage;
          rowSoldier = floor(random(2,6));
          xSoldier = -80;
          ySoldier = 80* rowSoldier;
          gameState = 1;
        }
      }
      break;
   }
}

void keyPressed(){
  if(key == CODED){
    switch(keyCode){
      case DOWN:
        yGroundhog += 80;
        if(yGroundhog >= height-80){
          yGroundhog = height-80;
        }
        break;
        
      case LEFT:
        xGroundhog -= 80;
        if(xGroundhog <= 0){
          xGroundhog = 0;
        }
        break;
      case RIGHT:
        xGroundhog += 80;
        if(xGroundhog >= width-80){
          xGroundhog = width-80;
        }
        break;
      }
    }
  }
