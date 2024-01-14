class Enemy { //<>//
  float x;
  float y;
  float w;
  float h;
  float dx;
  float dy;
  float hp;//敵の体力

  Enemy(float _x, float _y) {
    x = _x;
    y = _y;
    w = 50;
    h = 30;
    hp = 4;
    dx = 0;
    dy = 0;
  }

  //敵ブロックの座標をリストに格納
  void reset(int _i, int _j) {
    x = (_i+1)*1.5*w+0.7*w;
    y = (_j+1)*3*h+0.2*h;
    enemyList.add(new Enemy(x, y));
  }

  //敵ブロック描画
  void show() {
    if (stage%2 == 0) {
      if (timer%8 == 0) {
        y += 1;
      }
    }
    rect(x, y, w, h);
    image(enemyImage, x, y);
  }

  //ショットが敵に当たればhpを減らし、そのショットによってhpが0以下になれば、リストからその敵の値を取り除き、trueを返す。そうでなければ、falseを返す。
  boolean shotHitCheck(MyShot _shot) {
    int shotHit = baseHitCheck(this.x, this.y, this.w, this.h, this.dx, this.dy, _shot.x, _shot.y, _shot.w, _shot.h, 0, _shot.dy);//ショットは横に移動しないため、右から２番目の引数には０が入る。
    if (shotHit > 0) {
      hp -= 1;
      score += 15;
      myShotList.remove(_shot);
      if (hp <= 0) {
        enemyList.remove(this);
      }
      return true;
    } else {
      return false;
    }
  }

  //ボールが敵に当たればhpを減らし、そのボールによってhpが０以下になれば、リストからその敵の値を取り除き、ボールを反射する。敵の角に当たった場合は、ベクトルが-１倍される。そして、trueを返す。そうでなければ、falseを返す。
  boolean ballHitCheck () {
    int ballHit = baseHitCheck(this.x, this.y, this.w, this.h, this.dx, this.dy, bx-bw/2, by-bh/4, bw/2, bh/2, bdx, bdy);
    if (ballHit > 0) {
      hp -= 2;
      score += 50;
      if (hp <= 0) {
        enemyList.remove(this);
      }
      if (ballHit ==1) {
        bdx = -bdx;
      }
      if (ballHit ==2) {
        bdy = -bdy;
      }
      if (ballHit ==3) {
        bdx = -bdx;
        bdy = -bdy;
      }
      return true;
    } else {
      return false;
    }
  }

  //偶数ステージで敵がこちらに接近しすぎた場合、強制ゲームオーバー。
  void approached() {
    if (enemyList.size() != 0) {
      Enemy _enemy = enemyList.get(enemyList.size()-1);
      if (_enemy.y >= height - 100) {
        if (racket.life != -1) {
          racket.hp = 0;
          racket.life = -1;
        }
        destroy(mouseX - racket.w/2, height-50);
      }
    }
  }
}
