

## はじめに
windowsに標準で存在する Snipping tool では，画像をクリップボードにコピーするだけで保存には手間がかかる．また，画面に入らない箇所は切れてしまうので，1ページ全てを画像として保存するツールを探した．必要な事はキャプチャする機能に特化している事と，ページ全体に対応できる事，セキュリティの為に不要な権限を与えなくて良い事である．該当したのが以下のツールGoFullPageである．

## 出来る事
1ページ全てをキャプチャできる．以下の画像のように，長いページでもキャプチャ可能
[Github : qiita-CLI](https://github.com/increments/qiita-cli)
![screencapture-github-increments-qiita-cli.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3830184/79515501-2269-4817-b800-86f58919f87b.png)


SPAでも同様にキャプチャが可能．また，ブックマーク等はキャプチャされない．
また，キャプチャした画像をそのタブで編集可能(有料)．
![screen_edit.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3830184/98dc28b4-7ecc-42d0-ac7c-b7716eb3292a.png)



## 特徴
 - Chrome の拡張機能であり，Edgeでも利用できる．
 - 右上のアイコンをクリックするだけでキャプチャ＆ダウンロードが出来る．
 - 特別な権限を付与しなくても良いので，プライバシーの側面でアドバンテージがある．
 - 1ページ全体をキャプチャできる．
 - 小さな機能のアプリであり，不要な機能が付いていないので軽量である．


## 他のキャプチャツールとの比較
GoFullPage以外にもページ全体をキャプチャできるツールは存在する．
以下にそれぞれの特徴を纏めた．

| ツール名        | 1ページ全体 | 編集 | 特別な権限 | その他の特徴 |
|---------------|------------------|--------|--------------|--------------|
| **GoFullPage**  | 可能 | 有料 | 不要 | 軽量・シンプル |
| FireShot      | 可能 | 無料版あり | 権限が必要 | 多機能 |
| Awesome Screenshot | 可能 | 無料版あり | 権限が必要 | 録画機能 |
| Nimbus Screenshot | 可能 | 無料版あり | 権限が必要 | 充実した画面録画機能 |

上記のように，GoFullPageは軽量で、不必要な権限を求められない点が良いと感じられた．

比較した対象製品は以下からアクセス可能．
 - [GoFullPage](https://gofullpage.com/)
 - [FireShot](https://getfireshot.com/)
 - [Awesome Screenshot](https://www.awesomescreenshot.com/)
 - [Nimbus Screenshot](https://nimbusweb.me/screenshot/)


## インストール 及び 利用方法
#### インストール方法
まずは，Chrome を起動して，以下のサイトにアクセスする
[chromeウェブストア   GoFullPage - Full Page Screen Capture](https://chromewebstore.google.com/detail/gofullpage-full-page-scre/fdpohaocaechififmbbbbbknoalclacl)
`chromeに追加`をクリックすれば自動的にインストールしてくれる．

#### 利用方法
画面レイアウトの右上にカメラの様なロゴが追加されている．これをクリックするだけで自動的にページをキャプチャしてくれる．次のタブで 画像保存 or 編集(有料) を選択できる．
個人的には，私は編集は利用しないので，無料で利用できる機能だけで十分に感じる．


## 使用感
 - 小規模なアプリであり，キャプチャと画像保存に特化している．
 - SPAでも，長いページを途切れさせずにキャプチャ出来る事がありがたい．
 - Qiita記事を書く際や，Notion等に纏め事をする際に良い利用ができると感じている．
 - ページを拡大していると，読み込む範囲が重なってしまう為，欠損する領域が生じる．その為，ズームは推奨されない．

## 参考文献

 - [GoFullPage](https://gofullpage.com/)
 - [chromeウェブストア   GoFullPage - Full Page Screen Capture](https://chromewebstore.google.com/detail/gofullpage-full-page-scre/fdpohaocaechififmbbbbbknoalclacl)
 - [FireShot](https://getfireshot.com/)
 - [Awesome Screenshot](https://www.awesomescreenshot.com/)
 - [Nimbus Screenshot](https://nimbusweb.me/screenshot/)

 