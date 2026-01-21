$path = "d:\telsmd\db\cek_potensials.sql"
Write-Host "Reading file..."
$sql = [System.IO.File]::ReadAllText($path)

# --- Define the injected strings exactly as before ---
$checkOff = "SET FOREIGN_KEY_CHECKS=0;`r`n"
$checkOn = "`r`nSET FOREIGN_KEY_CHECKS=1;"

$unitsTable = '
--
-- Struktur dari tabel `units`
--

CREATE TABLE `units` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `unitup` bigint NOT NULL,
  `nama_unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `units_unitup_unique` (`unitup`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

'

# --- Fix Duplicates ---

# 1. Foreign Key Start
# Pattern: CheckOff + CheckOff
$doubleCheckOff = $checkOff + $checkOff
if ($sql.Contains($doubleCheckOff)) {
    $sql = $sql.Replace($doubleCheckOff, $checkOff)
    Write-Host "Fixed duplicate FOREIGN_KEY_CHECKS=0"
}

# 2. Units Table
# Pattern: UnitsTable + NewLine + UnitsTable
# The previous script did: $replacement = $unitsTable + [Environment]::NewLine + $target
# So we likely have $unitsTable + [Environment]::NewLine + $unitsTable
# Note: [Environment]::NewLine in PowerShell on Windows is `r`n.

$doubleUnits = $unitsTable + [Environment]::NewLine + $unitsTable
# Also try without specific newline just in case
if ($sql.Contains($doubleUnits)) {
    $sql = $sql.Replace($doubleUnits, $unitsTable)
    Write-Host "Fixed duplicate units table"
} else {
    # Backup check: try strictly replacing the text if slightly different spacing
    # But based on view_file, it looks congruent.
    Write-Warning "Did not find exact duplicate units block. Checking manually..."
}

# 3. Foreign Key End
# Pattern: CheckOn + CheckOn
$doubleCheckOn = $checkOn + $checkOn
if ($sql.Contains($doubleCheckOn)) {
    $sql = $sql.Replace($doubleCheckOn, $checkOn)
    Write-Host "Fixed duplicate FOREIGN_KEY_CHECKS=1"
}

Write-Host "Saving file..."
[System.IO.File]::WriteAllText($path, $sql)
Write-Host "Done."
