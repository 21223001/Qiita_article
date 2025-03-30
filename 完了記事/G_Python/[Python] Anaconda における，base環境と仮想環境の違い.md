

## In a nutshell
Anacondaのインストール時にPythonも自動的にインストールされる．仮想環境では独立したPythonが利用され，baseのPythonは使い回されない．開発や分析は仮想環境で行い，baseは管理用途に限定するのが安全．


## はじめに
Anacondaを利用して仮想環境を作成する際には，必ずPythonを個別にインストールする必要がある．しかし，Anacondaをインストールした際には標準でPythonもインストールされていた事に気が付いた．仮想環境を作成する際にPythonのインストールをするのであれば，Anacondaのセットアップ時にPythonをインストールする事に対して疑問を感じた．そこで，以下の記事を記述した．


## 予想される読み手
 - Anaconda及びPythonを利用しているが，環境の作成はチュートリアル通りで，理解している訳ではない．
 - 複数の仮想環境とbase環境の違いについて，よく分からない．
 - Anacondaをインストールすると，別のツールでもPythonが利用できるようになるが，なぜか説明できない．


## Anacondaのインストール時
Anacondaをインストール際にはPython本体も自動的にインストールされる．一般には最新の安定版のPythonがインストールされる．NumPy，Pandas，Jupyter等の汎用性の高いライブラリも初期にインストールされる．この初期のPythonは，base環境(base)で使用される．各仮想環境のPythonとbase環境は独立している．このPython本体は，Anacondaをインストールしたディレクトリ(例：`C:\Users\ユーザー名\anaconda3`)内に保存されている．その中の，`python.exe` がbase環境専用のPythonである．


## 新規の仮想環境の作成時
バージョンを指定しなければ，その時点での最新のバージョン(Anacondaが管理するデフォルトバージョン)のPythonがインストールされる．`conda create -n 環境名 python=3.9` のようにバージョンの指定が可能．


## base環境のPythonは他で使わないのか？
基本的には，base環境専用である．仮に，base環境に多くのライブラリをインストールすると，依存関係の衝突や不具合の原因になりやすい．その為，baseは極力クリーンに保ち，プロジェクトごとに仮想環境を使い分けるのが望ましい．

### base環境の主な用途
- 仮想環境の作成や管理(`conda create` や `conda install` など)
- 軽いスクリプトや一時的な動作確認
- Anaconda Navigator や Jupyter Notebook の起動

### 推奨される管理方針
- 不要なライブラリは入れない(ライブラリのテストは仮想環境で行う)
- conda本体やconda-buildなど，Anacondaの中核ツールのアップデートは慎重に行う
- トラブルが起きたら `conda update conda` や `conda clean` で復旧できることもある

### トラブル時の対処法
- `conda list` でインストール状況確認
- `conda info --envs` で環境一覧を確認
- `conda deactivate` → `conda activate base` で戻す



## base環境と外部ツールとの連携で注意すべき点
外部ツール(VSCode，PyCharm，Jupyter Notebook，CLIツールなど)とAnacondaのPython環境を連携させる際，以下の点に注意が必要である．

### パスの指定と環境の誤認識
多くの外部ツールは，最初に `PATH` に登録された `python.exe` を自動検出する．
Anacondaをインストールした際，base環境のPythonがシステムに登録されるため，意図せずbase環境を使ってしまうことがある．

#### 対策
- VSCodeなどでは，仮想環境を明示的に選択する必要がある(例：コマンドパレット -> `Python: Select Interpreter`)．
- ターミナル起動時には `conda activate 環境名` を忘れずに実行する．
- `.condarc` や `.bashrc` に自動アクティベート設定を追加するのも一つの手．

### Jupyter Notebookのカーネルに仮想環境を追加する方法
仮想環境でJupyterを使いたい場合，仮想環境にカーネルを登録する必要がある．登録後にJupyter上で「Python (myenv)」を選べば仮想環境を使う事が出来る．

```bash
conda activate myenv
python -m ipykernel install --user --name myenv --display-name "Python (myenv)"
```


## 使われ方のまとめ

| 用途                     | 推奨環境         |
|--------------------------|------------------|
| condaのコマンド実行        | base             |
| データ解析・開発プロジェクト | 専用の仮想環境    |
| 複数プロジェクト管理       | 仮想環境ごとに分ける |


## Summary
- Anacondaインストール時にPython本体と主要ライブラリが含まれる  
- 仮想環境はPythonごと独立しており，baseとは切り離されている  
- base環境は仮想環境の管理やJupyter起動用に利用するのが望ましい  
- 外部ツールと連携する際は仮想環境を明示的に選択する必要がある  
- Jupyterで仮想環境を使うにはカーネルの登録が必要  
- base環境はクリーンに保ち，依存関係の衝突を避ける



## References
 - [Conda  User guide > Tasks > Managing environments — Official Docs](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html)
 - [Anaconda  Getting Started > Distribution Installing Anaconda Distribution - Installation Guide](https://www.anaconda.com/docs/getting-started/anaconda/install)


