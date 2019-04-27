# InsertHeader.ps1
# Copyright 2019 TOMA
# MIT License

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
