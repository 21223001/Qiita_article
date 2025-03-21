### 目的

**認証**（Authentication）と **認可**（Authorization）は，それぞれ異なる役割を持っており．以下でその違いを簡単に説明する．

#### 結論
認証は本人確認，認可は権限の確認．したがって，認証後に認可を行う流れとなる．


---

### 認証 (Authentication)
認証は，**ユーザーが誰であるか**を確認するプロセスである．あるユーザーからアクセスがあった際に，その**ユーザーが本物**であることを確認する．

- 目的 : ユーザーの身元を確認する
- 質問 : 「あなたは誰ですか？」
- 例
  - ユーザー名とパスワードによるログイン
  - 生体認証（指紋，顔認証など）


### 認可 (Authorization)
認可は，**認証されたユーザーがどのリソースにアクセスできるか**を決定するプロセス．ユーザーがシステム内で行える操作やアクセスできるデータを制限する．

- 目的 : ユーザーが実行できる操作やアクセスできるリソースを管理する
- 質問 : 「あなたには何をする権限がありますか？」
- 例
  - ユーザーが特定のファイルを編集する権限を持っているかどうか
  - 管理者と一般ユーザーに異なるアクセス権を設定する


---


### 認証と認可の関係
認証は認可の前提条件である．ユーザーが正しく認証されていなければ，認可のプロセスが成立しない．
つまり，**認証が成功して初めて認可のプロセスを経る**．これによりユーザーの権限が決まる．


---


### 開発における認証と認可の違いを意識する必要がある場合

開発の際，認証と認可を区別して考えることが重要である．
以下のようなシチュエーションでは，その違いを意識する必要がある．

#### 1. **APIの設計**
   - RESTful APIでは，認証は通常，トークン（例えばJWT）を用いて行われる．認証後，APIはそのトークンを使ってリクエストが正当なものかを確認する．その後，認可を行ってユーザーのアクセス権限に基づいた処理を行う．
   - 例: ユーザーが特定のリソースにアクセスできるかどうかは，認証が成功した後の認可処理で決定される．

#### 2. **ユーザー管理システム**
   - システムで異なる役割（例えば，一般ユーザー，管理者）を持つユーザーがいる場合，それぞれの役割に応じてアクセス制限を設定する必要がある．認証後，認可を行ってそのユーザーが特定の機能にアクセスできるかどうかを判断する．

#### 3. **セキュリティの強化**
   - 特定のリソースにアクセスするために多要素認証（MFA）を使うことがあります．この場合，認証後に追加の確認を行うことがあり，認可処理に影響を与える場合があります．認証の強化と認可の設定を適切に組み合わせることで，セキュリティが強化できる．

#### 4. **権限の細かい制御**
   - 高度な権限管理が必要なアプリケーション（例えば，企業内システム）では，認証が成功した後に細かいアクセス制御が必要となる．ユーザーがどのリソースにアクセスできるかを認可で制御する．

総じて，開発中に認証と認可の違いを意識することで，セキュリティがしっかりと管理され，予期せぬアクセス問題を防ぐことができる．
