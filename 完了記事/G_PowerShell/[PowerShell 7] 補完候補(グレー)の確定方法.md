
## In a nutshell
PowerShell 7 の予測補完は，`->`キーにより確定できる．


## はじめに
PowerShell 7 の予測補完機能は賢いが，補完候補の決定方法に戸惑った．忘備録として，以下に纏めた．


## 予想される読み手
 - 最近，PowerShell 7 に移行した
 - 今後，PowerShell 7 に移行する予定がある
 - 補完機能の動作に違和感がある


## 補完機能と，生じた問題
PowerShell 7 にはコマンド補完機能があり，予測補完によって，よく使うパスやコマンドの候補がグレーで表示される．`cd` 等を入力すると，グレーで補完候補(例:`(.\BB\)`)が表示される．この`(.\BB\)`を入力しようと思い，Tabキーを押すと，この補完ではなく先頭候補(例:`.\AA\`)が入力されてしまう．つまり，表示されている補完をそのまま確定したいのに，他の候補に飛んでしまう．

```powershell
cd .\BB\  #<-(予測補完,グレー表示)
```


## 補完候補の確定について
予測補完で表示された候補をそのまま入力したい場合，`->`キー(右矢印キー)によって確定できた．tabキーでは無いので注意．この違いは直感的ではなく，特に従来のPowerShellに慣れていたユーザーにとっては混乱の原因になりえる．私は VSCode のターミナルや Git Bash に慣れていた為，PowerShell 7 に切り替えた際，予測補完の「グレー表示」に対して自然と Tab を押して確定しようとしていた．しかし，PowerShell 7 では，Tab は `Get-Command` 系の従来の補完に即座に移行するため，目的の動作をしない事となった．これらから，予測補完(非確定表示)と通常補完(確定候補選択)が別のロジックで動いている事を理解した．
PowerShellでは「補完は補完，予測は予測」と設計が明確に分離されている．これは，意図的な仕様である可能性が高く，ユーザー側がその設計思想に慣れる必要がある．


## 補足
### 補完の挙動をカスタマイズする
補完候補の表示や種類は，以下のコマンドより `PSReadLine` の設定により変更できる．これらの設定は，セッションごとにリセットされるため，`Microsoft.PowerShell_profile.ps1` に記述することで変更を確定できる．

```powershell
# 履歴とプラグインの候補から予測を表示(推奨設定)
Set-PSReadLineOption -PredictionSource HistoryAndPlugin

# 予測補完を完全に無効にする
Set-PSReadLineOption -PredictionSource None

# 補完候補をリスト表示に変更
Set-PSReadLineOption -PredictionViewStyle ListView

# デフォルトの Inline 表示に戻す
Set-PSReadLineOption -PredictionViewStyle InlineView
```

一般には，設定ファイルは以下のパスに存在する(Win11)
`C:\Users\<ユーザー名>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`

存在しない場合には手動で作成可能．プロファイルのパスは以下で確認できる．

```powershell
$PROFILE
```

### 予測補完の仕組み
PowerShell 7 における予測補完機能は，`PSReadLine` モジュールにより提供されている．これは，過去の入力履歴や，プラグイン(例:`CompletionPredictor`)を用いて，コマンドの候補を，インライン表示する．表示される補完は，確定操作(右矢印キーなど)を行わない限り，入力内容として確定されない．

この予測補完は，次のような `PredictionSource` によって動作の元を制御できる
- `History`:ユーザーの入力履歴に基づいて候補を表示
- `Plugin`:補完プラグインによって候補を表示
- `HistoryAndPlugin`:両方を併用(推奨)

各候補が `PredictionResult` オブジェクトとして保持され，`ViewStyle` によって表示形式(Inline / ListView)が変わる仕組みになっている．

### VSCodeとPowerShell補完の関係
VSCodeでは，PowerShell拡張をインストールすると，予測補完がよりリッチに動作する場合がある．しかし，予測候補の表示形式や確定キーの仕様は，ローカルPowerShell端末と同様であるため，本記事の内容はVSCode内でも有効である．


## Summary
- PowerShell 7の予測補完はグレー表示で候補を提示する
- Tabキーでは予測候補を確定できず，右矢印キーを使用する
- PSReadLine設定により補完の挙動をカスタマイズ可能


## References

- [Microsoft. Learn > PowerShell > PSReadLine. Microsoft Learn.](https://learn.microsoft.com/en-us/powershell/module/psreadline/?view=powershell-7.5)
- [PowerShell Team. PSReadLine. GitHub](https://github.com/PowerShell/PSReadLine)


