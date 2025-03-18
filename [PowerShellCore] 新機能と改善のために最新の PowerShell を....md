

## In a nutshell
未定




## PowerShell 7とは？
PowerShellを起動すると，以下のような文言が出力される．
`新機能と改善のために最新の PowerShell をインストールしてください!https://aka.ms/PSWindows`
ここで言っている**最新の PowerShell**が PowerShell 7 である．


## バージョンによる呼び方の違い

PowerShell : windowsに標準でインストールされている．バージョンは5系．開発終了
PowerShellCore : 利用するにはインストールが必要．バージョンは6系．開発終了
PowerShell 7 : 利用するにはインストールが必要(本記事)．バージョンは7系．開発進行中



## 現在のバージョン確認(Powershell)

バージョン確認のコマンド
```PS
$PSVersionTable
```
```PS
Name                           Value
----                           -----
PSVersion                      5.1.22621.4391
PSEdition                      Desktop
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0...}
BuildVersion                   10.0.22621.4391
CLRVersion                     4.0.30319.42000
WSManStackVersion              3.0
PSRemotingProtocolVersion      2.3
SerializationVersion           1.1.0.1
```

64bit or 32bit の確認コマンド
```PS 
[System.Environment]::Is64BitProcess
```
```PS
True
```


## インストール方法

以下のサイトは Microsoft 公式のインストール方法に関するドキュメント．必要があれば参照するとよい．
[Install PowerShell using WinGet (recommended)](
https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.5#install-powershell-using-winget-recommended)


手順について，まずは，PowerShell(通常バージョン)を起動

以下を実行
```PS
winget search Microsoft.PowerShell
```

以下が出力される
```PS
名前               ID                           バージョン ソース
------------------------------------------------------------------
PowerShell         Microsoft.PowerShell         7.5.0.0    winget
PowerShell Preview Microsoft.PowerShell.Preview 7.6.0.3    winget
```

インストール (Previewでない方)
```PS
winget install --id Microsoft.PowerShell --source winget
```

インストール完了が表示される．
新規CLIとして Powershell 7 が追加されている(現在まで利用していたのは Windows PowerShell)


PowerShell 7 を起動すると，以下のように，バージョン情報が冒頭に出力される
```PS
PowerShell 7.5.0
```



## Summary




## References



