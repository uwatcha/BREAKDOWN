class Racket {
  float x;
  float y;
  float w;
  float h;
  float hp;
  float life;//残機
  Racket() {//()の中で変数を定義することもできる
    w = 90;
    h = 10;
    hp = 2;
    life = 2;
  }

  //ラケットを動かす。
  void move(float _x, float _y) {
    x = _x;
    y = _y;
  }

  //ラケットを描画する。ラケットが右の壁に隠れたときは、その位置に固定する。
  void show() {
    if (!whenDestroyed) {
      if (x <= width/1.4) {
        noStroke();
        rect(x, y, w, h);//本体
        rect(x+w*2/5, y-h, w/5, h);//上の出っ張り。ショットの発射口。
        stroke(0);
        fill(255);//敵ブロックに枠線と白色を戻すために記入
      } else {
        noStroke();
        rect(width/1.4-3, y, w, h);//x座標に-3をしてるのは、status画面からちょっとはみ出させるため。
        stroke(0);
        fill(255);//ブロックに枠線と白色を戻すために記入
      }
    }
  }

  //ラケットとボールが当たった場合、ボールがラケットの左から何番目のドットに当たったかを数値で返す。一番左は0。
  float hitCheck(float _sx, float _sy, float _sw, float _sh, 
    float _bx, float _by, float _bw, float _bh, float _dx, float _dy) {
    float dot = -1;//初期値を-1にすることで、racketHitCheck>=0の時にreflectを使うことができ、ラケットの最左点を0とすることができる
    int hit = baseHitCheck(_sx, _sy, _sw, _sh, 0, 0, _bx, _by, _bw, _bh, _dx, _dy);
    if (hit > 0) {
      dot = _bx-_sx;//ボールの座標からラケットの座標を引くことであたったドットを調べる。
    }
    return dot;
  }

  //ラケットとボールが当たった場合、ある法則に基づいてdxの値を変更し、dyの値は-１倍することでボールを反射する。
  void reflect(float _bx, float _by, float _bw, float _bh, float _bdx, float _bdy) {
    float hit = racket.hitCheck(x, y, w, h, _bx, _by-_bh/2, _bw*3/2, _bh, _bdx, _bdy);//_をつけることで、グローバル変数と引数を区別する。
    //_がないと、関数が関数の引数に代入することになる
    if (hit >= 0) {
      float b = (4/(racket.w))*hit-2;//詳しくは保存してある画像"reflectGraph.jpg"を参照。y軸の3と-3という数をそれぞれ2と-2に置き換えて参照してください。
      bdx = b*abs(tmpdx);//絶対値に数値をかけることで、左右どちらからボールがラケットに当たっても一定の向きに反射させることができる。
      bdy = -bdy;
    }
  }

  //---残機の管理-------------------------------------------------------------------
  void life() {
    if (whenDestroyed && life == tmplife) {
      if (hp <= 0) {
        life--;
      }
    }
    if (life == 2) {
      noStroke();
      fill(90, 255, 25);
      rect(900, 330, w, h);//本体
      rect(900+w*2/5, 330-h, w/5, h);//上の出っ張り。ショットの発射口。
      rect(900+1.5*w, 330, w, h);//本体
      rect(900+w*2/5+1.5*w, 330-h, w/5, h);//上の出っ張り。ショットの発射口。
      stroke(0);
      fill(255);//敵ブロックに枠線と白色を戻すために記入
    }
    if (life == 1) {
      noStroke();
      fill(90, 255, 25);
      rect(900, 330, w, h);//本体
      rect(900+w*2/5, 330-h, w/5, h);//上の出っ張り。ショットの発射口。
      stroke(0);
      fill(255);//敵ブロックに枠線と白色を戻すために記入
    }
  }
}
