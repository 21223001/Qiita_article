
YAMLについて，なんとなくでしか知らなかったので，適切に理解をする必要があると感じた．
そこで，特にJSONとの違いを理解する必要がある為に以下に纏めた．
主観だが，JSONと比較をして，インデントで構造を作成できる事，コメントアウトが可能な事は，感覚的に非常に利用し易いと感じる．

## In a nutshell
YAMLは設定ファイルやデータ構造の記述に適したフォーマットであり，JSONよりも可読性が高い．
バックエンドやDevOps（Kubernetes, Ansible, CI/CDなど）で頻繁に利用される．
ただし，スキーマバリデーションがなく，ネストが深くなると可読性が低下する点には注意が必要．


## YAMLの特徴
1. **シンプルで読みやすい**
   - インデント(スペース)を使って階層を表現する．
   - JSONやXMLに比べて直感的に理解しやすい．

2. **キーと値のペア**
   - `key: value` の形式でデータを記述する．

3. **リスト(配列)を簡単に記述**
   - `-`(ハイフン)を使ってリストを表現．

4. **コメントが書ける**
   - `#` を使ってコメントを記述できる．

5. **拡張性が高い**
   - YAMLファイルは多くのプログラミング言語でサポートされており，設定ファイルやデータのシリアライズに適している．


## 基本的な書き方

### キーと値のペア
```yaml
name: Yamada Taro
age: 30
email: Yamada@example.com
```

### リスト(配列)
```yaml
OS:
  - Windows
  - Mac
  - Ubuntu
```


### ネスト
```yaml
person:
  name: Yamada
  age: 25
  address:
    city: Tokyo
    country: Japan
```



### 複数行の文字列
```yaml
description: |
  This is a multi-line string.
  It preserves line breaks.

message: >
  This is also a multi-line string,
  but it will be collapsed into a single line.
```



### 変数の参照
```yaml
defaults: &default_settings
  theme: dark
  language: en

user1:
  <<: *default_settings
  name: Yamada

user2:
  <<: *default_settings
  name: Sasaki
  language: jp
```


### データ型
```yaml
# 文字列
string: "Hello, YAML"

# 数値
integer: 42
float: 3.14

# 真偽値
boolean_true: true
boolean_false: false

# null値
null_value: null  # または ~

# 配列(リスト)
list:
  - item1
  - item2
  - item3

# マップ(辞書)
dictionary:
  key1: value1
  key2: value2
```


### 環境変数
```yaml
database:
  user: ${DB_USER}  # 環境変数 DB_USER を参照
  pass: ${DB_PASS}  # 環境変数 DB_PASS を参照


```




## 関係が深い事

### バックエンド側(Python, Node.js, 等)
**YAMLと関係が深い**

#### 設定ファイル
 - PythonやNode.jsのアプリケーションでは，設定をYAMLで管理することが多い．
 - 例: `config.yaml` に設定情報を記述し，Python (PyYAML) やNode.js (js-yaml) で読み込む．

#### CI/CDの設定
 - GitHub Actions (`.github/workflows/*.yaml`) や GitLab CI (`.gitlab-ci.yml`) はYAMLで設定を書く．

#### API定義(OpenAPI)
 - REST APIの仕様をYAMLで記述し，Python (FastAPI, Flask) やNode.js (Express) で利用する．



### データベース
**YAMLと関係が深い**

#### データベース設定
`database.yaml` などに接続情報（DB名，ユーザー，パスワード）を記述し，PythonやNode.jsがそれを読み込む．

```yaml
database:
  host: localhost
  user: root
  password: secret
  name: mydb
```

#### データマイグレーションツール
db-migrate や Liquibase などのツールでYAMLを使うことがある．


### フロントエンド側(Javascript, 等)
**YAMLとは関係が浅い**
フロントエンド側ではあまり利用されない．

#### 設定管理
 - フロントエンドの設定は通常 `.env` や JSON，JavaScript ファイルで管理することが多い．
 - Vue.js では `.env` や `config.js` を使う為，YAMLを使うことはほぼない．


#### データ通信
 - JSONが主流であり，YAMLで通信することは殆ど無い．


### DevOps・インフラ管理
**YAMLとは関係が深い**
インフラ管理や自動化に広く利用される．

#### Kubernetes
PodやServiceの設定 をYAMLで記述

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 3
  template:
    spec:
      containers:
        - name: app
          image: my-app-image
```



#### Docker Compose

複数のコンテナ構成を記述するための `docker-compose.yml` で使用

```yaml
version: "3.8"
services:
  web:
    image: nginx
    ports:
      - "80:80"
```

#### Ansible
サーバー構成管理のプレイブック で利用

```yaml
- hosts: webservers
  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present
