class MyShot {
  float x;
  float y;
  float w;
  float h;
  float dy;

  MyShot(float _x, float _y) {
    x = _x;
    y = _y;
    w = 3;
    h = 30;
    dy = 20;
  }

  //自分のショットを動かす。
  void myMove() {
    y -= dy;
  }

  //ショットの描画。
  void show() {
    if (!whenDestroyed) {
      rect(x, y, w, h);
    }
  }
}
