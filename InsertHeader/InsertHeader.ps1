# InsertHeader.ps1
# Copyright 2019 TOMA
# MIT License
#
# ソースファイルのヘッダコメントを一括で挿入するスクリプト
# TargetFolder - 処理対象のソースファイルが存在するフォルダ
# TargetExtension - 処理対象ファイルの拡張子（「.」込みで指定）
# InsertFile - 挿入するコメントを記述したファイル
# CompareLines - 挿入コメントと対象ファイルの比較行数。
#                先頭からこの行数分比較を行い、不一致の行がある場合のみ挿入を行う。
#                (0、未指定の場合は比較不一致なしと判断されるので挿入は行われない）

Param (
    [parameter(mandatory)][string]$TagetFolder,
    [parameter(mandatory)][string]$TagetExtension,
    [parameter(mandatory)][string]$InsertFile,
    [int]$CompareLines
)

$inserts = Get-Content $InsertFile

$files = Get-ChildItem $TagetFolder -Recurse -File | Where-Object { $_.Extension -eq $TagetExtension }

foreach ($file in $files) {
    $src = Get-Content $file.FullName

    $abort = $True

    for ($i = 0; $i -lt $CompareLines; $i++) {
        if ($inserts[$i] -ne $src[$i]) {
            $abort = $False
            break
        }
    }

    if ($abort) {
        "$($file.FullName) : Not Inserted."
        continue
    }

    $inserts | Set-Content $file.FullName -Encoding UTF8 
    $src | Add-Content $file.FullName -Encoding UTF8

    "$($file.FullName) : Inserted!!!"
}