```



### CI/CD
**YAMLとは関係が深い**
CI/CDパイプラインの設定にYAMLが良く利用される．

#### GitHub Actions

`.github/workflows/*.yaml` にワークフローを記述

```yaml
name: CI/CD Pipeline
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run tests
        run: npm test
```


#### GitLab CI/CD

`.gitlab-ci.yml` にCI/CDの設定を書く

```yaml
stages:
  - test
  - deploy

test_job:
  stage: test
  script:
    - npm test
```


### API管理・ドキュメント
**YAMLとは関係が深い**
APIの設計・ドキュメント化 で頻繁に使われる

#### OpenAPI（Swagger）
REST APIの仕様をYAMLで記述してSwagger UIなどで可視化できる

```yaml
openapi: 3.0.0
info:
  title: Sample API
  version: 1.0.0
paths:
  /users:
    get:
      summary: Get all users
      responses:
        200:
          description: Success
```



## YAMLとJSONの違い

| 項目      | YAML                  | JSON                  |
|----------|----------------------|----------------------|
| 可読性    | 高い(直感的)       | 低い(括弧が多い)   |
| 階層表現  | インデントで表現      | `{}`(中括弧)を使用 |
| コメント  | `#` で可能           | できない              |
| サポート | 設定ファイル，API設定 | Web，データ転送      |



## YAMLの活用例
- **アプリケーションの設定ファイル**
  - 例: `config.yaml`
- **CI/CDツールの設定**
  - 例: GitHub Actions (`.github/workflows/*.yaml`)，GitLab CI (`.gitlab-ci.yml`)
- **Kubernetesの設定**
  - 例: `deployment.yaml`
- **Ansibleのプレイブック**
  - 例: `playbook.yml`


## YAMLの注意点
### インデントは必ずスペースを使う
- **タブはNG**(エラーの原因になる)


### コロンの後にはスペースを入れる
```yaml
key: value  # OK
key:value   # NG
```


### データ型を明確にする
```yaml
version: "1.0"  # 文字列(OK)
version: 1.0    # 数値(意図しない型になる場合あり)
```


### boolは`true`or`false`とする
```yaml
enabled: true  # OK
enabled: yes   # NG(ソフトによってはエラー)
```


### その他の制限や欠点

 - パースエラーが起こりやすい
上記にもあるが，インデントにタブを使うとエラーとなる為，**必ずスペースを使用する**必要がある．

 - スキーマバリデーションがない
JSON等のように厳格なスキーマチェックが無い為，間違ったデータ形式を入力してもを入れても気付きにくい．JSON Schemaなどを利用してバリデーションを行う事も可能．

 - 複雑なデータ構造では可読性が低下する
YAMLは人が読みやすい形式として規定されているが，ネストが深くなると可読性が低下する．


### Summary
 - YAMLは設定ファイルやデータ管理に適したフォーマットで，JSONよりも可読性が高い．
 - バックエンド（Python, Node.js） や DevOps（Kubernetes, Ansible） で広く使われる．
 - CI/CD（GitHub Actions, GitLab CI） や API仕様（OpenAPI） でも重要な役割を持つ．
 - スキーマバリデーションがない ため，誤ったデータを記述しても気づきにくい．
 - ネストが深くなると可読性が低下 し，複雑なデータ構造には向かない．
 - Web APIのデータ通信ではJSONが主流だが，API仕様の管理にはYAMLが適している．


## 参考文献

 - YAML公式ドキュメント. YAML Ain’t Markup Language (YAML™) Version 1.2 Specification. YAML.org.
[https://yaml.org/spec/](https://yaml.org/spec/)

 - JSON公式ドキュメント. Introducing JSON. JSON.org.
[https://www.json.org/json-en.html](https://www.json.org/json-en.html)

 - PyYAMLドキュメント. PyYAML Documentation. PyYAML.
[https://pyyaml.org/wiki/PyYAMLDocumentation](https://pyyaml.org/wiki/PyYAMLDocumentation)

 - js-yamlリポジトリ. js-yaml: YAML 1.2 parser and serializer for JavaScript. Nodeca.
[https://github.com/nodeca/js-yaml](https://github.com/nodeca/js-yaml)

 - Kubernetes公式ドキュメント. Configuration Overview. Kubernetes.io.
[https://kubernetes.io/docs/concepts/configuration/overview/](https://kubernetes.io/docs/concepts/configuration/overview/)

 - Docker公式ドキュメント. Compose file reference. Docker Docs.
[https://docs.docker.com/reference/compose-file/](https://docs.docker.com/reference/compose-file/)

 - Ansible公式ドキュメント. Playbooks: Ansible User Guide. Ansible Docs.
[https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_intro.html](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_intro.html
)

 - GitHub Actions公式ドキュメント. Understanding GitHub Actions. GitHub Docs.
[https://docs.github.com/en/actions](https://docs.github.com/en/actions)

 - GitLab CI/CD公式ドキュメント. CI/CD YAML Configuration Reference. GitLab Docs.
[https://docs.gitlab.com/ee/ci/yaml/](https://docs.gitlab.com/ee/ci/yaml/)

 - OpenAPI (Swagger)公式ドキュメント. OpenAPI 3.0 Specification Basics. Swagger.io.
[https://swagger.io/docs/specification/v3_0/basic-structure/](https://swagger.io/docs/specification/v3_0/basic-structure/)

