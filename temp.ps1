$maxPathLength = 260
$maxFilenameOnlyLength = 50
$root = "C:\Users\mosuk\Desktop\University"  # ← 必要に応じて変更

Get-ChildItem -Path $root -Recurse -File | ForEach-Object {
    $fullPath = $_.FullName
    $directory = $_.DirectoryName
    $extension = $_.Extension
    $filenameOnly = $_.BaseName

    # ファイル名のみが50文字を超えていたら短縮
    if ($filenameOnly.Length -gt $maxFilenameOnlyLength) {
        $newFilenameOnly = $filenameOnly.Substring(0, $maxFilenameOnlyLength)
        $newFilename = "$newFilenameOnly$extension"
        $newFullPath = Join-Path $directory $newFilename

        if (-not (Test-Path $newFullPath)) {
            Rename-Item -Path $_.FullName -NewName $newFilename
            Write-Output "Renamed:`n  $fullPath`n→ $newFullPath`n"
        } else {
            Write-Warning "スキップ（同名ファイルあり）: $newFullPath"
        }
    }
}
