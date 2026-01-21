$path = "d:\telsmd\db\cek_potensials.sql"
Write-Host "Reading file..."
$sql = [System.IO.File]::ReadAllText($path)

# 1. Fix Foreign Key Duplicates
Write-Host "Fixing FK checks duplicates..."
$fkCheck = "SET FOREIGN_KEY_CHECKS=0;"
# Regex replace all occurrences of FK=0; followed by whitespace with a single one
$sql = $sql -replace "(SET FOREIGN_KEY_CHECKS=0;\s*)+", "$fkCheck`r`n"


# 2. Fix Units Table Duplicates
$marker = '-- Struktur dari tabel `units`'
$endMarker = ') ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;'

$idx1 = $sql.IndexOf($marker)
if ($idx1 -ge 0) {
    $idx2 = $sql.IndexOf($marker, $idx1 + 20)
    if ($idx2 -gt 0) {
        Write-Host "Found duplicate units table start at $idx2"
        $idxEnd = $sql.IndexOf($endMarker, $idx2)
        if ($idxEnd -gt 0) {
            $removeLen = ($idxEnd + $endMarker.Length) - $idx2
            
            # Remove content
            $sql = $sql.Remove($idx2, $removeLen)
            
            # Also clean up extra empty lines if any (crudely)
            $sql = $sql.Replace("`r`n`r`n`r`n`r`n", "`r`n`r`n")
            
            Write-Host "Removed duplicate units table."
        } else {
            Write-Warning "Could not find end marker for duplicate table."
        }
    } else {
        Write-Host "No duplicate units table header found."
    }
}

# 3. Fix End FK Duplicates
$endFk = "SET FOREIGN_KEY_CHECKS=1;"
$sql = $sql -replace "(SET FOREIGN_KEY_CHECKS=1;\s*)+", "$endFk`r`n"

Write-Host "Saving file..."
[System.IO.File]::WriteAllText($path, $sql)
Write-Host "Done."
