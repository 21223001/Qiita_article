JavaScriptの`Promise`は非同期処理を扱うためのオブジェクトであるが，適切な理解が出来ていなかった．
そこで，以下に調べた事を纏めた．

### In a nutshell
JavaScriptの`Promise`は，非同期処理を管理し，成功（resolved）または失敗（rejected）を扱うオブジェクトである．`then()`と`catch()`を用いたチェイニング，`async/await`による簡潔な記述，`Promise.all()`や`Promise.race()`による複数の非同期処理の制御が可能．エラーハンドリングや`finally()`を活用し，信頼性の高い非同期処理を実装できる．


### 基本的な構造

```javascript
let promise = new Promise((resolve, reject) => {
  // 非同期処理が成功した場合，resolve()を呼び出す
  let success = true; // この値を元に成功か失敗を決める
  if (success) {
    resolve("成功しました");
  } else {
    reject("失敗しました");
  }
});
```

### `then()` と `catch()`
`Promise`は非同期処理が完了した後に結果を処理するためのメソッドを提供する．`then()`は成功時に実行され，`catch()`はエラー時に実行される．

```javascript
promise
  .then((result) => {
    console.log(result); // 成功時の処理
  })
  .catch((error) => {
    console.log(error); // 失敗時の処理
  });
```


### `async/await`構文
`Promise`の使用は，`async`関数と`await`を使うことでさらに簡潔に書くことができる．`await`は`Promise`が解決されるのを待つため，非同期処理を同期的に記述できる．

```javascript

async function example() {
  try {
    let result = await promise; // Promiseが解決されるまで待つ
    console.log(result);
  } catch (error) {
    console.log(error);
  }
}

example();
```


###  `Promise`の状態
Pending: `Promise`がまだ解決されていない状態．
Resolved（Fulfilled）: 非同期処理が成功し，`resolve()`が呼ばれた状態．
Rejected: 非同期処理が失敗し，`reject()`が呼ばれた状態．



#### 複数の`Promise`を扱う
複数の`Promise`を扱うためには，`Promise.all()`や`Promise.race()`を使う．

#### `Promise.all()` と `Promise.race()` の違い
両方とも，複数のPromiseを扱うためのメソッドだが，それぞれの挙動には重要な違いがある．
`Promise.all()`は全ての非同期処理の完了を待つのに対し，`Promise.race()`は最初に完了した処理を優先する．

#### `Promise.all()`
全ての非同期処理が正常に完了することが求められる場合に使用する．
`Promise.all()`は，渡されたすべての`Promise`が成功するまで待機し，全ての`Promise`が解決されたときに，全ての結果を配列として返す．もし，いずれかの`Promise`が失敗（拒否）した場合，最初に失敗した`Promise`が返すエラーで処理が終了する．

例えば，複数のAPIリクエストを並行して実行し，すべてのデータを一度に処理する際に役立つ．

```javascript
let p1 = Promise.resolve(3);
let p2 = Promise.resolve(4);
let p3 = Promise.resolve(5);

Promise.all([p1, p2, p3])
  .then((values) => {
    console.log(values); // [3, 4, 5]
  })
  .catch((error) => {
    console.log(error); // 一つでも失敗すればエラー
  });
```


#### `Promise.race()`
例えば，複数のデータ取得方法のうち，最も早くデータが返ってきた方法を選びたい場合などに便利．

一方，`Promise.race()`は，渡された複数の`Promise`の中で**最初に解決（成功または失敗）した`Promise`**の結果を返す．これにより，最初に完了した非同期処理の結果を迅速に取得することができる．`Promise.race()`はどれか一つの`Promise`が解決または拒否された時点で処理が終了するため，処理速度が早い結果を求める場合に使用される．

```javascript
let p1 = new Promise((resolve, reject) => setTimeout(resolve, 500, 'p1'));
let p2 = new Promise((resolve, reject) => setTimeout(resolve, 100, 'p2'));

Promise.race([p1, p2])
  .then((value) => {
    console.log(value); // 'p2'（最初に解決したPromise）
  })
  .catch((error) => {
    console.log(error);
  });
```



