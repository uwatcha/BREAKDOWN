float bx;
float by;
float bw;
float bh;
float bdx;
float bdy;
float tmpdx;//racket.reflectで速度の絶対値を求めるために、その時のdxの値を入れておく。そのままdxを使って絶対値を求めると無限に加速する。

//ボールを動かす
void ballMove() {
  if (!whenDestroyed) {
    bx += bdx;
    by += bdy;
  }
}

// ボール描画。x,y座標をこのように指定することでボールの座標をボールの中心にすることができる。
void ballShow(float _x, float _y, float _w, float _h) {
  if (!whenDestroyed) {
    rect(_x -_w/2, _y -_h/2, _w, _h);
  }
}
//ボールを画面から消す。ボールが画面から消えていることはbw == 0を条件式に使うことで認識させる。
void ballRemove() {
  bx = 0;
  by = 0;
  bw = 0;
  bh = bw;
  bdx = 0;
  bdy = 0;
  tmpdx = bdx;

  if (scene == 1 && !whenDestroyed && !ballRemoveAllow) {//「プレイ中」で、「ラケットが破壊されていなく」て、「ステージ開始してから2回目以降にballRemove()が使われた」ときに、ラケットのhpを減らす。
    racket.hp --;
  }
}

//ボールを再スタートさせる。
void ballReset() {
  if (bw == 0){//ボールが画面内にないとき
  bx = racket.x + racket.w/2;
  by = height -60;
  bw = 12;
  bh = bw;
  bdx = 4;
  bdy = 5;
  tmpdx = bdx;
  }
}
