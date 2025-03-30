

## In a nutshell
PowerShell 7 は Windows PowerShell（バージョン5系）の後継となるクロスプラットフォーム対応の最新バージョン．PowerShell Core（バージョン6）の後継であり，引き続き開発が進められている．インストールが必要だが，Windows，macOS，Linux で動作可能．


## PowerShell 7とは？
PowerShellを起動すると，以下のような文言が出力される．
`新機能と改善のために最新の PowerShell をインストールしてください!https://aka.ms/PSWindows`
ここで言っている**最新の PowerShell**が PowerShell 7 である．


## バージョンによる呼び方と機能の違い

PowerShell : windowsに標準でインストールされている．バージョンは5．開発終了
PowerShell Core : 利用するにはインストールが必要．バージョンは6．開発終了
PowerShell 7 : 利用するにはインストールが必要(本記事)．バージョンは7系．開発進行中．クロスプラットフォーム対応で，Windows，macOS，Linux で利用可能．


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
### 前提
PowerShell 7 のインストール方法は，`Winget`を推奨する．macOSでは`brew`，Linuxでは`apt`が利用できる．

もし，コマンドでは上手くインストールが出来ないのであれば，ローカルでビルドする選択子もある．以下のサイトから`.msi`，`.zip`などが利用できる．

このサイトは Microsoft 公式のインストール方法に関するドキュメント．必要があれば参照するとよい．
[Install PowerShell using WinGet (recommended)](
https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.5#install-powershell-using-winget-recommended)



### Win11 におけるインストール例.

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
```PS7
PowerShell 7.5.0
```

以下のコマンド`pwsh`を実行する
```PS7
Get-Command pwsh
```
以下の様にバージョン情報が出力されれば，適切にインストールされている．
```PS7
CommandType     Name          Version    Source
-----------     ----          -------    ------
Application     pwsh.exe      7.5.0.0    C:\Program Files\PowerShell\7\pwsh.exe

PS C:\Users\mosuk>
```

#### アンインストール方法
ちなみに，Powershell 7のアンインストールは以下のコマンドで可能である．(macOSとLinuxは公式ドキュメントを参照すること)

```PS7
winget uninstall --id Microsoft.PowerShell
```


### macOS or Linux でのインストール方法
本記事ではwindows11を扱ったが，macOS,Linuxでも流れは大凡同じである．
但し，使用コマンドはOS依存である．

macOS
```sh
brew install powershell 
```
Linux
```sh
sudo apt-get install -y powershell
```
特に，Linux系では，apt-getで直接インストールできない事があるので，公式ドキュメント(参考文献からアクセス可能)


## Summary

 - PowerShell 7 は Windows PowerShell の後継として開発が続いており，クロスプラットフォームで利用可能．
 - `pwsh` を使うことで従来の PowerShell とは区別できる．
 - Windows では `winget`，macOS では `brew`，Linux では `apt` などでインストール可能．



## References

 - Microsoft. 03/13/2022 Learn/PowerShell/Installing PowerShell on Windows [https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.5#install-as-a-net-global-tool](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.5#install-as-a-net-global-tool)

