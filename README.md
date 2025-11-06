# PowerShell Filesystem Metrics Lab

**Outcome:** Measured per-folder size, last-modified timestamps, and basic inventory of the **Documents** directory using PowerShell pipelines and object formatting; captured evidence via three screenshots.

> The original lab brief (PDF/Word) should be placed in `/docs/` and committed with the repo.

---

## Problem / objectives

- Enumerate each subfolder in **Documents** and report:

  - Total size (MB) calculated from all nested files.

  - Last write time for each folder.

  - A readable summary per folder (size or "Empty folder").

- Practice PowerShell pipelines (`|`), calculated properties, and formatting.

- Produce three screenshots that show working commands and output.

---

## Environment & prerequisites

- **Windows 10/11** (or Windows Server 2022/2025) with PowerShell **5.1** (Windows PowerShell).

- A user profile with a standard **Documents** directory.

- Administrator PowerShell session recommended (for convenience and consistency).

- Network access not required.

---

## Steps summary

1. **Open PowerShell (Admin)** and set a variable for the Documents path, then change directory:

   ```powershell
   $homePath = [Environment]::GetFolderPath("MyDocuments")
   Set-Location $homePath
   ```

2. **Per-folder total size (MB):**

   ```powershell
   Get-ChildItem -Path . -Directory | ForEach-Object {
     $_.FullName + ": " + "{0:N2}" -f ((Get-ChildItem $_.FullName -Recurse |
       Measure-Object -Property Length -Sum).Sum / 1MB) + " MB"
   }
   ```

3. **Per-folder last write time:**

   ```powershell
   $homePath = [Environment]::GetFolderPath("MyDocuments")
   Set-Location $homePath
   Get-ChildItem -Path . -Directory | ForEach-Object { $_.FullName + ": " + $_.LastWriteTime }
   ```

4. **Per-folder size with empty-folder handling:**

   ```powershell
   $homePath = [Environment]::GetFolderPath("MyDocuments")
   Set-Location $homePath
   Get-ChildItem -Path . -Directory | ForEach-Object {
     $folderPath = $_.FullName
     $size = (Get-ChildItem $folderPath -Recurse |
              Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue).Sum
     if ($size -ne $null) {
       $size = $size / 1MB
       $_.FullName + ": " + "{0:N2}" -f $size + " MB"
     } else {
       $_.FullName + ": " + "Empty folder"
     }
   }
   ```

5. **Capture evidence** as screenshots of your console showing the commands and outputs.

6. **Organize the repo**: place screenshots in `/artifacts/`, the lab brief in `/docs/`, and commit.

---

## Evidence & artifacts

Save exactly these three images to `/artifacts/`:

* `01-documents-folder-sizes.png` — Console showing the size-per-folder script and its output.

* `02-documents-lastwrite-times.png` — Console showing the last write time per folder.

* `03-documents-counts-and-size.png` — Console showing the size with empty-folder handling.

> Name your files exactly as above so graders and recruiters can scan them quickly.

---

## Results & validation

You're finished when:

* All three commands execute without errors and display readable output.

* The three screenshots in `/artifacts/` clearly show both the command(s) and the resulting lines.

* The README and directory structure match this repository layout, and the original lab prompt resides in `/docs/`.

---

## What I Learned

* Built practical PowerShell pipelines using `ForEach-Object`, `Measure-Object`, and `Get-ChildItem`.

* Converted raw byte sums into human-readable megabytes with formatted strings.

* Handled edge cases (no files → "Empty folder") using conditional logic.

* Produced a clean artifact trail suitable for portfolio review.

---

## Troubleshooting notes

* **No output shown:** Ensure you're in the correct path:

  `Set-Location ([Environment]::GetFolderPath("MyDocuments"))`

* **Access denied on some folders:** Add `-ErrorAction SilentlyContinue` to skip unreadable items.

* **Very slow on huge trees:** Add `-Directory` to limit the outer enumeration and avoid measuring system paths; consider testing on a smaller sample path.

* **Numbers look too small/large:** Confirm you divide the `Measure-Object` sum by `1MB` (not `1KB`), and don't double-divide.

---

## /src/ script references

If you choose to save scripts, use these filenames under `/src/` (the code appears above in this README):

* `folder-sizes.ps1`

* `folder-lastwrite.ps1`

* `folder-size-or-empty.ps1`
