
## In a nutshell  
Paste Imageは，VSCode上でクリップボードの画像を直接貼り付けて保存できる拡張機能です．  
自動的に画像ファイルを生成し，Markdownなどにパスを挿入します．  
軽量でクロスプラットフォームに対応しており，設定も柔軟です．


## はじめに  
スクリーンショットを手軽に画像として保存し，ドキュメントに挿入できる方法を探していた．特に，以下のような条件を満たす必要があった．

- 必要なときのみ画像として保存できること(毎回ではなく任意タイミング)
- 保存先ディレクトリを状況に応じて変更可能なこと
- 操作が簡単であること

これらの条件を満たすVSCodeの拡張機能「Paste Image」を見つけたため，本記事で紹介する．このツールを利用すれば，Powerpointに張り付けて画像として保存する，PowerShellで作成した保存スクリプトを実行する必要もない．スニッピングツールとの相性が良く，VSCode上にクリップボードの画像を張り付けるだけで，保存と挿入の2つが高速に処理される．


## 予想される読み手

- VSCodeを利用して技術文書や手順書を作成している人
- スクリーンショットをドキュメントに手軽に挿入したいと考えている人
- MarkdownやAsciidoc形式で画像挿入の作業を効率化したい人


## 主な機能

- クリップボードの画像をPNGファイルとして自動保存
- Markdown / Asciidoc記法でパスを自動挿入
- 保存先ディレクトリやファイル名の柔軟なカスタマイズ
- 貼り付け時にファイルパスを確認するオプション(`pasteImage.showFilePathConfirmInputBox`)
- URLエンコードや挿入パターンのカスタマイズが可能


## デフォルト動作

- 保存先:現在編集中のファイルが存在するディレクトリ(`${currentFileDir}`)
- ファイル形式:PNG(固定)
- ファイル名:`Y-MM-DD-HH-mm-ss.png`(タイムスタンプ形式)
- 挿入形式:`![](./imagePath.png)`(Markdown)



## 応用的な設定

Paste Imageの設定は，`settings.json` に記述する．以下に代表的な設定例を示す．

### 画像をプロジェクト直下の `img` フォルダに保存する
```json
"pasteImage.path": "${projectRoot}/img",
"pasteImage.basePath": "${projectRoot}",
"pasteImage.prefix": "/img/"
```

### 記事タイトルをファイル名に追加する
```json
"pasteImage.namePrefix": "${currentFileNameWithoutExt}_",
"pasteImage.defaultName": "Y-MM-DD-HH-mm-ss"
```

### HTMLタグで画像を挿入する
```json
"pasteImage.insertPattern": "<img src='${imagePath}' />"
```


## よくある誤解:拡張子の変更について
Paste Imageは内部的にPNG形式で画像を保存しており，拡張子のみを `.jpg` や `.webp` に変更しても，実際の画像形式は変わらない．そのため，ビューアによっては画像を正常に表示できないことがある．他の形式(JPEG, WebPなど)へ変換したい場合は，別途ツールやスクリプトで変換を行う必要がある．

### Pythonによる自動変換例
```python
from PIL import Image
import os

folder = "./img"

for filename in os.listdir(folder):
    if filename.endswith(".png"):
        path = os.path.join(folder, filename)
        img = Image.open(path).convert("RGB")
        jpg_path = path.replace(".png", ".jpg")
        img.save(jpg_path, "JPEG")
        os.remove(path)
```



## セキュリティ・パフォーマンス・信頼性

### セキュリティ  
Paste Imageはローカル環境でのみ動作し，外部との通信は行わない．但し，OSSであるため，導入前にGitHubのソースコードを確認するのが望ましい．

### 信頼性  
活発にIssueやPRがやり取りされており，多くのユーザーにレビューされている．ただし，個人開発であるため，将来的な保守継続については不確定要素がある．

### パフォーマンス  
数MBのスクリーンショットでも即時に保存・挿入が可能であり，動作は極めて軽量．多数の画像を挿入してもエディタの操作に大きな影響は出ない．


## 導入方法
VSCode左側のサイドバーから「拡張機能(Extensions)」を開く．そこで「Paste Image」と入力し，最もダウンロード数が多いものを選択してインストールする．インストール後は，VSCodeを一度再起動することを推奨．スクリーンショットをコピーし，Markdownエディタ上で貼り付けることで自動的に画像が保存・挿入される．


## 運用上の注意点
- 拡張子を変更したい場合は別途変換処理が必要
- 外部サービスとの通信はないが，厳格なセキュリティポリシー下ではコード確認を求められることがある
- 長期的なメンテナンスが保証されていないため，業務用途では他手段との併用を検討すると良い


## Summary
- VSCode上で画像の貼り付けと保存を効率化する拡張機能  
- クリップボードの画像を自動で保存・Markdown挿入  
- 柔軟な保存パスやファイル名の設定が可能  
- PNG形式のみ対応，変換はスクリプトで対応可能  
- 軽量かつローカル完結でセキュリティリスクが低い  
- 個人開発のため，長期運用時は注意が必要


## References

- [Visual Studio Marketplace - Visual Studio Code > Other > Paste Image](https://marketplace.visualstudio.com/items?itemName=mushan.vscode-paste-image) 
- [GitHub Repository - mushanshitiancai  vscode-paste-image](https://github.com/mushanshitiancai/vscode-paste-image)  


  
