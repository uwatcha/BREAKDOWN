//---爆散するエフェクトを出し、その間ラケットを無効化。
void destroy(float _rx, float _ry) {

  if ( x1 == 0 && x2 == 0 && y1 == 0 && y2 == 0) {//この関数が始まっていないことを認識
    x1 = _rx;//右に行く円のx座標
    x2 = _rx;//左に行く円のx座標
    x3 = _rx;//右斜めに行く円のx座標
    x4 = _rx;//左斜めに行く円のx座標
    y1 = _ry;//下に行く円のy座標
    y2 = _ry;//上に行く円のy座標
    y3 = _ry;//斜め下に行く円のy座標
    y4 = _ry;//斜め上に行く円のy座標
    x5 = _rx;//横移動をしない円のx座標
    y5 = _ry;//縦移動をしない円のx座標
  }

  if (racket.hp == 0) {
    whenDestroyed = true;
    if (y2 >0) {
      theta += 0.5;
      x1 += 7;
      x2 -= 7;
      y1 += 7;
      y2 -= 7;
      x3 += 7/sqrt(2);
      y3 += 7/sqrt(2);
      x4 -= 7/sqrt(2);
      y4 -= 7/sqrt(2);

      r = map(sin(theta), -1, 1, 40, 80);//エフェクトの円の大きさを周期的に変化させる。
      fill(157, 228, 255);
      noStroke();
      circle(x1+40*sqrt(2)+40, y5, r);
      circle(x3+80, y4-40, r);
      circle(x5+40, y4-40*sqrt(2), r);
      circle(x4, y4-40, r);
      circle(x2-40*sqrt(2)+40, y5, r);
      circle(x4, y3+40, r);
      circle(x5+40, y1+40*sqrt(2), r);
      circle(x3+80, y3+40, r);
      fill(255);

      ballRemove();
    }

    if (y2 <=0) {
      whenDestroyed = false;
      x1 = 0;
      x2 = 0;
      x3 = 0;
      x4 = 0;
      y1 = 0;
      y2 = 0;
      y3 = 0;
      y4 = 0;
      x5 = 0;
      y5 = 0;
      racket.hp = 2;
      tmplife = racket.life;
      if (racket.life == -1) {
        scene = 3;
      }
    }
  }
}
