void title() {
  score = 0;
  loadHiscore();
  tmplife = racket.life;
  ballRemoveAllow = true;
  //  5*6体の敵ブロックのパラメータを格納
  if (enemyList.size() <54) {
    for (int i=0; i < 9; i++) {
      for (int j=0; j < 6; j++) {
        enemy.reset(i, j);
      }
    }
  }
  //---------------------------
  textSize(100);
  text("BREAK DOWN", 260, 400);
  textSize(50);
  text("Click to Start", 430, 700);
  ballAccelerateAllow = true;
}

void stageClear() {
  text("STAGE CLEAR", width/2.8-40, height/2);
  if (stage%2 == 0) {
    ballAccelerateAllow = true;
  }
  ballRemove();
  //---メニュー---------------------------------------------------------------------------------------------
  menu();
  //--------------------------------------------------------------------------------------------------------
}

void gameover() {
  for (int i = enemyList.size () -1; i >= 0; i--) {
    enemyList.remove(i);
  }
  ballRemove();
  racket.life = 2;
  stage = 1;
  enemy.y = 0;
  sdy = 1;
  timer = 0;
  storeHiscore(hiscore);

  textSize(100);
  text("GAME OVER", 200, 300);
  text("m9(^Д^)", 600, 500);
  text("SCORE", 300, 800);
  text(score, 800, 800);
}
