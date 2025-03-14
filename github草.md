
## In a nutshell
未定


## Githubの草(Contributions)とは？


Contributionsは，そのままに貢献度である．このContributionの数が活動量として，**草**と表現されている．
これはOverviewから確認できる．緑のタイル．日付 と contributions の数で管理されている．

![t_picture_github.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3830184/1a017d52-5fcc-4da7-b9f1-edaa3b1908b0.png)



## 生じた事(草が生えていない)

上記の画像の様にContributionsは表示がされており時々見ていた．ほぼ毎日複数のpushをしているにも関わらず色が付いていない為，何となく疑問には感じていたが，正直どうでもいいので気にもしていなかった．


## 原因と解決方法
#### 原因
ローカルのGitとGithubに登録されている**メールアドレス**が異なっていた．


#### 解決方法


```Git bash
git config --global user.name  
git config --global user.email     
```


```Git bash
git config --global user.name "xxx"    
git config --global user.email "yyy"     
```


## なぜ気がつかなかったのか

一切の草が生えていなければ，明らかにおかしいと理解ができた．Contributions が適切に反映されていない -> 何かの設定が適切に行われておらず，のちに問題を引き起こしかねないと感じる事が出来た．
しかし，**PCのGit**では異なるメールアドレスの為に草が生えなかったが，**スマホアプリのGithub**では適切にログイン出来きていた為，アプリ経由でのIssueでは草が生えてしまった．これにより，なんとなく動いているように見えてしまった．




## Summary




## References



