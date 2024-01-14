//ふたつの長方形が重なるかどうかをしらべて、重なったとき:true, 重ならないとき:false を返す
boolean isOverlap(float x1, float y1, float w1, float h1, 
  float x2, float y2, float w2, float h2) {
  return (x1 <= x2+w2 && x2 <= x1+w1 && y1 <= y2+h2 && y2 <= y1+h1);//本来<=でなく<のみ。不具合出れば、消す。
}

/*
 ブロックの位置と大きさ、
 ボールの位置と大きさ、ボールの移動速度の情報を与えて
 跳ね返る方向（x軸、y軸の別）を返す
 跳ね返らない時: 0
 x軸のみの時: 1
 y軸のみの時: 2
 x軸, y軸両方の時: 3
 */
int baseHitCheck(float x1, float y1, float w1, float h1, float dx1, float dy1, 
  float x2, float y2, float w2, float h2, float dx2, float dy2) {//1が当てられる側、2が当てる側として使う。
  int xflag = 0, yflag = 0;

  if (!isOverlap(x1+dx1, y1+dy1, w1, h1, x2+dx2, y2+dy2, w2, h2)) {
    return 0;
  }

  if (isOverlap(x1+dx1, y1+dy1, w1, h1, x2+dx2, y2, w2, h2)) xflag = 1;
  if (isOverlap(x1+dx1, y1+dy1, w1, h1, x2, y2+dy2, w2, h2)) yflag = 2;
  if (xflag + yflag > 0) { 

    return xflag + yflag;
  }
  return 3;
}
