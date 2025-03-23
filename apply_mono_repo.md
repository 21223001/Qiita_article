


## In a nutshell



## はじめに


## 予想される読み手


## 事前知識

### レポジトリとは



### モノレポとは





### 目的
- 外部リポジトリの **履歴も含めて** 取り込む（履歴の保持が重要）
- 自分のリポジトリ（メイン）に取り込んで **モノレポ化** したい
- 取り込んだ後は、外部レポジトリは **不要になる（削除OK）**
- 外部レポジトリの内容は、サブディレクトリとして取り込みたい（例：`external_repo/`）


###  最適な方法：`git subtree` 

`git subtree` を使うと、外部リポジトリを指定したサブディレクトリに取り込み、履歴も保持できます。  
しかも `submodule` と違い、独立して管理でき、**取り込んだ後は削除してOK**。


### なぜ `git subtree` なのか

外部レポジトリの履歴（コミットログなど）を保持できる．
コミットログは `.git`フォルダに保存されており，レポジトリと1対1で対応している．よって，単にデータをコピーしても，履歴は引き継げない．





### 🔧 手順（例：`external_repo` という名前のサブディレクトリに取り込む）

```bash
# 1. 自分のモノレポのリポジトリに移動
cd your-main-repo

# 2. 外部リポジトリをリモートとして追加（名前は何でもよい）
git remote add external_repo https://github.com/ユーザー名/外部レポジトリ.git

# 3. 外部リポジトリのデータを取得（fetch）
git fetch external_repo

# 4. 外部リポジトリの履歴を指定ディレクトリに subtree としてマージ
git subtree add --prefix=external_repo external_repo/main --squash
# ↑ブランチ名が main でない場合は変更してください（たとえば master）

# --squash を外せば履歴を詳細に残す（全履歴保持）
# --squash を使えば1つのコミットとしてまとめる（軽量化）
```

> ✅ `--prefix=external_repo` は、「外部の中身を `external_repo/` フォルダに入れる」指定

---

### 🚮 取り込み後にやること（外部リポジトリ削除）

```bash
# もう外部リポジトリはいらない場合
git remote remove external_repo
```







### 💡 補足：`subtree` のメリット

- `submodule` と違い、clone したときに追加設定が不要
- 履歴が保持される（--squash を使わなければフルログ）
- 将来、`subtree pull` や `push` で同期も可能（今回は削除予定なので不要）


必要なら、`git subtree split` を使って元に戻す（分離する）ことも可能です。  
この方法でモノレポ化はかなり柔軟にできます。



## Summary




## References



