# 🔐 Brute Force Login Detection – Windows + Splunk SIEM

This project simulates and detects a brute-force login attack on a Windows 10 virtual machine using native PowerShell, Windows Security Logs, Splunk Universal Forwarder, and Splunk Enterprise SIEM.

---

## 📂 Project Overview

| Category     | Detail                                       |
|--------------|----------------------------------------------|
| 🖥️ Target VM | Windows 10 Pro (VirtualBox)                  |
| 🔧 Tools     | PowerShell, Event Viewer, Splunk, AuditPol   |
| 📡 Detection | SPL Query + SIEM Alerts via Splunk Enterprise |
| 📁 Report    | IR_BruteForce_2025_SumitKumar.pdf             |
| 🧠 Focus     | Threat detection, log correlation, alerting  |

---

## 🎯 Attack Simulation

A PowerShell script was used to simulate 15 failed login attempts for user `testuser` within 1 minute.

```powershell
$user = "testuser"
$wrongpass = "WrongPassword123"

for ($i = 1; $i -le 15; $i++) {
    cmd /c "net use \\127.0.0.1\IPC$ /user:$user $wrongpass"
    Start-Sleep -Milliseconds 500
}
🔍 Detection Logic (SPL)
spl
Copy
Edit
index=* sourcetype="WinEventLog:Security" EventCode=4625
| bin _time span=1m
| stats count by _time, Account_Name, host
| where count >= 5
✅ This triggers an alert if any user has 5 or more failed logins within a 1-minute window.

📊 Screenshots
Visual Evidence	File
PowerShell Script Execution	scripts/attack_script_ran.png
Windows Event Viewer - Event 4625	screenshots/eventviewer_4625.png
Splunk Search - Raw Table	screenshots/splunk_raw_table.png
Splunk Bar Chart - Detection Summary	screenshots/splunk_bar_chart.png
Audit Policy Enabled (AuditPol)	screenshots/auditpol_enabled.png

📄 Incident Response Report
🧾 Download Full PDF Report

Includes:

Attack summary

Evidence screenshots

MITRE mapping (T1110.001)

Detection explanation

Remediation steps

Analyst recommendations

🔐 MITRE ATT&CK Mapping
Technique	Description
T1110.001	Brute Force - Password Guessing

📁 Folder Structure
bash
Copy
Edit
project_brute_force_detection/
├── detection/                   # SPL detection query
│   └── brute_force_detection.spl
├── scripts/                     # Attack simulation code
│   └── powershell_brute_force.ps1
├── screenshots/                 # Log and query screenshots
├── report/                      # Final IR report
│   └── IR_BruteForce_2025_SumitKumar.pdf
└── README.md                    # This file
✅ Status
 Attack simulated (PowerShell brute-force)

 Logs forwarded via Universal Forwarder

 Detection written in SPL

 Alert logic tested

 IR report generated and attached

 [Upcoming] External attack using Kali + Hydra

💼 About the Author
Sumit Kumar
Cybersecurity learner & SOC analyst-in-training
📍 Canada
📧 [YourEmail@example.com]
🌐 GitHub: [github.com/your-username]

yaml
Copy
Edit

---

Just replace:
- `i.sumitkumar@outlook.com` with your real (optional) email  
- `[github.com/sumit-kumar]` with your GitHub profile URL

Let me know when you're ready to move to **Kali (Hydra external brute-force)**.
