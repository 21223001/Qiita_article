
## In a nutshell
PowerShell で特定フォルダ内のファイル拡張子を一括で変更するスクリプト．サブフォルダも対象にでき，元ファイルのリネームまたはコピー先への保存が可能．

## はじめに
以前は`ren`コマンドで拡張子を一括変換していたが，テンプレとして作成したので，以下にも記事として記述しておく．

## 使用例
 - 特定の拡張子のファイルをまとめて変換したい時：例.txt -> .md
 - 拡張子が誤って保存された多数のファイルをまとめて修正したいとき

## 機能概要
このスクリプトは，指定したフォルダ内のファイルに対して，拡張子の一括変換を行うツールである．以下の処理が可能．

### 主な機能
- 指定フォルダ内のファイルで，特定の拡張子(例 `.ls`)を別の拡張子(例 `.jar`)へ変更
- サブフォルダの再帰的処理の有無を切り替え可能(`-IncludeSubfolders`)
- 出力先フォルダを指定可能(指定しなければ元ファイルをリネーム)
- 変換後に同名ファイルが存在する場合は処理をスキップし，警告を出力
- ファイル名や階層構造を保持したままコピーまたはリネーム


## スクリプト全文

```powershell
param (
    [string]$TargetFolder = ".",              # 元のファイルを探すフォルダ
    [string]$OldExtension = ".ls",           # 元の拡張子
    [string]$NewExtension = ".jar",            # 変換後の拡張子
    [bool]$IncludeSubfolders = $true,         # サブフォルダも対象にするか(true or false)
    [string]$OutputFolder = ""                # 出力フォルダ(空ならリネーム)
)

# フルパスに変換しておく
$TargetFolder = (Resolve-Path $TargetFolder).Path
$UseRename = [string]::IsNullOrWhiteSpace($OutputFolder)

if (-not $UseRename) {
    $OutputFolder = (Resolve-Path -Path $OutputFolder -ErrorAction SilentlyContinue)?.Path
    if (-not $OutputFolder) {
        New-Item -ItemType Directory -Path $OutputFolder -Force | Out-Null
        $OutputFolder = (Resolve-Path $OutputFolder).Path
    }
}

# 拡張子のトリム
$OldExtension = $OldExtension.TrimStart(".")
$NewExtension = $NewExtension.TrimStart(".")

# 対象ファイルの取得
$files = Get-ChildItem -Path $TargetFolder -Filter "*.$OldExtension" -File -Recurse:($IncludeSubfolders)

foreach ($file in $files) {
    if ($UseRename) {
        # 同じ場所でリネーム
        $newFullPath = [System.IO.Path]::ChangeExtension($file.FullName, $NewExtension)

        if (Test-Path -Path $newFullPath) {
            Write-Warning "Skipped: '$($file.FullName)' → '$newFullPath' は既に存在します．"
            continue
        }

        try {
            Rename-Item -Path $file.FullName -NewName $newFullPath -Force
            Write-Host "Renamed: $($file.FullName) → $newFullPath"
        } catch {
            Write-Warning "Failed to rename: $($file.FullName) - $_"
        }
    } else {
        # 相対パスを使って新規ファイル作成(別フォルダ)
        $relativePath = $file.FullName.Substring($TargetFolder.Length).TrimStart("\", "/")
        $newRelativePath = [System.IO.Path]::ChangeExtension($relativePath, $NewExtension)
        $newFullPath = Join-Path $OutputFolder $newRelativePath

        $newDir = Split-Path $newFullPath
        if (-not (Test-Path $newDir)) {
            New-Item -ItemType Directory -Path $newDir -Force | Out-Null
        }

        if (Test-Path -Path $newFullPath) {
            Write-Warning "Skipped: '$($file.FullName)' → '$newFullPath' は既に存在します．"
            continue
        }

        try {
            Copy-Item -Path $file.FullName -Destination $newFullPath -Force
            Write-Host "Copied: $($file.FullName) → $newFullPath"
        } catch {
            Write-Warning "Failed to copy: $($file.FullName) - $_"
        }
    }
}

```



## パラメータ一覧

| パラメータ名           | 説明                                                                 |
|------------------------|----------------------------------------------------------------------|
| `-OldExtension`        | 変換対象の拡張子(例：`.txt`)                                      |
| `-NewExtension`        | 変換後の拡張子(例：`.md`)                                          |
| `-OutputFolder`        | 変換後のファイルの保存先ディレクトリ(省略時は元の場所でリネーム)  |
| `-IncludeSubfolders`   | サブフォルダも含めて処理する場合に指定(スイッチ型)                |


## テスト環境構成

スクリプトは以下のディレクトリ構造にて検証された．
但し，以下のパス`myusername`は置換修正した．

![powershell_sample_dir.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3830184/57e5816a-3468-4df6-8fe3-8d30c07bdbf6.png)


```
C:\Users\myusername\Downloads\sample_converter
│
├── extension_converter.ps1
├── sample1
├── sample2.md
├── sample2.txt
├── sample3.md
├── sample4.h
├── sample5.pdf
├── sample6.py
├── sample7.tf
├── sample99.jar
├── sample99.json
│
└── sample_subfolder\
    ├── sub1.jar
    └── sub2.cpp
```



## 実行例

### 元ファイルを直接リネーム
```powershell
.\extension_converter.ps1 -OldExtension ".ls" -NewExtension ".jar"
```

### 指定したフォルダに拡張子変換後のファイルをコピー
```powershell
.\extension_converter.ps1 -OldExtension ".ls" -NewExtension ".jar" -OutputFolder "C:\ConvertedFiles"
```



## 注意点
 - 拡張子の前に `"."` を付けて指定すること(例：`.txt`, `.md`)
 - 同名ファイルが既に存在する場合，上書きせずスキップされる
 - `OutputFolder` を指定しない場合，ファイルは元の場所で名前変更される(移動なし)
 - 実行がブロックされる場合は、以下のコマンドで一時的に許可できる(管理者権限)
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```
- `Get-ChildItem` により取得されるファイルが対象．隠しファイルや読み取り専用属性も対象になる
- 拡張子の大文字・小文字は区別されない(例：`.TXT` も `.txt` として扱われる)

