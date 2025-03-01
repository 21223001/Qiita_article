## In a nutshell
JavaScriptの"."（ドット）は，オブジェクトや配列などのプロパティやメソッドにアクセスするための演算子である．

### 詳細な説明

JavaScriptにおける"."（ドット）は，主にオブジェクトのプロパティやメソッドを呼び出すために使用される．例えば，`AA.BB.cc`というコードがある場合，それは次のように解釈できる．

1. **オブジェクトのプロパティアクセス**
   - `AA` はオブジェクトであり，その中に `BB` というプロパティが存在する．
   - `BB` はさらにオブジェクトまたは値を持ち，その中に `cc` というプロパティが存在する．
   - この場合，`AA.BB.cc` は，まず `AA` オブジェクトの `BB` プロパティにアクセスし，次にその `BB` プロパティが持つ `cc` プロパティにアクセスすることを意味する．

2. **オブジェクトのメソッドアクセス**
   - `AA.BB.cc` の `cc` が関数であった場合，`AA.BB.cc()` はその関数を呼び出すことを意味する．
   - 例えば，`AA.BB.cc` が `function() { return "Hello"; }` という関数であれば，`AA.BB.cc()` は `"Hello"` を返す．


### 例

Hello.World は Hello オブジェクトの World プロパティにアクセスして，その値である "Hello, World" を返す
```
// オブジェクトのプロパティへのアクセス
const Hello = {
  World: "Hello, World"
};

console.log(Hello.World); // Hello, World
```



この場合，Hello.World() は Hello オブジェクトの World メソッドを呼び出して，その結果である "Hello, World" を返す．
```
// メソッドの呼び出し
const Hello = {
  World: function() {
    return "Hello, World";
  }
};

console.log(Hello.World()); // Hello, World
```



Summery
JavaScriptにおける"."（ドット）は，オブジェクトのプロパティやメソッドにアクセスするための演算子である．AA.BB.ccという形式で使用される場合，AAはオブジェクトで，BBはそのプロパティ，ccはさらにそのプロパティまたはメソッドを示している．




### 参考文献
 - MDN Web Docs: JavaScript のオブジェクト [https://developer.mozilla.org/ja/docs/Web/JavaScript/Guide/Working_with_objects](https://developer.mozilla.org/ja/docs/Web/JavaScript/Guide/Working_with_objects)
 - MDN Web Docs: JavaScript 関数 [https://developer.mozilla.org/ja/docs/Web/JavaScript/Guide/Functions](https://developer.mozilla.org/ja/docs/Web/JavaScript/Guide/Functions)

