WIn11のスクリーンショットを用いてキャプチャをするが，毎回powerpointに貼り付けて，画像として保存していた．
面倒なので，CLIで操作できたら便利(少なくとも，今までよりは良い)と考えた．
しかし，スクリーンショットやキャプチャの為に新規の外部ツールを利用する事は嫌なので，Powershellで実行できる方法を調べた．

## In a nutshell
Windows標準のSnipping Toolを用いてスクリーンショットを取得し，PowerShellやタスクスケジューラを使って自動保存する方法を紹介する．
手動操作ではPowerShellスクリプトを実行し，タスクスケジューラを使うことで自動化が可能になる．


## Print Screen(Snipping tool) の基本情報

厳密には，PrintScreenとSnipping tool は異なるが，今回はまとめてSnipping toolとする．
これは，Windowsに標準搭載されているスクリーンショット取得ツールである．これは，GUIを介して操作ができる．
Win + Shift + S　，または，PrtScr キーで起動できる．
キャプチャ画像はクリップボードにコピーされる．

Tool barから操作ができる．
![screen_toolbar.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3830184/fee92466-e57d-4634-bbaf-f49dcb40b647.png)
画像は参考文献1より，マイナビニュース で公開されている画像を修正(切り抜き)した


## 手動 PowerShellを用いる

手順
Win + Shift + S を押して，範囲選択でスクリーンショットを撮る（クリップボードに保存）．

PowerShell を開いて，以下のスクリプトを実行する

PrtSc 以降にコピー操作を行うと，画像データがクリップボードから削除され，スクリプトが正常に動作しない．

```PS
if ($clipboardData -ne $null -and $clipboardData.GetDataPresent([System.Windows.Forms.DataFormats]::Bitmap)) {
    $img = $clipboardData.GetData([System.Windows.Forms.DataFormats]::Bitmap)
    $savePath = "C:\Users\$env:USERNAME\Pictures\screenshot.png"
    $img.Save($savePath, [System.Drawing.Imaging.ImageFormat]::Png)
    Write-Output "Screenshot saved to $savePath"
} else {
    Write-Output "クリップボードに画像データがありません．最後にPrtScrを実行してください．PrtScr以降にコピーを行わないでください．"
}
```

## 自動化 タスクスケジューラを用いる

#### 以下のPSファイルを作成する
save_screenshot.ps1

```PS
Add-Type -AssemblyName System.Windows.Forms
Start-Sleep -Milliseconds 500 
$img = [System.Windows.Forms.Clipboard]::GetImage()

if ($img -ne $null) {
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $path = "C:\Users\$env:USERNAME\Pictures\screenshot_$timestamp.png"
    $img.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    Write-Output "Screenshot saved to: $path"
} else {
    Write-Output "No image found in clipboard."
}
```

`Start-Sleep -Milliseconds 500`は，スクリーンショットの処理が完了する前に PowerShell スクリプトが動作してしまうのを防ぐ為

#### 続いて，batファイルを作成する
save_screenshot.bat 

```bat
@echo off
powershell -ExecutionPolicy Bypass -File "%USERPROFILE%\save_screenshot.ps1"
exit
```

上記の2つのファイルのディレクトリは以下が推奨
```
C:\Users\username\save_screenshot.ps1
C:\Users\username\save_screenshot.bat
```

#### タスクスケジューラに登録する

Win + R -> taskschd.msc を入力 -> タスクスケジューラ を開く．
[基本タスクの作成] をクリック．
名前: PrintScreen Auto Save
トリガー を [新しいイベントで開始] に設定．
イベントを設定
ログ: Application
ソース: SnippingTool
イベントID: 1001
操作 -> プログラムの開始
プログラム/スクリプト: cmd
引数の追加: /c "%USERPROFILE%\save_screenshot.bat"

注意として，イベントID 1001 は環境によって違う事がある．


## Summary
 - PowerShellを使用すると，スクリーンショットを手動でファイルに保存できる．
 - タスクスケジューラを利用すれば，Snipping Toolのイベント発生時に自動保存が可能．




## References
1. マイナビニュース編集部. (2023). マイナビニューストップ > +Digital >パソコン >Windows >PrintScreenキーの設定を「Alt」+「PrtSc」キーに戻す
[https://news.mynavi.jp/article/win11tips-201/](https://news.mynavi.jp/article/win11tips-201/)

2. Microsoft公式ドキュメント: Snipping Tool を使ってスクリーン ショットをキャプチャする
[Microsoft公式ドキュメント: Snipping Tool を使ってスクリーン ショットをキャプチャする](https://support.microsoft.com/ja-jp/windows/snipping-tool-%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3-%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%E3%82%92%E3%82%AD%E3%83%A3%E3%83%97%E3%83%81%E3%83%A3%E3%81%99%E3%82%8B-00246869-1843-655f-f220-97299b865f6b)
