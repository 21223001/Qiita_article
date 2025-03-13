
「Webソケット（WebSocket）」という言葉を聞いたことはあるけれど，良く知らなかった．
そこで，Webソケットの基本的な仕組みや，何ができるのかを以下に簡単に纏めた．


### 要点
Webソケット とは，リアルタイム通信を可能にする技術
通常のHTTP通信とは違い，一度接続すると双方向通信が可能
チャットアプリやオンラインゲームなどで活用されている
Node.jsなどを使うと簡単に実装できる
Webソケットを活用すれば，よりインタラクティブで快適なWebアプリを作れるようになる．



### Webソケットとは？
Webソケット（WebSocket） とは，クライアント（ブラウザ）とサーバーの間で リアルタイム通信 を行うための技術．
通常のWebページは，ユーザーがクリックしたときにサーバーへリクエストを送り，その結果を受け取る 「リクエスト & レスポンス方式」 で動作する．
しかし，この方法では常に最新の情報を取得するために何度もリクエストを送る必要があり，効率が悪い．
Webソケットでは，一度接続を確立すると，サーバーとクライアントが 双方向通信 をリアルタイムで行える．


![DALL·E 2025-02-18 23.24.21 - A surreal illustration of a single electrical cord plugged into two different sockets at the same time. The cord splits unnaturally in the middle, for.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3830184/eb114e85-4171-446e-acec-be26afb81726.jpeg)
双方向な写真にしたかった

### 具体的にどう違うの？
通常のWebの通信（HTTP）とWebソケットの違いを，チャットアプリを例とする

#### 従来のWeb（HTTP通信）
ユーザーが「送信」ボタンを押す
ブラウザがサーバーへリクエストを送る
サーバーがレスポンスを返す
ページをリロードしないと，新しいメッセージが表示されないことも
→ サーバーに何度もリクエストを送るため，通信が増え，無駄が多い

#### Webソケットを使った場合
Webソケットの接続を確立する（最初の1回だけ）
ユーザーがメッセージを送ると，そのままサーバーに送信される
サーバー側も即座に他のクライアントにメッセージを配信
新しいメッセージがリアルタイムで自動表示される
→ ページをリロードしなくても，新しい情報がすぐに反映される


### Webソケットの活用例
Webソケットは，リアルタイム通信が求められる様々なシステムで活用されている．

例：
チャットアプリ（LINEやSlackのようなリアルタイムメッセージング）
オンラインゲーム（プレイヤーの動きやスコアの同期）
株価や仮想通貨のリアルタイム更新（取引所の価格表示）
オンライン会議（Zoomのような音声・映像のやり取り）
スポーツの試合速報（試合中のスコアやプレイ状況の更新）



### 簡単なWebソケットのコード例

サーバー側（Node.js + WebSocket）
まず，Node.jsを使って簡単なWebSocketサーバーを作成する．

```
const WebSocket = require('ws');
const server = new WebSocket.Server({ port: 3000 });

server.on('connection', socket => {
    console.log('クライアントが接続しました');

    socket.on('message', message => {
        console.log(`受信: ${message}`);
        socket.send(`サーバーからの返信: ${message}`);
    });

    socket.on('close', () => {
        console.log('クライアントが切断しました');
    });
});
```

クライアント側（ブラウザのJavaScript）
ブラウザからWebソケットに接続し，メッセージを送受信する簡単なコード．
```
const socket = new WebSocket('ws://localhost:3000');

socket.onopen = () => {
    console.log('サーバーに接続しました');
    socket.send('こんにちは，サーバー！');
};

socket.onmessage = event => {
    console.log(`受信: ${event.data}`);
};

socket.onclose = () => {
    console.log('接続が切断されました');
};
```

このコードを実行すると，ブラウザから送ったメッセージに対して，サーバーが返信する簡単なWebソケット通信が動作する



### 参考文献
 - WebSocket 公式仕様
IETF (Internet Engineering Task Force)
RFC 6455: The WebSocket Protocol
WebSocketの正式な仕様を定めた文書．プロトコルの詳細について記述されている．
MDN Web Docs (Mozilla Developer Network)
[https://tex2e.github.io/rfc-translater/html/rfc6455.html](https://tex2e.github.io/rfc-translater/html/rfc6455.html)

 - Mozilla Foundation
WebSockets - MDN Web Docs
WebSocket APIの基本的な説明や，ブラウザでの実装方法について詳しく解説されている．
[https://developer.mozilla.org/ja/docs/Web/API/WebSockets_API](https://developer.mozilla.org/ja/docs/Web/API/WebSockets_API)


 - Google Developers
WebSockets: A Conceptual Deep Dive
HTTPとの違いや，パフォーマンスのメリットなどについての技術解説．

 - npm (Node Package Manager)
ws - A WebSocket implementation for Node.js
WebSocketサーバーをNode.jsで構築するためのライブラリ「ws」に関する公式ドキュメント．
[https://www.npmjs.com/package/ws](https://www.npmjs.com/package/ws)


 - Google Cloud
Building real-time applications using WebSockets
WebSocketsを使った実際のアプリケーション事例（チャット，ゲーム，データストリーミングなど）．


 - CSS-Tricks
An Introduction to WebSockets
WebSocketの仕組みと使い方についてのわかりやすい解説記事．


 - 『Real-Time Web Apps: With HTML5 WebSockets, PHP, and jQuery』
著者: Jason Lengstorf
出版社: Apress
WebSocketを活用したリアルタイムWebアプリの実装方法についての解説書．