### `Promise`のチェイニング

`Promise`は，`then()`メソッドをチェーンして複数の非同期処理を順番に実行することができる．これにより，複雑な非同期フローを扱いやすくなる．次の処理が前の処理の結果に依存する場合に役立つ．

```javascript
let promise1 = Promise.resolve(5);

promise1
  .then((result) => {
    console.log(result); // 5
    return result * 2;
  })
  .then((result) => {
    console.log(result); // 10
    return result + 3;
  })
  .then((result) => {
    console.log(result); // 13
  })
  .catch((error) => {
    console.log(error);
  });
```


### `finally()`メソッド
`finally()`メソッドは，`Promise`が成功または失敗に関係なく必ず実行される処理を指定できる．例えば，リソースの解放や終了処理など，成功・失敗に関わらず必ず実行したい処理に使用する．


```javascript
let promise2 = Promise.resolve(10);

promise2
  .then((result) => {
    console.log(result); // 10
    return result * 3;
  })
  .finally(() => {
    console.log('完了処理'); // 成功・失敗に関わらず実行される
  });
```




### `Promise`のエラーハンドリング
複数の`Promise`を扱う際，エラーハンドリングに注意が必要．`catch()`は通常，`Promise`のチェーンの最後にエラーをキャッチするが，`Promise.all()`などで複数の`Promise`が失敗した場合，最初に失敗した`Promise`がエラーを返す．この場合，残りの`Promise`がどうなるかも理解しておく必要がある．

```javascript

let p1 = Promise.resolve(3);
let p2 = Promise.reject('エラー発生');
let p3 = Promise.resolve(5);

Promise.all([p1, p2, p3])
  .then((values) => {
    console.log(values);
  })
  .catch((error) => {
    console.log(error); // 'エラー発生'
  });
```



### 非同期処理の並列実行
`Promise.all()`はすべての`Promise`が成功するまで待機するが，すべての`Promise`が非同期に実行されるため，並列で処理を実行できる．大量の非同期処理を一度に行いたい場合に有効．

```javascript
let promise1 = fetch('https://api.example.com/data1');
let promise2 = fetch('https://api.example.com/data2');

Promise.all([promise1, promise2])
  .then((responses) => {
    console.log('両方のリクエストが完了しました');
  })
  .catch((error) => {
    console.log('エラー:', error);
  });
```

### Promiseの用途と実際の使用例
`Promise`は，例えば非同期API呼び出し，ファイルの読み書き，タイマーやデータベースのクエリなどでよく使用される．実際の開発において，`Promise`を使うことで非同期コードをシンプルで理解しやすいコードにできる．

```javascript
fetch('https://api.example.com/data')
  .then((response) => response.json())
  .then((data) => {
    console.log(data);
  })
  .catch((error) => {
    console.log('エラー:', error);
  });
```



### Summary
 - `Promise`は非同期処理の成功・失敗を管理するオブジェクトであり，`pending`，`resolved`，`rejected`の3つの状態を持つ．
 - `then()`は成功時，`catch()`は失敗時，`finally()`は成功・失敗に関係なく実行される．
 - `async/await`を使うことで，非同期処理をより簡潔に記述できる．
 - Promise.all()はすべての`Promise`が完了するまで待機し，`Promise.race()`は最初に完了した`Promise`の結果を返す．
 - `Promise`のチェイニングを活用することで，複数の非同期処理を順番に実行できる．
 - `Promise`はAPI通信，ファイル操作，タイマー処理など，さまざまな非同期処理に利用される．


### 参考文献
 - MDN Web Docs Promise [https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/Promise](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/Promise)
 - JavaScript Primer 第二部:応用編 (ユースケース) Promiseを活用する [https://jsprimer.net/use-case/ajaxapp/promise/](https://jsprimer.net/use-case/ajaxapp/promise/)








