float cubeEdge = 40;    // length of cube edge
float pillarRate = 25; // chance of pillar creation
float avatarWidth = 30;
float maxMoveSpeed = 0.5;
float curMoveSpeed = 0.2;

int gridHght = 03; // max height of pillar
int gridRows = 10; //(int)random(05, 15); // max rows towards z-axis
int gridCols = 20; //(int)random(20, 30); // max cols towards x-axis
int panSpeed = 03; // speed of camera movement 
int camShift = 01; // initial camera offset

int grass = 0;
int landCube = 1;
int grassDark = 2;
int pillarCube = 3;
int currentLerp = 0;

boolean gravity = true;
boolean friction = true;
boolean grounded = false;
boolean lookingLeft = false;
boolean lookingRight = true;

Grid grid; // grid object, holds a 3D array of cubes
PImage[] textures = new PImage[4];
PImage[] spritesMove = new PImage[15];
PImage[] spritesIdle = new PImage[15];
PImage[] spritesJump = new PImage[2]; 

// -------------------------------------------
// functions
// -------------------------------------------

void setup() {
  size(1000, 1000, P3D);
  colorMode(RGB, 1.0f);
  textureMode(NORMAL); // uses normalized 0..1 texture coords
  textureWrap(CLAMP);
  noStroke();
  frameRate(30);
  // ONLY NEEDED FOR BONUS 
  // setupPOGL(); 
  // setup our hack to ProcesingOpenGL to let us modify the projection matrix manually
  importImages();
  grid = new Grid();
  grid.generateGrid();
}

void draw() {
  clear();
  background(0);
  setCamera();
  pollKeys();

  pushMatrix();
  translate(300, 800, 0);
  rotateY(PI/2);
  grid.drawGrid();
  grid.processAvatar();
  popMatrix();
}

void keyPressed() {
  if (key == KEY_RIGHT) {
    keyLeft = false;
    keyRight = true;
  } else if (key == KEY_LEFT) {
    keyRight = false;
    keyLeft = true;
  } else if (key == KEY_UP) {
    keyDown = false;
    keyUp = true;
  } else if (key == KEY_DOWN) {
    keyUp = false;
    keyDown = true;
  } else if (key == KEY_JUMP) {
    if (grid.avatar.currPos[1] <= 1) {
      gravity = false;
      keyJump = true;
    }
  } else if (key == KEY_VIEW) {
    orthoMode = !orthoMode;
  } else if (key == KEY_TEX) {
    doTextures = !doTextures;
  }

  //if (keyCode == LEFT) {
  //  camShift -= panSpeed*30;
  //}

  //if (keyCode == RIGHT) {
  //  camShift += panSpeed*30;
  //}
}

void keyReleased() {
  if (key == KEY_RIGHT) {
    keyRight = false;
    friction = true;
  } else if (key == KEY_LEFT) {
    keyLeft = false;
    friction = true;
  } else if (key == KEY_UP) {
    keyUp = false;
    friction = true;
  } else if (key == KEY_DOWN) {
    keyDown = false;
    friction = true;
  } else if (key == KEY_JUMP) {
    keyJump = false;  
    gravity = true;
  }
}

void pollKeys() {
  if (keyRight) grid.avatar.moveRight();
  if (keyLeft) grid.avatar.moveLeft();
  if (keyUp) grid.avatar.moveUp();
  if (keyDown) grid.avatar.moveDown();
  if (keyJump) grid.avatar.checkElevation();
}

void importImages() {
  spritesJump[0] = loadImage("/textures/avatarC/Jump (9).png");
  spritesJump[1] = loadImage("/textures/avatarC/Jump (13).png");
  textures[grass] = loadImage("/textures/grid/grass.png");
  textures[landCube] = loadImage("/textures/grid/landCube.png");
  textures[grassDark] = loadImage("/textures/grid/grassDark.png");
  textures[pillarCube] = loadImage("/textures/grid/pillarCube.png");

  for (int i = 0; i < 15; i++) {
    spritesMove[i] = loadImage("/textures/avatarC/Run (" + (i+1) + ").png");
    spritesIdle[i] = loadImage("/textures/avatarC/Idle (" + (i+1) + ").png");
  }
}
