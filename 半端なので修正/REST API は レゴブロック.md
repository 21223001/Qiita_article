APIについて，何かしらの情報を渡すために使うもの，程度の理解しかなかった．
RestfulなAPIを理解する為に，イメージを重視してAPIから考える．


### API 自体
APIはインターフェイスである．

https://qiita.com/molecular_pool/items/f5b0c267fb9dfad53035




### REST API 
REST API（Representational State Transfer API）
HTTPプロトコルを利用してリソース（データ）をやり取りするためのインターフェースである．

RESTfulなAPIは，以下の特徴を持つ．
 - リソース指向
REST APIでは，すべてのエンドポイントがリソース（データの対象）を指し，それらはURL（Uniform Resource Locator）によって一意に識別される．

 - HTTPメソッドの利用
REST APIでは，以下のHTTPメソッドを用いて適切な操作を行う．
GET: リソースの取得
POST: 新しいリソースの作成
PUT: 既存リソースの更新
DELETE: リソースの削除

 - ステートレス
各リクエストが独立しており，サーバー側で状態を保持しないことが原則である．すべての情報はリクエスト内に含まれており，サーバー側でセッションを管理しない．つまり使い捨てである．

 - REST APIとCRUDの関係
CRUD（Create, Read, Update, Delete）は，データの基本操作を表す概念であり，REST APIのHTTPメソッドと一致する．
Create → POST
Read → GET
Update → PUT
Delete → DELETE
REST APIは，HTTPメソッドを用いることでCRUD操作を実現する．そのため，REST APIはCRUD原則に則った設計となる．

 - Webアプリ間の通信とAPI
WebアプリAとBが通信する場合，それぞれにAPIがインターフェースとして存在し，実際の通信はHTTPを介して行われる．例えば，WebアプリAがWebアプリBのAPIを呼び出し，データを取得・更新する．




### REST APIの役割と制限
REST APIはCRUDに基づいたデータのやり取りを行うが，単純なデータ操作にとどまらず，認証やデータフィルタリング，集計などの高度な処理も可能である．
REST APIは「基本的なデータのやり取り」のみを行うわけではなく，CRUDを基盤として，より複雑なビジネスロジックを実装することができる．


### REST APIの簡単なイメージ
REST APIは，限られた基本操作（CRUD）を組み合わせて，さまざまな機能を構築する「レゴブロック」のようなイメージである．基本的なHTTPメソッドを組み合わせることで，柔軟なシステム設計が可能となる．


## APIを自作する方法

### 1. 設計
- どのデータをどのように提供するかを設計する．
- 例: 「ユーザー情報を取得するAPIを作成する」

### 2. バックエンドの実装
- APIを提供するためのサーバーを構築する．
- Node.js（Express），Django，Flask などのフレームワークを使用可能．

### 3. ルーティングの設定
- どのURLにリクエストを送ればどのデータが取得できるかを定義する．

### 4. レスポンスの設計
- 返却するデータのフォーマットを決める（例: JSON）．

### 5. エラーハンドリング
- 例: ユーザーが存在しない場合，`404 Not Found` を返す．

---

## API開発時の注意点

### 1. セキュリティ
- **認証・認可**: APIキーやOAuthを活用する．
- **CORS（Cross-Origin Resource Sharing）**: 不正なアクセスを防ぐ設定が必要．

### 2. エラーハンドリング
- 適切なエラーメッセージを返す．
- HTTPステータスコードを正しく利用する（例: `200 OK`, `400 Bad Request`）．

### 3. バージョン管理
- 既存のAPIを壊さないよう，`/v1/` などのバージョンを付与する．

### 4. ドキュメント作成
- APIの利用者向けに，エンドポイント，リクエスト・レスポンスの形式を明記する．





### 参考文献
 - Fielding, Roy. "Architectural Styles and the Design of Network-based Software Architectures." (2000).
 - "RESTful Web APIs" - Leonard Richardson, Mike Amundsen, Sam Ruby (O'Reilly Media, 2013).
 - "API Design Patterns" - JJ Geewax (Manning Publications, 2021).
 - GraphQL公式ドキュメント: [https://graphql.org/](https://graphql.org/)
 - REST API設計のベストプラクティス: [https://restfulapi.net/](https://restfulapi.net/)
 - WebSocketの基本: [https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API](https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API)
 - HTTP/1.1 Specification: [https://www.rfc-editor.org/rfc/rfc2616](https://www.rfc-editor.org/rfc/rfc2616)










