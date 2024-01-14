int loadHiscore() {
  String lines[];
  lines = loadStrings("data.txt");
  if (lines == null) { // data.txt というファイルが読めなかった時
    return 0;
  } else {
    return int(lines[0]);
  }
}

void storeHiscore(int hi_score) {
  String lines [] = new String[1];
  // str(整数) は整数を表す文字列を返す
  lines[0] = str(hi_score);
  saveStrings("data.txt", lines);
}

void menu() {
  if (hiscore <= score) {
    hiscore = score;
  }

  rect(width/1.4, 0, width*3/4, height); //メニューエリアを描画。
  fill(255, 0, 0); 
  textSize (30);
  text("SCORE", width/1.4 +40, 100); //敵を倒したりボールを落とさずに打ち返し続けたらカウント。
  text(score, width/1.4 +240, 100);
  text("HIGHSCORE", width/1.4 +40, 170); //最高記録
  text(hiscore, width/1.4+240, 170);
  text("LIFE", width/1.4 +40, 270);
  text("stage", width/1.4 +40, 370);
  text(stage, width/1.4+180, 370);
  fill(255);
  racket.life();
}
