

## In a nutshell
Gitにおける通信は，基本はSSHが良い．但し，SSHが使えない or 面倒な場合はHTTPSが代替手段になる．


## はじめに
Gitには通信方法としてHTTPSとSSHの両方が用意されている．但し，SSHを利用せずにHTTPSだけで運用する事は非常に手間に感じた．また，セキュリティの側面からもSSHである事は必須に感じた為に，なぜHTTPSも用意されているのかを調べて以下に纏めた．


## 予想される読み手
 - Gitについて初学者である
 - GitにおけるHTTPSとSSHの差について知りたい
 - 今後もGit及びGithubを利用する予定がある


## GitにおけるHTTPSとSSHの違い
### HTTPS
- URLの例 : `https://github.com/ユーザー名/リポジトリ名.git`
- 認証方法 : GitHubのユーザー名とPersonal Access Token(PAT)
- 特徴
  - 最もシンプルで，初期設定不要
  - 企業ネットワークなどの制限がある環境でも使いやすい
  - ただし，毎回認証が必要なことがある(キャッシュすれば回避できる)


### SSH
- URLの例 : `git@github.com:ユーザー名/リポジトリ名.git`
- 認証方法 : SSHキー(公開鍵・秘密鍵ペア)
- 特徴
  - 最初にSSHキーの生成とGitHubへの登録が必要
  - 一度設定すれば，パスワード入力なしで安全に使える
  - 自動化(スクリプトなど)や頻繁な操作に向いている


### (補足) GitHub CLI(ghコマンド)
GitHubでは，公式のCLIツール「gh」も提供されており，リポジトリのcloneやPR作成などをコマンドラインから操作できる．但し，これはGitそのものの通信方式(SSH/HTTPS)とは異なり，補助的に使うものである．



## SSHとHTTPSのどちらを利用すべきか

基本的にはSSHを利用すべきである．理由は以下の通りである．

### セキュリティの高さ
SSHは公開鍵暗号方式を採用しており，HTTPSと比べてより強固な認証と暗号化が実現できる．特にGitHubでは，パスワード認証が廃止され，HTTPSでの認証はPersonal Access Token(PAT)による運用に切り替わっているが，これはユーザー管理の負担が増える一因ともなる．

### パスワードレス運用が可能
一度SSHキーを登録すれば，毎回の操作で認証情報の入力が不要になり，効率的に作業が進められる．

### 自動化やスクリプトとの親和性
SSHはGitの操作を自動化する際にもパスフレーズを省略する設定が可能であり，スクリプトやCI/CDとの相性が良い．ただし，SSHが適さないケースも存在する
- ネットワーク制限(例：企業や大学のプロキシ環境)
- 一時的なclone操作や公開リポジトリの閲覧
- 鍵管理が難しい共有端末や一時端末での操作
このような場合には，HTTPSでの接続を選ぶ柔軟性も必要である．



## なぜHTTPSの選択肢が存在するのか
通信の性質上，HTTPSと比較をしてSSHの方が圧倒的に安全である．また基本的には，Gitではユーザーはその差を意識せずに利用ができる．では，なぜHTTPSという選択肢が今もあるのかについて以下に記述した．

### 事前設定が不要
SSHは公開鍵・秘密鍵の作成や，GitHubへの登録が必要である．対して，HTTPSはURLさえ分かればすぐcloneできる．その為，Gitを始めて利用する人には敷居が低い．

### 企業や学校のネットワーク制限に強い
企業や学校などのネットワークでは，SSHの22番ポートがブロックされていることがある．対して，HTTPSは443番ポートを使うため，普通のWeb通信が可能．特にプロキシ環境やVPN制限のある環境ではHTTPSが使える．

### CIツールやスクリプトとの相性
GitHub ActionsやCI/CDで，トークンを使ってHTTPSでpush/pullすることがある．特に，GitHubのアクセストークンはHTTPSで認証に使えるように設計されている．





## 使い分けのイメージ

| シチュエーション   | 推奨手段 | 理由 |
|----------------------------------|-----------|------|
| 自宅や個人PCで開発                | SSH        | 一度設定すればパスワード不要で安全＆便利 |
| 企業・学校などの制限ある環境       | HTTPS      | 22番ポート(SSH用)がブロックされている場合あり |
| とりあえずcloneして中身見たいだけ | HTTPS      | 設定不要，すぐ使える |
| 自動化スクリプトやCIツール        | どちらでも(トークン使用) | トークンによってHTTPSでも安全に操作可能 |
| 公共PCなど，秘密鍵が置けない環境 | HTTPS      | 鍵管理ができない状況に適している |




## 実際のSSHの設定手順
SSHを利用するには以下の手順で設定を行う．

 - SSHキーを生成する
   ターミナルで以下のコマンドを実行する．ed25519方式が推奨．
   ```
   ssh-keygen -t ed25519 -C "myemail@example.com"
   ```

 - 公開鍵をGitHubに登録する  
   作成された公開鍵(例：`~/.ssh/id_ed25519.pub`)をコピーしてGitHubの「Settings > SSH and GPG keys」で「New SSH key」から登録する．

 - 接続確認を行う
   `Hi ユーザー名! You've successfully authenticated...`のようなメッセージが表示されれば成功．   
   ```
   ssh -T git@github.com
   ```



## トークン管理とセキュリティ(HTTPS利用時の注意点)
HTTPSでGitHubと通信する際には，Personal Access Token(PAT)を使用する．2021年以降，GitHubではパスワード認証が廃止されており，HTTPS利用時には必ずこのトークンが必要になる．HTTPSを使う場合には管理コストやセキュリティリスクも理解しておく必要がある．

### トークン作成方法
 - GitHubにログインし，「Settings > Developer settings > Personal access tokens」へ移動．
 - 「Generate new token」で必要なスコープ(repoなど)を選択し，トークンを生成する．
 - トークンは一度しか表示されないため，必ず安全な場所に保管する．

### 注意点
- トークンはパスワードと同等の機密性を持つため，絶対に他人と共有しない．
- `.gitconfig`やスクリプトに直接埋め込むことは避ける．
- セキュリティ向上のため，トークンの有効期限を設定することが推奨される．




## Summary
- Gitの通信には主にSSHとHTTPSの2つの方式がある．
- 基本的にはSSHを使うことで，安全かつパスワードレスで運用ができる．
- ただし，SSHが使えない環境(企業ネットワーク，公共PCなど)ではHTTPSが現実的な選択肢になる．
- HTTPSは設定不要ですぐに使えるが，毎回の認証やトークン管理が必要．
- 実運用では，使用環境や用途に応じて使い分けるのが重要．


## References

-[GitHub Docs - Connecting to GitHub with SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
-[GitHub Docs - Cloning a repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)
-[GitHub Docs - About authentication to GitHub](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/about-authentication-to-github)




















