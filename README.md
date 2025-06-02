# 🛡️ Enterprise Brute-Force Detection (Windows + Splunk SIEM)

This project simulates and detects brute-force login attacks on a Windows 10 environment using native audit policies, PowerShell simulation, Splunk Universal Forwarder, and Splunk Enterprise. It replicates real-world SOC workflows and log-based detection strategies.

---

## 📌 Project Summary

| Category             | Details                                      |
|----------------------|----------------------------------------------|
| 🌟 Use Case           | Brute-force login detection (Internal + External) |
| 💻 Target Environment | Windows 10 Pro (VM)                         |
| 🛠️ Tools Used         | PowerShell, Splunk Universal Forwarder, Splunk SIEM |
| 🔍 Detection Method   | Log correlation using SPL (Event ID 4625)    |
| 📡 Log Source         | WinEventLog:Security                         |
| 📄 Report Output      | [Incident Report PDF](./report/Brute_Force_Detection_Incident_Report.pdf) |

---

## 🎯 Attack Simulation Phases

### 1. **Internal Attack (PowerShell Simulation)**

```powershell
$user = "testuser"
$wrongpass = "WrongPassword123"

for ($i = 1; $i -le 15; $i++) {
    cmd /c "net use \\127.0.0.1\IPC$ /user:$user $wrongpass"
    Start-Sleep -Milliseconds 500
}
```

- ✅ Generates 15 failed login attempts locally
- ✅ Triggers Event ID 4625 + 4740 (lockout)
- 📸 Screenshot: `script_runned.png`, `security_breach.png`

---

### 2. **External Attack (Kali → Windows 10 via RDP)**

```bash
hydra -t 4 -V -f -l testuser -P /usr/share/wordlists/rockyou.txt rdp://<target_ip>
```

- ✅ Simulates real-world credential brute-force
- ✅ Logs source IP from Kali in Event ID 4625
- 📸 Screenshot: `Externalattackstats.png`

---

## 🔍 SPL Detection Logic (Brute-Force Pattern)

```spl
index=* sourcetype="WinEventLog:Security" EventCode=4625
| bin _time span=1m
| stats count by _time, Account_Name, host
| where count >= 5
```

- ✅ Detects any user with ≥5 failed logins in 1 minute
- 📸 Screenshot: `brute force filter visualization.png`, `Splunk logs recieved.png`

---

## 📄 Key Event IDs Captured

| Event ID | Description             |
|----------|--------------------------|
| 4625     | Failed logon attempt     |
| 4740     | Account lockout (optional) |
| 4672     | Special logon privileges |
| 4776     | Credential validation    |

📸 Screenshots:
- `Audit.png`
- `Audit event capture detail applied.png`
- `index.png`
- `splunk info representation.png`

---

## 📊 SIEM Dashboard Results

- ✅ Search queries successfully triggered in Splunk
- ✅ External IP captured from Kali Linux
- ✅ RDP-based failures also visible in timeline

📸 Sample:
![Brute-force Bar Chart](./screenshots/brute%20force%20filter%20visualization.png)

---

## 🧠 MITRE ATT&CK Mapping

| Tactic             | Technique                        | ID        |
|--------------------|----------------------------------|-----------|
| Credential Access  | Password Guessing (Brute-Force) | T1110.001 |

---

## 🔐 Recommendations

- Enforce account lockout policies (Event 4740)
- Monitor high-frequency Event ID 4625 per user/IP
- Correlate with Event 4776 and Logon_Type for deeper insight
- Use RDP lockout or MFA in production environments
- Simulate alerting via scheduled SPL jobs in Splunk

---

## 📁 Folder Structure

```
enterprise-brute-force-detection-windows-siem/
├── scripts/
│   └── powershell_bruteforce_simulation.ps1
├── detection/
│   └── brute_force_spl_query.spl
├── screenshots/
│   ├── script_runned.png
│   ├── security_breach.png
│   ├── Splunk logs recieved.png
│   ├── brute force filter visualization.png
│   └── Externalattackstats.png
├── report/
│   └── Brute_Force_Detection_Incident_Report.pdf
├── README.md
```

---

## 👨‍💼 Author

**Sumit Kumar**  
SOC Analyst (Junior, Self-Trained)  
🇨🇦 Based in Canada  
📧 [i.sumitkumar@outlook.com](mailto:i.sumitkumar@outlook.com)  
🌐 [GitHub Profile](https://github.com/sumit-kumar)

---

## ✅ Status

- [x] Windows auditing enabled
- [x] Splunk logs ingested via Universal Forwarder
- [x] PowerShell brute-force simulated
- [x] External RDP brute-force simulated
- [x] Event correlation + detection alert working
- [x] Incident report finalized and attached
