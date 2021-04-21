class Avatar {
  color c;
  float[] currPos = new float[3];
  int x = 0;
  int y = 1;
  int z = 2;
  int frame = 0;

  public Avatar (color c, float xPos, float yPos, float zPos) {
    this.c = c;
    currPos [x] = xPos;
    currPos [y] = yPos;
    currPos [z] = zPos;
  }

  void moveRight() { 
    lookingRight = true;
    lookingLeft = false;
    if (currPos[z] < (gridCols*2 - 2)) {
      if (keyJump) {
        currPos[z] += 1*curMoveSpeed;
        camShift += panSpeed;
      } else {
        currPos[z] += curMoveSpeed;
        camShift += panSpeed;
      }
    }
  }

  void moveLeft() {
    lookingRight = false;
    lookingLeft = true;
    if (currPos[z] > -0.25) {
      if (keyJump) {
        currPos[z] -= 1*curMoveSpeed;
        camShift -= panSpeed;
      } else {
        currPos[z] -= curMoveSpeed;
        camShift -= panSpeed;
      }
    }
  }

  void moveUp() {
    if (currPos[x] < gridRows*2 - 2) {
      if (keyJump) {
        currPos[x] += 1*curMoveSpeed;
      } else {
        currPos[x] += curMoveSpeed;
      }
    }
  }

  void moveDown() {
    if (currPos[x] > -0.75) {
      if (keyJump) {
        currPos[x] -= 1*curMoveSpeed;
      } else {
        currPos[x] -= curMoveSpeed;
      }
    }
  }

  void checkElevation() {    
    if (!gravity) {
      if (currPos[y] < 2.5) {
        currPos[y] += curMoveSpeed/2;
      } else {
        gravity = true;
      }
    } else {
      if (currPos[y] > 1) currPos[y] -= curMoveSpeed/2;
    }

    if (currPos[y] <= 1) {
      currPos[y] = 0.98;
      keyJump = false;
    }
  }

  void drawAvatarQuads() {
    if (doTextures) {
      drawTexturedAvatar();
    } else {
      drawFilledAvatar();
    }
  }

  void drawTexturedAvatar() {
    if (frame == 14) frame = 0;
    else frame += 1;

    beginShape(QUAD);   
    if ((keyUp || keyDown || keyRight || keyLeft) && (currPos[y] <= 1)) {
      texture(spritesMove[frame]);
      if (keyJump) {
        texture(spritesJump[0]);
      }
    } else if (keyJump) {
      texture(spritesJump[0]);
    } else {
      if (currPos[y] <= 1) {
        texture(spritesIdle[frame]);
      } else {
        texture(spritesJump[1]);
      }
    }

    //if (currentLerp == 0) {
    //  vertex(0, -cubeEdge, avatarWidth, 1, 0); // bottom left
    //  vertex(0, -cubeEdge, -avatarWidth, 0, 0);// top left
    //  vertex(0, cubeEdge, -avatarWidth, 0, 1); // top right
    //  vertex(0, cubeEdge, avatarWidth, 1, 1);  // bottom right
    //} else 
    if (currentLerp == 180) { 
      vertex(0, -cubeEdge, avatarWidth, 0, 0); // bottom left
      vertex(0, -cubeEdge, -avatarWidth, 1, 0);// top left
      vertex(0, cubeEdge, -avatarWidth, 1, 1); // top right
      vertex(0, cubeEdge, avatarWidth, 0, 1);  // bottom right
    } else {
      vertex(0, -cubeEdge, avatarWidth, 1, 0); // bottom left
      vertex(0, -cubeEdge, -avatarWidth, 0, 0);// top left
      vertex(0, cubeEdge, -avatarWidth, 0, 1); // top right
      vertex(0, cubeEdge, avatarWidth, 1, 1);  // bottom right
    }

    endShape();
  }

  void drawFilledAvatar() {
    fill(c);
    beginShape(QUAD);   
    vertex(0, -cubeEdge, avatarWidth); // bottom left
    vertex(0, -cubeEdge, -avatarWidth);// top left
    vertex(0, cubeEdge, -avatarWidth); // top right
    vertex(0, cubeEdge, avatarWidth);  // bottom right
    endShape();
  }

  void printPosition() {
    println(currPos[x] + "\t" + currPos[y] + "\t" + currPos[z]);
  }
}
