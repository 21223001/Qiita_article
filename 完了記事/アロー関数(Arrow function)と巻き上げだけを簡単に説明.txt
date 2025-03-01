javascript初学者の為，関数の巻き上げに対して，なんでこんな気持ち悪い機能がついてんだと思っていたが，アロー関数を使用すれば巻き上げを回避できる事を知った．また，他にもアロー関数を用いる利点があるので，それも含めて以下に記述する

### 要点
アロー関数は，function の代わりとなるが，巻き上げやthisの挙動が異なる．
javascript特有の巻き上げや，thisのコストを避けたい場合には，出来る限りアロー関数を用いるべき．
また，functionを用いるのであれば，"use strict" を用いる事で，制限されたモードを使用する事が推奨される．

## アロー関数（Arrow Function）とは
アロー関数は、ES6（ECMAScript 2015）で導入された新記法  
`=>`（矢印）を使うことで、より簡潔に関数を定義できる  
また， **this の扱いが異なる** という特徴がある


### 基本的な構文
```
const 関数名 = (引数1, 引数2, ...) => {
  処理;
  return 戻り値;
};


```


### 巻き上げ（Hoisting）について
巻き上げ (Hoisting) は変数や関数の宣言がスコープの先頭に移動する(様に見える)仕様
但し，実際のコードが移動する事は無く，実行コンテキストの中で変数や関数の宣言が事前に処理される事で生じる．
~~要は，Javascriptにおけるレガシーな機能である~~



</details>


具体例
```
// 巻き上げが生じる

sayHelloWorld(); // "HelloWorld!"

function sayHelloWorld() {
  console.log("HelloWorld!");
}

```

```
// 内部的な処理
function sayHelloWorld() {  // 関数の定義全体が巻き上げられる
  console.log("HelloWorld!");
}

sayHelloWorld(); // "HelloWorld!"

```





### なぜアロー関数では巻き上げが回避できるのか
アロー関数は**関数式**，functionは**関数宣言**である為．

関数宣言はスクリプトの解析時にメモリに登録されるため，事前に呼び出し可能となる．
言葉を返すと，巻き上げが**勝手に**される．

#### 巻き上げの影響を受ける or 受けない
影響を受ける
 - var, function

影響を受けない
 - let, const, 関数式, アロー関数



### 巻き上げが現存する理由と対策
Javascriptにおける，歴史的な経緯が強い．

初期のJavascriptは，スクリプトの実行速度を高める為，**事前解析**を行う仕様だった．
従って，Javascriptエンジンは，コードの**実行前に関数の宣言を登録**して，後で実行可能とする仕様となった．
結果として，自然発生として，巻き上げ(関数の事前登録)が生じた．


その後，Javascriptはバージョンアップがされてきたが，依然として巻き上げは残っている．
少なくとも，巻き上げという処理自体は，理解して利用すれば便利であると考える人もいる．
"use strict"モードや，アロー関数により，thisの巻き上げの影響を制限している．





### 参考文献
MDN Web Docs - Hoisting
https://developer.mozilla.org/en-US/docs/Glossary/Hoisting

TC39 Proposal - Let and Const
https://tc39.es/ecma262/#sec-let-and-const-declarations

Brendan Eich's blog - JavaScript History
https://brendaneich.com/

