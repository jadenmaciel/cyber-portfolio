# Cryptomator Encrypted Vault – Secure Folder Encryption Project

## 1. Title & One-Line Outcome

**Cryptomator Encrypted Vault:** Created and validated an encrypted vault using Cryptomator to protect sensitive files and securely share access credentials.

---

## 2. Problem / Objectives

Demonstrate practical encryption of files and folders using open-source tools.
Focus: protect data on removable or cloud storage from unauthorized access and explore secure password-sharing methods that avoid interception or key reuse.

---

## 3. Environment & Prerequisites

- **Operating System:** Windows 11 Pro (64-bit)
- **Software:** Cryptomator 1.10.x (open-source desktop edition)
- **Encryption scheme:** AES-256 with filename obfuscation
- **Hardware:** Local SSD + USB thumb drive test
- **Test password:** `Thunderbird1234`
- **Date executed:** 2025-09-29

---

## 4. Steps Summary

1. Downloaded Cryptomator from [https://cryptomator.org/downloads](https://cryptomator.org/downloads) and installed it.
2. Opened the app → clicked **"+ Add Vault"** → selected **"Create New Vault."**
3. Named vault **"Jaden Maciel-Shapiro."**
4. Chose **Custom Location** on Desktop for easy access.
5. Set password to `Thunderbird1234`.
6. Clicked **Unlock Now** to mount encrypted drive.
7. Created file `YourEmail.txt` inside the unlocked drive and entered my email address.
8. Added a personal picture file (`.jpg`) to validate encrypted media storage.
9. Created `Key sharing.txt` describing a secure method to transmit the password across long distances without encryption.
10. Closed all open files, then clicked **Lock Vault** to secure the drive.
11. Compressed the vault folder into `Jaden Maciel-Shapiro.zip`.
12. Verified successful decryption by re-importing the unzipped vault using **"Open Existing Vault."**

---

## 5. Evidence (Text-Only)

**Evidence 01 — Vault Creation & Mounting**
- *What would be visible:* Cryptomator main window showing vault name and "Unlocked" status.
- *Text excerpt:*

  ```text
  Vault: Jaden Maciel-Shapiro
  Status: Unlocked (Drive letter E:\)
  Encryption: AES-256, filename encryption enabled
  ```

* *Why this matters:* Confirms encrypted vault was successfully created and mounted.

**Evidence 02 — Vault Contents After Unlock**

* *What would be visible:* File Explorer for mounted drive showing three files.
* *Text excerpt:*

  ```text
  E:\YourEmail.txt
  E:\Key sharing.txt
  E:\photo.jpg
  ```
* *Why this matters:* Demonstrates that files were added inside the encrypted environment.

**Evidence 03 — Secure Key-Sharing Plan**

* *What would be visible:* Text file content of "Key sharing.txt."
* *Text excerpt (summary):*
  "The only truly secure method is in-person physical transfer of the password written on paper, handed directly, avoiding any electronic transmission."
* *Why this matters:* Meets requirement for a secure non-encrypted password-exchange strategy.

**Evidence 04 — Vault Lock Verification**

* *What would be visible:* Cryptomator UI showing vault "Locked."
* *Text excerpt:*

  ```text
  Vault: Jaden Maciel-Shapiro
  Status: Locked
  ```
* *Why this matters:* Confirms encryption re-engaged and vault inaccessible without password.

**Evidence 05 — Decryption Validation**

* *What would be visible:* Successfully re-added vault and opened it using the same password.
* *Text excerpt:*

  ```text
  Unlock successful.
  Mounted drive E:\ accessible.
  File check → All original files present.
  ```
* *Why this matters:* Verifies that data recovery and encryption integrity worked end-to-end.

---

## 6. Results & Validation

* Vault encrypted and decrypted without data loss.
* All three required files present post-decryption.
* Password authentication functioned properly.
* Compression and relocation did not corrupt the vault.
* Verified AES-256 filename encryption by observing obfuscated filenames when locked.

---

## 7. Timeline / Activity Dates

* **2025-09-29 — Installed Cryptomator v1.10.x**
* **2025-09-29 — Created and mounted vault "Jaden Maciel-Shapiro"**
* **2025-09-29 — Added files and tested key-sharing note**
* **2025-09-29 — Locked, zipped, and validated decryption**

---

## 8. What I Learned

* Understood how client-side encryption works for cloud-synced data.
* Practiced secure password-sharing design without cryptographic key reuse.
* Learned how filename obfuscation hides metadata.
* Verified encryption persistence across zip and unzip operations.
* Strengthened awareness of physical vs digital key-exchange trade-offs.

---

## 9. Troubleshooting Notes

* Encountered *"Graceful Lock Failed"* when files remained open in Notepad → resolved by closing handles.
* Verified "Force Lock" only when no files were open.
* Ensured drive letter dismounted before re-zipping to avoid corruption.
* Confirmed portable .exe works without admin rights on USB drives.

---

## 10. Author / Ownership

This project was performed hands-on by **Jaden Maciel-Shapiro** on **September 29, 2025** as part of personal cybersecurity portfolio work focusing on encryption and secure key management.

Repository maintained for professional demonstration of applied cryptography skills.
