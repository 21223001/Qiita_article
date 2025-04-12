
## In a nutshell
リモートリポジトリに `git push` した際，「This repository moved」というメッセージが出た場合は，GitHub上でリポジトリ名が変更されたことによるリダイレクトが原因である．このメッセージを回避し，今後も安定して操作を行うためには，`git remote set-url` コマンドで新しいURLに更新すれば良い．


## はじめに
Gitを利用していた際に遭遇したエラーについて，備忘録として，以下に記述した．本記事で扱うのは，`git push` 時に表示された「This repository moved」というリダイレクトメッセージである．これについて原因の特定から対処法を記述した．特に，GitHubでリポジトリ名(特に大文字・小文字)を変更した場合にこのような現象が発生する．
但し，以下の記事について，ユーザー名は`my_USER_name`，レポジトリ名は`my_REPO_name`とした．


## 予想される読み手
- Git及びGitHubについて初学者である
- Gitを実務で使い始めたが，まだエラー対応に不慣れである
- リポジトリ名変更後に不穏なメッセージを見て戸惑った


## 生じた現象
Gitのリモートリポジトリへ `push` しようとしたところ，以下のようなメッセージが表示された．
最終的には正常にpushできているように見えるが，リダイレクトに関するメッセージは出力されている．

```bash
remote: This repository moved. Please use the new location:
remote:   git@github.com:my_USER_name/my_repo_name.git
```


## 原因
### 直接的な原因
リモートリポジトリのURLが変更されたため，Gitが旧URLから新URLへのリダイレクトを自動で行っていた．

```bash
git@github.com:my_USER_name/my_REPO_name.git # 旧URL
git@github.com:my_USER_name/my_repo_name.git # 新URL
```

※上記の通り，大文字・小文字の違い(`REPO` -> `repo`)が原因でGitHubが新しいURLにリダイレクトしていた．


### 間接的な背景
GitHub上では，リポジトリ名の大文字・小文字も区別されるが，URLとしては見た目が似ているため，変更されたことに気付きにくい．また，GitHubは旧URLから新URLへ自動でリダイレクトしてくれるが，ローカルのリモート設定自体は古いまま残る．


## 対処法

リモートリポジトリのURLを新しいものに更新する．

### 手順

1. 現在のリモート設定を確認

```bash
git remote -v
```

出力例:

```bash
my_REPO_name  git@github.com:my_USER_name/my_REPO_name.git (fetch)
my_REPO_name  git@github.com:my_USER_name/my_REPO_name.git (push)
```

2. 新しいURLに設定を更新

```bash
git remote set-url my_REPO_name git@github.com:my_USER_name/my_repo_name.git
```

3. 再度確認

```bash
git remote -v
```

更新後の出力:

```bash
my_REPO_name  git@github.com:my_USER_name/my_repo_name.git (fetch)
my_REPO_name  git@github.com:my_USER_name/my_repo_name.git (push)
```

この状態になれば，以降の`push`時にリダイレクトメッセージは表示されなくなる．


## 補足
### なぜリモートURLの変更に気づきにくいのか

GitHubでは，リポジトリ名の変更を行っても旧URLからの自動リダイレクトが有効になるため，表面的には push/pull は成功する．しかし，以下のような問題が起こる可能性がある．

- 毎回 push 時にリダイレクトメッセージが出てログが煩雑になる
- チームメンバーが新しいURLを知らずに作業してしまう
- CI/CDツールがリダイレクトを正しく処理できないことがある


### リモート名も統一したい場合

もしリポジトリ名そのものを変更した場合，リモート名(`origin`など)もあわせて整理するとわかりやすい．これにより他のチュートリアルやツールの記述とも整合性が取れる．

```bash
git remote rename my_repo_name origin
```


### その他
- `git remote show <リモート名>` で，リモートの詳細(URLやトラッキング情報)を確認できる．
- URLが変わった理由を確認したい場合は，旧URLにアクセスしてリダイレクトされるかをブラウザで確認するとよい．
- GitHubではリポジトリ名変更の明示的な履歴は表示されないため，Issueやコミットログで背景を探るとよい．


## Summary

- GitHubでリポジトリ名を変更すると，旧URLは自動で新URLにリダイレクトされる．
- しかし，ローカルの設定(`git remote`)は更新されない．
- 不要なリダイレクトを避け，明確な管理を行うためには，`git remote set-url`でURLを更新することが望ましい．


## References

[GitHub Docs - Repositories > Create & manage repositories > Renaming a repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/renaming-a-repository)

[Git Documentation - Documentation > Reference > remote](https://git-scm.com/docs/git-remote)


