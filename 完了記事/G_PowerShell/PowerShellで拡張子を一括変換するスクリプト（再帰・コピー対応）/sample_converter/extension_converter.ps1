param (
    [string]$TargetFolder = ".",              # 元のファイルを探すフォルダ
    [string]$OldExtension = ".ls",           # 元の拡張子
    [string]$NewExtension = ".jar",            # 変換後の拡張子
    [bool]$IncludeSubfolders = $true,         # サブフォルダも対象にするか(true or false)
    [string]$OutputFolder = ""                # 出力フォルダ（空ならリネーム）
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
            Write-Warning "Skipped: '$($file.FullName)' → '$newFullPath' は既に存在します。"
            continue
        }

        try {
            Rename-Item -Path $file.FullName -NewName $newFullPath -Force
            Write-Host "Renamed: $($file.FullName) → $newFullPath"
        } catch {
            Write-Warning "Failed to rename: $($file.FullName) - $_"
        }
    } else {
        # 相対パスを使って新規ファイル作成（別フォルダ）
        $relativePath = $file.FullName.Substring($TargetFolder.Length).TrimStart("\", "/")
        $newRelativePath = [System.IO.Path]::ChangeExtension($relativePath, $NewExtension)
        $newFullPath = Join-Path $OutputFolder $newRelativePath

        $newDir = Split-Path $newFullPath
        if (-not (Test-Path $newDir)) {
            New-Item -ItemType Directory -Path $newDir -Force | Out-Null
        }

        if (Test-Path -Path $newFullPath) {
            Write-Warning "Skipped: '$($file.FullName)' → '$newFullPath' は既に存在します。"
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
