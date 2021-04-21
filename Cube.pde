class Cube {
  color c;
  float xPos;
  float yPos;
  float zPos;
  PImage topTexture;
  PImage sideTexture;

  public Cube (color c, float xPos, float yPos, float zPos) {
    this.c = c;
    this.xPos = xPos;
    this.yPos = yPos;
    this.zPos = zPos;
  }

  void drawCubeQuads() {
    if (doTextures) {
      drawTexturedQuads();
    } else {
      drawFilledQuads();
    }
  }

  void drawFilledQuads() {

    fill(c);

    beginShape(QUADS);
    vertex(-cubeEdge, -cubeEdge, cubeEdge);
    vertex(-cubeEdge, cubeEdge, cubeEdge);
    vertex(cubeEdge, cubeEdge, cubeEdge);
    vertex(cubeEdge, -cubeEdge, cubeEdge);

    vertex(cubeEdge, -cubeEdge, cubeEdge); 
    vertex(cubeEdge, -cubeEdge, -cubeEdge);
    vertex(cubeEdge, cubeEdge, -cubeEdge); 
    vertex(cubeEdge, cubeEdge, cubeEdge);  

    vertex(cubeEdge, -cubeEdge, -cubeEdge);
    vertex(-cubeEdge, -cubeEdge, -cubeEdge);
    vertex(-cubeEdge, cubeEdge, -cubeEdge);
    vertex(cubeEdge, cubeEdge, -cubeEdge);

    vertex(-cubeEdge, -cubeEdge, -cubeEdge);
    vertex(-cubeEdge, -cubeEdge, cubeEdge);
    vertex(-cubeEdge, cubeEdge, cubeEdge);
    vertex(-cubeEdge, cubeEdge, -cubeEdge);
    endShape();

    beginShape(QUAD);
    vertex(cubeEdge, -cubeEdge, cubeEdge); // top 
    vertex(-cubeEdge, -cubeEdge, cubeEdge);
    vertex(-cubeEdge, -cubeEdge, -cubeEdge);
    vertex(cubeEdge, -cubeEdge, -cubeEdge);

    vertex(-cubeEdge, cubeEdge, cubeEdge); // bottom
    vertex(cubeEdge, cubeEdge, cubeEdge);
    vertex(cubeEdge, cubeEdge, -cubeEdge);
    vertex(-cubeEdge, cubeEdge, -cubeEdge);
    endShape();
  }

  void drawTexturedQuads() {
    if (yPos > 0) {
      sideTexture = textures[pillarCube];
      topTexture = textures[grassDark];
    } else {
      topTexture = textures[grass];
      sideTexture = textures[landCube];
    }


    beginShape(QUADS);
    texture(sideTexture);
    vertex(-cubeEdge, -cubeEdge, cubeEdge, 0, 0);
    vertex(-cubeEdge, cubeEdge, cubeEdge, 0, 1);
    vertex(cubeEdge, cubeEdge, cubeEdge, 1, 1);
    vertex(cubeEdge, -cubeEdge, cubeEdge, 1, 0);

    vertex(cubeEdge, -cubeEdge, cubeEdge, 1, 0); 
    vertex(cubeEdge, -cubeEdge, -cubeEdge, 0, 0);
    vertex(cubeEdge, cubeEdge, -cubeEdge, 0, 1); 
    vertex(cubeEdge, cubeEdge, cubeEdge, 1, 1);  

    vertex(cubeEdge, -cubeEdge, -cubeEdge, 1, 0);
    vertex(-cubeEdge, -cubeEdge, -cubeEdge, 0, 0);
    vertex(-cubeEdge, cubeEdge, -cubeEdge, 0, 1);
    vertex(cubeEdge, cubeEdge, -cubeEdge, 1, 1);

    vertex(-cubeEdge, -cubeEdge, -cubeEdge, 1, 0);
    vertex(-cubeEdge, -cubeEdge, cubeEdge, 0, 0);
    vertex(-cubeEdge, cubeEdge, cubeEdge, 0, 1);
    vertex(-cubeEdge, cubeEdge, -cubeEdge, 1, 1);
    endShape();

    beginShape(QUAD);
    texture(topTexture);
    vertex(cubeEdge, -cubeEdge, cubeEdge, 1, 0); // top 
    vertex(-cubeEdge, -cubeEdge, cubeEdge, 0, 0);
    vertex(-cubeEdge, -cubeEdge, -cubeEdge, 0, 1);
    vertex(cubeEdge, -cubeEdge, -cubeEdge, 1, 1);

    vertex(-cubeEdge, cubeEdge, cubeEdge, 1, 0); // bottom
    vertex(cubeEdge, cubeEdge, cubeEdge, 0, 0);
    vertex(cubeEdge, cubeEdge, -cubeEdge, 0, 1);
    vertex(-cubeEdge, cubeEdge, -cubeEdge, 1, 1);
    endShape();
  }
}
