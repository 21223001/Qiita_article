
## In a nutshell

Pythonでコードを対話的に書ける「ノートブック形式」の環境はJupyter以外にも複数存在する．それぞれに特徴があり，初心者が目的や環境に応じて選ぶことが重要である．本記事では主要な7環境を比較した．


## はじめに
Pythonには「ノートブック形式」でコードを対話的に実行・記述できる環境が複数存在する．Jupyter Notebookが有名であるが，それ以外にも多様な選択肢がある事を知った．そこで，調べた事を以下に纏めた．ちなみに，ノートブック形式とは，コード・出力結果・文章(Markdown)を1つの画面にまとめて記述できる形式である．初学者でも理解しやすく実験的にコードを書ける利点がある．



## 予想される読み手
 - Python に関して初学者である
 - 対話的に Python を利用したい
 - Colab や Jupyter した利用した事が無い
 


### 1. Google Colab
Googleが提供するクラウドベースのノートブック環境であり，Jupyter Notebookと非常によく似たインターフェースを持つ．Pythonコードを即座に実行でき，Google Driveと連携可能である．

| 項目 | 内容 |
|------|------|
| インストール要否 | 不要(Webブラウザで利用) |
| 費用 | 無料(Pro版あり) |
| 容量 | Google Driveの容量を使用 |
| 動作快適性 | 軽快(クラウドGPUの恩恵あり) |
| GUI/CLI | GUI |


### 2. VS Code + Jupyter拡張  
Microsoftが開発する統合開発環境「Visual Studio Code」に，Jupyterの拡張機能をインストールすることでノートブック機能が利用可能となる．コード補完やLintなどの機能が充実しており，通常のPythonファイルとの切り替えも容易である．

| 項目 | 内容 |
|------|------|
| インストール要否 | 必要(VS Codeと拡張機能) |
| 費用 | 無料 |
| 容量 | 約300MB以上 |
| 動作快適性 | 快適(低スペックPCでも可) |
| GUI/CLI | GUI(CLIでも起動可) |


### 3. nteract  
Jupyter Notebookをベースとしたローカルアプリケーションである．インストール後すぐにPythonノートブックを起動できるシンプルな設計が特徴であり，初心者にも扱いやすい．

| 項目 | 内容 |
|------|------|
| インストール要否 | 必要 |
| 費用 | 無料 |
| 容量 | 約150MB前後 |
| 動作快適性 | 快適(ただし古いPCではやや重いことも) |
| GUI/CLI | GUI |


### 4. Deepnote  
クラウド型のノートブックサービスであり，Jupyter互換である．特にリアルタイム共同編集機能に優れ，教育現場やチーム開発にも適する．

| 項目 | 内容 |
|------|------|
| インストール要否 | 不要(Webブラウザで利用) |
| 費用 | 無料プランあり(Proは有料) |
| 容量 | クラウドに依存 |
| 動作快適性 | 良好(ブラウザに依存) |
| GUI/CLI | GUI |


### 5. Databricks Notebooks
Apache Sparkをベースとするビッグデータ処理向けのノートブック環境である．Pythonだけでなく，SQLやScalaなどの多言語もサポートしている．企業向け色が強いが，無料版でも使用可能である．

| 項目 | 内容 |
|------|------|
| インストール要否 | 不要(Webベース) |
| 費用 | 無料枠あり(本格利用は有料) |
| 容量 | クラウド環境依存 |
| 動作快適性 | 良好(Sparkクラスタ依存) |
| GUI/CLI | GUI(一部CLI連携可能) |


### 6. Polynote  
Netflixが開発したノートブック環境であり，複数言語の同時使用が可能である．セルごとに異なる言語(Python, Scalaなど)を記述できる点が特徴である．

| 項目 | 内容 |
|------|------|
| インストール要否 | 必要 |
| 費用 | 無料(オープンソース) |
| 容量 | 数百MB程度(Java依存) |
| 動作快適性 | 中程度(依存関係がやや複雑) |
| GUI/CLI | GUI(CLI操作も一部可能) |


### 7. Observable(※Pythonサポートは限定的)
もともとはJavaScript向けのWebノートブックであり，視覚化に強みを持つ．Pythonの利用は限定的であるが，データ可視化に特化した用途では検討の余地がある．

| 項目 | 内容 |
|------|------|
| インストール要否 | 不要(Webベース) |
| 費用 | 無料プランあり |
| 容量 | クラウド依存 |
| 動作快適性 | 良好 |
| GUI/CLI | GUI(Webベース) |


## 初学者へのおすすめ

| 用途 | 推奨環境 |
|------|----------|
| すぐに始めたい | Google Colab(インストール不要) |
| オフラインで学びたい | VS Code + Jupyter拡張 or nteract |
| チームでの学習 | Deepnote(共有・共同編集が簡単) |
| 大規模データ処理を想定 | Databricks または Polynote |


## Summary

 - ノートブック形式はコード・結果・文章を一体で扱える初心者向け形式である
 - Jupyter以外にColab, VS Code, Deepnoteなどの選択肢がある
 - 各環境はクラウド/ローカル，費用，動作快適性に差がある
 - 目的別に適した環境を選ぶことで，学習効率が大きく向上する


## References

[Google Colaboratory](https://colab.research.google.com/)
[Visual Studio Code](https://code.visualstudio.com/)
[nteract Project](https://nteract.io/)
[Deepnote](https://deepnote.com/)
[Databricks](https://databricks.com/)
[Polynote by Netflix](https://polynote.org/)
[Observable](https://observablehq.com/)

