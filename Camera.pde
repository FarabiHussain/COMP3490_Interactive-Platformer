void setCamera () {
  if (!orthoMode) {
    camera(
      (width/2)+camShift, 300, 400, // eye x,y,z
      (width/2)+camShift, (height/2), 0, // centre x,y,z
      0, 1, 0); // up vector

    perspective(
      PI/3, // fovY
      width/height, // aspect ratio
      (height/2) / tan(PI*60.0/360)/10, // near
      (height/2) / tan(PI*60.0/360)*10); // far
  } else {
    camera(
      (width/2)+camShift, (height/2), height, // eye x,y,z 
      (width/2)+camShift, (height/2), 0, // centre x,y,z
      0, 1, 0); // up vector

    ortho(
      -width/2, // left
      width/2, // right
      -height/2, // bottom
      height/2); // top
  }
}
