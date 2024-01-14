/* 文字の意味 //<>// //<>// //<>// //<>//
 x,y = 座標
 b = ボール
 r = ラケット
 s = ショット　ラケットから発射するやつ
 d = 速度
 w = 幅
 h = 高さ
 */

ArrayList<MyShot> myShotList = new ArrayList<MyShot>();//自分のショットのパラメータを入れる
ArrayList<Enemy> enemyList = new ArrayList<Enemy>();//敵ブロックのパラメータを入れる
Racket racket;//Racketがint、racketが i みたいな感じ。クラスの変数を宣言し、コンストラクタを代入することではじめてクラスを使える
Enemy enemy;
float sx = 0;//敵ショットのx座標
float sy = 0;//敵ショットのy座標
float sdy = 1;//敵ショットの速度
int scene = 0;//0:タイトル画面、1;プレイ画面、2:ステージクリア画面、3:ゲームオーバー画面
int stage = 1;
int score;
int hiscore;
boolean whenDestroyed = false;//trueの時、ラケットが破壊されていることを示す。
int timer;//経過時間を計測する。プレイ時に加算される。
boolean ballRemoveAllow;//タイトル画面ではtrue、プレイ画面で一度ボールをクリックでリセットするとfalseになる。ゲームを開始して初めのballReset()はそのままだとx座標のmouseXが0と認識されてしまうので、ballReset()関数で一度ボールのパラメータをすべて0にする。
boolean ballAccelerateAllow = false;//trueの時に奇数ステージで敵ショットの速度を5上げる。その処理の直後にこの変数にfalseを代入することで、1週目の処理でのみ速度を上げることができる。タイトル画面と偶数ステージクリア時にtrueを代入する。
float tmplife;//racket.life()で一度hpが0になったときに、lifeを一度だけ-1するようにするための変数。まずタイトル画面でtmplife = lifeをする。lifeを減らすときの条件にtmplife == lifeを定め、lifeだけを減らす。ラケットのdestroy_animationが終わったら再びtmplife = lifeをする。
PImage enemyImage;


//---destroy()でのみ使う変数-------------------
float theta = 0;
float x1 = 0;
float x2 = 0;
float x3 = 0;
float x4 = 0;
float y1 = 0;
float y2 = 0;
float y3 = 0;
float y4 = 0;
float x5 = 0;
float y5 = 0;
float r = 40;//円の直径
//---------------------------------------------


void setup() {
  size(1200, 900);
  fill(255);
  racket = new Racket();
  enemy = new Enemy(0, 0);
  enemyImage = loadImage("fineEnemy.png");
  enemyImage.resize(50, 30);

}

void draw() {

  background(0);

  if (scene == 0) {
    title();
  }

  if (scene == 1) {
    play();
  }

  if (scene == 2) {
    stageClear();
  }

  if (scene == 3) {
    gameover();
  }
}


void keyPressed() {
  //スペースキーでショットを発射。  
  if (!whenDestroyed && bw != 0) {
    if (key == ' ') {
      if (myShotList.size() == 0) {//画面内にショットは1つだけ
        myShotList.add(new MyShot(racket.x +racket.w/2 -2, racket.y)); //リストにショットの発射位置を代入。
      }
    }
  }
  //シフトキーで倍速。
  if (keyCode == SHIFT) {
    frameRate(120);
  }
  //タブキーでハイスコアリセット
  if (keyCode == TAB && scene == 0) {
    String reset [] = new String[1];
    reset[0] = str(0);
    saveStrings("data.txt", reset);
  }
//デバッグ及びプレゼン用----------------  
  if (keyCode == ALT){
  stage = 2;
  }
//-------------------------------------- 
}
//シフトキーで倍速。
void keyReleased() {
  if (keyCode == SHIFT) {
    frameRate(60);
  }
}

void mouseClicked() {
  if (scene == 0) {
    scene = 1;
  }
  if (scene == 1) {
      ballReset();
  }
  if (scene == 2) {
    stage++;
    //敵を再配置。
    if (enemyList.size() <54) {
      for (int i=0; i < 9; i++) {
        for (int j=0; j < 6; j++) {
          enemy.reset(i, j);
        }
      }
    }
    scene = 1;
  }
  if (scene == 3) {
    scene = 0;
  }
}
