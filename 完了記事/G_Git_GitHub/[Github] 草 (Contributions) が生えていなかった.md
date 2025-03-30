
## In a nutshell
GitHubのContributions（草）が反映されない問題に遭遇．
原因はローカルのGitとGitHubの登録メールアドレスの不一致だった．
解決策として，Gitの設定を確認し，メールアドレスを修正した．


## Githubの草(Contributions)とは？


Contributionsは，そのままに，貢献，を意味する．このContributionの数が活動量として，**草**と表現されている．
これはOverviewのセクションから確認できる．日付 と contributions の数が緑のタイルで表示される．

![t_picture_github.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3830184/1a017d52-5fcc-4da7-b9f1-edaa3b1908b0.png)



## 生じた問題 (草が生えていない)

上記の画像の様にContributionsは表示がされており時々見ていた．ほぼ毎日複数のpushをしているにも関わらず色が付いていない為，何となく疑問には感じていたが，正直どうでもいいので気にもしていなかった．


## 原因と解決方法
#### 今回の原因
ローカルのGitとGithubに登録されている**メールアドレス**が異なっていた．

#### 解決方法

以下のコマンドをGit bashで実行して，**ローカル**のユーザーネームとメールアドレスを確認する．これが，**Github**に登録されているものと一致している事を確認する．

```bash
git config --global user.name  
git config --global user.email  

# 以下でもok
git config --list | grep user
```

異なっていた場合には，以下のコマンドで登録や修正を行う．
```bash
git config --global user.name "WRITE_NAME"    
git config --global user.email "WRITE_EMAIL"     
```

#### 他に考えられる事

 - プライベートレポジトリに関する活動は，Private contributions にチェックを入れないと反映されない事がある．
 - フォークしたリポジトリの commit は反映されない．
 - branch が正しくない．
 - ローカルの時刻がずれている為，commitが適切に処理されていない．


## 問題の発見が遅れた理由

一切の草が生えていなければ，明らかにおかしいと理解ができた．Contributions が適切に反映されていない -> 設定ミスがあり，後々問題を引き起こす可能性があると気づけた．
しかし，PCの Git では異なるメールアドレスを設定していたため草が生えなかったが，スマホアプリでは正しいアカウントでログインしていた為，アプリ経由のIssue作成では草が生えた．その為に，この問題に気づきにくかった．




## Summary
 - Contributionsが反映されていなかった原因はメールアドレスの不一致
 - 他の可能性としては，プライベートレポジトリの設定や，フォーク，ブランチの問題が考えられる
 - スマホからGithubのアプリを利用していた為に，問題に気が付くのが遅れた



