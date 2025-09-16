# Fake Ransomware Simulation & Detection
![image](https://github.com/user-attachments/assets/cba01c98-69ab-41ba-a19d-63b2561b3995")
Bu proje, fidye yazılımı davranışlarını **zararsız bir şekilde** simüle eder ve Sysmon ile tespit edilmesini gösterir.

## 🔴 Red Team
- `fake_ransom_safe.ps1`: Belirtilen klasördeki `.txt` dosyalarını `.locked` uzantısıyla yeniden adlandırır.
- Ransom notu (`FIDYE_NOTU.txt`) bırakır.

## 🔵 Blue Team
- `sysmon_config.xml`: Sysmon yapılandırma dosyası
- Event Viewer üzerinden Event ID:
  - `1`: Process Creation (PowerShell çalıştırma)
  - `11`: File Create (dosya şifrelenmesi)

## 📂 Raporlar
- `reports/BlueTeam_Report.md`: Olay analizi örneği

## 🚀 Çalıştırma
```powershell
# Red Team Simülasyonu
powershell -ExecutionPolicy Bypass -File .\fake_ransom_safe.ps1 -Folder "C:\TestDosyalari"

# Sysmon konfigürasyonunu yükleme
.\Sysmon64.exe -c .\sysmon_config.xml

