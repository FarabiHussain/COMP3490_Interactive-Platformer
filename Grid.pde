class Grid {
  Cube[][][] grid;
  Avatar avatar;
  


  public Grid() {
    grid = new Cube[gridRows][gridHght][gridCols];
    avatar = new Avatar((color)random(#000000), (gridRows*2 - 2.5), 1, 0);
    //avatar = new Avatar((color)random(#000000), 1, 1, 0);
  }

  void generateGrid() {
    for (int x=0; x < gridRows; x++) {
      for (int z=0; z < gridCols; z++) {
        color c = (color)random(#000000);
        grid[x][0][z] = new Cube(c, x, 0, z); // base cube


        if (random(0, 100) <= pillarRate) {
          int randomHeight = (int) random(gridHght);
          for (int y=1; y < randomHeight; y++) {
            grid[x][y][z] = new Cube(c, x, y, z); // pillar cubes
          }
        }
      }
    }

    // clear any pillars on top of avatar
    for (int y=1; y < gridHght; y++) {
      grid[gridRows-1][y][0] = null;
    }
  }

  void drawGrid() {
    for (int x=0; x < gridRows; x++) {
      for (int y=0; y < gridHght; y++) {
        for (int z=0; z < gridCols; z++) {
          if (grid[x][y][z] != null) {
            pushMatrix();
            translate(x*2*cubeEdge, -y*2*cubeEdge, z*2*cubeEdge);
            grid[x][y][z].drawCubeQuads();
            popMatrix();
          }
        }
      }
    }
  }

  void processAvatar() {
    translate(avatar.currPos[0]*cubeEdge, avatar.currPos[1]*-2*cubeEdge, avatar.currPos[2]*cubeEdge);

    pushMatrix();
    lerpAvatar();
    avatar.drawAvatarQuads();
    popMatrix();

    avatar.checkElevation();
    println(currentLerp);
  }

  void lerpAvatar() {
    if (lookingLeft) {
      if (currentLerp < 180) {
        currentLerp += 18;
        rotateY(radians(currentLerp));
        avatar.drawAvatarQuads();
      }
    } else if (lookingRight) {
      if (currentLerp > 0) {
        currentLerp -= 18;
        rotateY(radians(currentLerp));
        avatar.drawAvatarQuads();
      }
    }
  }
} // class Grid
