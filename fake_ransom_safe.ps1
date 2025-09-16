param(
    [string]$Folder = "C:\TestDosyalari",
    [switch]$DryRun
)

$whitelist = @("C:\TestDosyalari")
try {
    $full = (Get-Item $Folder -ErrorAction Stop).FullName
} catch {
    Write-Error "Folder not found: $Folder"
    exit 1
}
if (-not ($whitelist -contains $full)) {
    Write-Error "Folder not whitelisted. Exiting."
    exit 1
}

$txts = Get-ChildItem -Path $Folder -File -Filter *.txt -ErrorAction SilentlyContinue
Write-Host "Found $($txts.Count) .txt files in $Folder"
foreach ($f in $txts) {
    $new = "$($f.FullName).locked"
    if ($DryRun) {
        Write-Host "[DRY-RUN] Would rename $($f.FullName) -> $new"
    } else {
        try {
            Rename-Item -Path $f.FullName -NewName "$($f.Name).locked" -ErrorAction Stop
            Write-Host "Renamed $($f.Name) -> $($f.Name).locked"
        } catch {
            Write-Host "Failed to rename $($f.FullName): $_"
        }
    }
}

$note = Join-Path $Folder "FIDYE_NOTU.txt"
if ($DryRun) {
    Write-Host "[DRY-RUN] Would create ransom note: $note"
} else {
    "Dosyalarınız kilitlendi, kurtarmak için bize ulaşın." | Out-File -FilePath $note -Encoding UTF8 -Force
    Write-Host "Created ransom note: $note"
}
