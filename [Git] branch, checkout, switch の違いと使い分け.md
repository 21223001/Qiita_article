

## In a nutshell
ブランチ自体の属性や振る舞いは `branch` を用いる，ブランチ間の操作は `checkout`, `switch` を用いる，特に，切り替えに特化したのが `switch` である


## はじめに
Gitには，新規ブランチを切る，ブランチを変える，等の作業がある．これまでは，`git checkout`, `git checkout -b new`でブランチ間を移動して，ブランチの削除は`git branch -d old`としていた．しかし，`git switch`が存在する事も知っており，良い機会なので，適切に纏める事にした．また，個人的な忘備録としても利用できる事を目指した．




## 想定される読み手
 - Git について，あまり詳しくない
 - 現在 Git を利用しており，今後も利用していく予定である．
 - Git の運用自体は限られたコマンドで定型的に行えるが，複数の方法の違いと使い分けは出来ていない．




## `branch`, `checkout`, `switch` の違い

簡単に纏めると以下である．詳しい説明は別の項で記述した．
 - `git branch` : ブランチの **管理** を扱う 
 - `git checkout` : ブランチの間を**多用途**に扱う． 
 - `git switch` : ブランチの**切り替え専用**である． 



## `git branch` について

`git branch` はブランチの**管理**専用コマンドである．  
具体的には，以下のような使い方がある．

#### ブランチの一覧表示
```bash
git branch

# * DEV   (*が付いているのが現在のbranch)
#   main
```

#### ブランチの作成（切り替えなし）
```bash
git branch new_branch

# (出力無し) new_branch が追加される
```

#### ブランチの削除（安全な削除）
```bash
git branch -d old-branch

# Deleted branch old_branch (was 54db678).
```

#### ブランチの削除（強制削除）
```bash
git branch -D old-branch

# Deleted branch old-branch (was 7271d6d).
```







## `git checkout` について

`git checkout` は多機能な万能コマンドである．  
具体的には，以下のような使い方がある．

#### ブランチの切り替え
```bash
git checkout main

# Switched to branch 'main'
# Your branch is up to date with 'origin/main'.
```

#### 新規ブランチの作成，及び，切り替え
```bash
git checkout -b newBranchName

# Switched to a new branch 'newBranchName'
```

#### ファイルを元の状態に戻す（HEADや他のブランチ、コミットから復元）
```bash
git checkout -- index.html              # 最新コミットの状態に戻す
git checkout abc1234 -- index.html      # 特定のコミットから復元
git checkout main -- index.html         # 他のブランチのファイルを取得
```

#### 一時的に過去のコミットに移動（detached HEAD）
この状態ではブランチにいない為，新規コミットをしてもブランチには記録されない．

```bash
git checkout abc1234
```




## `git switch` について

`git switch` はブランチの切り替え専用である．
比較的新しいコマンドであり，`checkout` よりも安全に利用できるようになった．




#### 既存ブランチへの切り替え
```bash
git switch main

# Switched to branch 'main'
```

#### 新しいブランチの作成，及び，切り替え
```bash
git switch -c new_branch

# Switched to a new branch 'new_branch'
```

#### リモートブランチをローカルに作成して切り替える
```bash
git switch -c feature-x origin/feature-x
```




## コマンドまとめ

| 操作 | コマンド |
|------|----------|
| ブランチの切り替え | `git switch` or `git checkout` |
| 新規ブランチ作成＋切り替え | `git switch -c` or `git checkout -b` |
| 新規ブランチ作成（切り替えなし） | `git branch` |
| ブランチ一覧の表示 | `git branch` |
| ブランチ削除 | `git branch -d` / `-D` |
| ファイルの復元 | `git checkout` or `git restore` |


## 使い分けの目安

- ブランチ名の確認、作成、削除：→ `git branch`
- 既存ブランチへの移動：→ `git switch ブランチ名`
- 新規ブランチを作って移動：→ `git switch -c 新ブランチ名`
- 過去コミットの状態を見たい：→ `git checkout <コミットID>`
- ファイルを元の状態に戻したい：→ `git restore`（または `checkout`）






## 補足

`restore` コマンド

`detached HEAD` 




## Summary



## References

 - [Git 公式ドキュメント](https://git-scm.com/doc)
 - [GIt Book  Pro Git 2nd Edition(2014)](https://git-scm.com/book/ja/v2)






以下が「`git switch` の項」の**追記分のみ**です。

---



#### よくあるエラー例とヒント
`git switch` は安全性を重視しているため，ブランチが存在しない場合や既に存在する名前で新規作成しようとした場合などに明確なエラーが出る．  
これは，無意識な操作ミスを防ぐための設計になっている．


