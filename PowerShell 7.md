# PowerShell 7 の特徴

## PowerShell 5 系との違い

- PowerShell 7 は .NET Core ベースで動作するが，PowerShell 5 は .NET Framework ベース．
- Windows のみ対応の PowerShell 5 に対し，PowerShell 7 はクロスプラットフォーム(Windows, Linux, macOS 対応)．
- `foreach` や `where` などのパイプライン処理が大幅に高速化．
- `$ErrorActionPreference = 'Stop'` の場合でも，一部のコマンドレットが例外を発生させる仕様変更．
- 新しいパイプライン並列処理 (`ForEach-Object -Parallel`) に対応．

### OS による違い

- **Windows**
  - PowerShell 5 は OS に標準搭載されているが，PowerShell 7 は手動でインストールが必要．
  - `Windows Forms` や `WPF` との互換性が低い(ただし `.NET Core` の制限による)．
  - `Get-WindowsFeature` などの一部コマンドは利用不可．

- **Linux / macOS**
  - PowerShell 7 は公式にサポートされており，`apt`, `yum`, `brew` などでインストール可能．
  - Linux の標準的な Bash コマンド (`ls`, `cat`, `grep` など) が使用可能．
  - `pwsh` コマンドとして起動する．

### 新機能

- **パイプライン並列処理**
  ```powershell
  1..10 | ForEach-Object -Parallel { $_ * 2 }
  ```
- **新しい演算子**
  - `??`(Null 合体演算子)：`$value = $null ?? 'default'`
  - `??=`(Null 合体代入演算子)：`$value ??= 'default'`
  - `-match`, `-notmatch` で `case-insensitive` のデフォルト変更
- **簡略化されたエラーハンドリング**
  - `Try { } Catch { }` のエラーメッセージが改善．
  - `$?` 変数がエラーの発生をより詳細に報告．
- **`Get-Error` コマンド**
  - 詳細なエラーメッセージの取得が可能．
- **`ConvertTo-Json` の改良**
  - 深いネストのオブジェクトを正しく変換可能．

### PowerShell 5 との互換性

- `.NET Framework` 依存のモジュール(`Active Directory`, `WMI`, `Exchange` など)は PowerShell 7 では動作しない可能性がある．
- `Windows PowerShell Compatibility Module` を利用することで，一部の PowerShell 5 コマンドを PowerShell 7 で実行可能．
  ```powershell
  Import-Module -Name Microsoft.PowerShell.Management -UseWindowsPowerShell
  ```
- `System.Windows.Forms` を利用するスクリプトは互換性の問題が発生することがある．

### コマンドの違いや特徴

- **変更点**
  - `Get-Command -Syntax` の出力が改善され，関数のシグネチャが見やすくなった．
  - `Select-String` で複数行マッチが可能．
  - `Out-GridView` が macOS / Linux で利用不可．

- **新コマンド**
  - `Get-Error`：直前のエラーを詳細に取得．
  - `Test-Connection`：簡単な ping コマンドとして利用可能．
  - `New-TemporaryFile`：一時ファイルを作成する新機能．






## アップデートとサポート
- PowerShell 7.x は LTS(長期サポート)版と Current(最新機能)版がある．
- 現在の最新版: PowerShell 7.4(LTS)
- アップデートには `winget` や `brew upgrade` を利用可能．

## PowerShell 5 と 7 の共存

- PowerShell 5 (`powershell.exe`) と PowerShell 7 (`pwsh.exe`) は別プロセスとして共存可能．
- 既存のスクリプトを段階的に移行可能．





## PowerShell 7 の導入方法について

PowerShell 7(PowerShell Core)のインストール方法や，初期設定，注意点については以下の記事で詳しくまとめています．

[[PowerShellCore] 新機能と改善のために最新の PowerShell を...](https://qiita.com/molecular_pool/items/6287d89d65cf342f8991)




## Summary


## References






