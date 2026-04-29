# 🛡️ Purple Team SOC Lab with Wazuh

> Advanced Security Operations Center laboratory featuring MITRE ATT&CK detection, C2 simulation, and AI-powered log analysis.

![Lab Status](https://img.shields.io/badge/Status-Active-brightgreen)
![MITRE Coverage](https://img.shields.io/badge/MITRE%20Coverage-10%2B%20Techniques-blue)
![Platform](https://img.shields.io/badge/Platform-Wazuh%204.9-orange)

---

## 📋 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Features](#features)
- [MITRE ATT&CK Coverage](#mitre-attck-coverage)
- [Project Status](#project-status)
- [Quick Start](#quick-start)
- [Documentation](#documentation)
- [Roadmap](#roadmap)
- [Skills Demonstrated](#skills-demonstrated)

---

## 🎯 Overview

This project demonstrates a fully functional **Purple Team SOC Lab** built from scratch, combining:

- **Blue Team**: Wazuh SIEM for detection and monitoring
- **Red Team**: C2 framework (Metasploit) for attack simulation
- **Purple Team**: Continuous improvement cycle of attack → detect → improve

**Purpose**: Portfolio project showcasing practical SOC skills for cybersecurity analyst roles, with a focus on MITRE ATT&CK framework and AI-assisted security operations.

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Purple Team Lab                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────┐          ┌──────────────────────┐       │
│  │   Windows    │          │   Ubuntu Server      │       │
│  │   Endpoint   │◄────────►│                      │       │
│  │              │   Agent   │  ┌────────────────┐ │       │
│  │ - Wazuh Agent│          │  │ Wazuh Manager  │ │       │
│  │ - PowerShell │          │  │ Wazuh Indexer  │ │       │
│  │   Logging    │          │  │ Wazuh Dashboard│ │       │
│  │              │          │  └────────────────┘ │       │
│  └──────────────┘          │                      │       │
│         ▲                  │  ┌────────────────┐ │       │
│         │                  │  │ C2 Framework   │ │       │
│         │  Implant         │  │ (Metasploit)   │ │       │
│         └──────────────────┤  └────────────────┘ │       │
│                            │                      │       │
│                            └──────────────────────┘       │
│                                                             │
│  Network: 192.168.1.0/24 (VirtualBox Host-Only)           │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Components:

- **Wazuh Manager**: Security event management and correlation
- **Wazuh Indexer**: Log storage and search (OpenSearch-based)
- **Wazuh Dashboard**: Web UI for visualization and analysis
- **Windows Agent**: Monitored endpoint with PowerShell logging
- **C2 Framework**: Metasploit for simulating real-world attacks

---

## ✨ Features

### Implemented (✅)

- **✅ SIEM Deployment**: Wazuh 4.9 all-in-one installation
- **✅ Agent Management**: Windows agent with custom configuration
- **✅ PowerShell Logging**: Advanced script block logging
- **✅ Custom Detection Rules**: MITRE ATT&CK-mapped rules
- **✅ C2 Integration**: Metasploit Meterpreter for attack simulation
- **✅ Attack Simulation**: Automated scripts for common techniques
- **✅ MITRE Mapping**: 10+ techniques detected and documented

### In Progress (🚧)

- **🚧 Active Response**: Automated blocking and remediation
- **🚧 Threat Intelligence**: AlienVault OTX integration
- **🚧 Custom Dashboards**: MITRE ATT&CK heatmap visualization

### Planned (📅)

- **📅 AI Integration**: RAG-based log analysis with LLM
- **📅 Anomaly Detection**: ML-based behavioral analysis
- **📅 Cloud Migration**: Terraform deployment to AWS/Azure
- **📅 Compliance**: PCI-DSS and GDPR policy implementation

---

## 🎖️ MITRE ATT&CK Coverage

### Tactics & Techniques Detected:

| Technique ID | Technique Name | Detection Method | Status |
|--------------|----------------|------------------|--------|
| **T1110** | Brute Force | Failed login correlation | ✅ Active |
| **T1059.001** | PowerShell | Script block logging + regex | ✅ Active |
| **T1083** | File/Directory Discovery | Sysmon + Wazuh rules | ✅ Active |
| **T1082** | System Information Discovery | Process monitoring | ✅ Active |
| **T1057** | Process Discovery | Process enumeration detection | ✅ Active |
| **T1113** | Screen Capture | Meterpreter command logging | ✅ Active |
| **T1078** | Valid Accounts | Account usage anomalies | ✅ Active |
| **T1003** | Credential Dumping | LSASS access monitoring | 🚧 Configured |
| **T1068** | Privilege Escalation | Runas/UAC bypass detection | 🚧 Configured |
| **T1021** | Remote Services | RDP/SMB monitoring | 📅 Planned |

**Coverage**: 10+ techniques actively detected and tested

---

## 📊 Project Status

### Phase 1: Foundation ✅ COMPLETED

- [x] Wazuh infrastructure deployed
- [x] Windows agent configured
- [x] PowerShell logging enabled
- [x] Network connectivity established
- [x] Basic detection rules implemented

### Phase 2: Purple Team Operations 🚧 IN PROGRESS (70%)

- [x] C2 framework deployed (Metasploit)
- [x] Implant generation and execution
- [x] Attack simulations executed
- [x] Detections validated
- [ ] Active Response configured
- [ ] Threat Intelligence integrated
- [ ] Custom dashboards created

### Phase 3: AI Integration 📅 PLANNED

- [ ] RAG system for log analysis
- [ ] LLM-powered incident reporting
- [ ] Anomaly detection with ML
- [ ] Auto-IOC generation

### Phase 4: Cloud & Compliance 📅 PLANNED

- [ ] Terraform IaC
- [ ] AWS/Azure deployment
- [ ] Compliance frameworks (PCI-DSS, GDPR)
- [ ] SIEM integration (Sentinel/Splunk)

**Overall Progress**: ~40% complete

---

## 🚀 Quick Start

### Prerequisites

- VirtualBox (or VMware)
- Ubuntu Server 24.04 LTS (minimum 8GB RAM)
- Windows 10/11 (minimum 4GB RAM)
- Network: Host-Only Adapter configured

### Installation

1. **Deploy Wazuh (Ubuntu Server)**

```bash
# Install Wazuh all-in-one
curl -sO https://packages.wazuh.com/4.9/wazuh-install.sh
sudo bash ./wazuh-install.sh -a

# Save credentials shown at the end
```

2. **Configure Windows Agent**

```powershell
# Download and install agent from Wazuh dashboard
# Settings → Agents → Deploy new agent

# Enable PowerShell logging
.\scripts\Enable-PowerShellLogging.ps1
```

3. **Deploy Custom Rules**

```bash
# Copy custom rules to Wazuh
sudo nano /var/ossec/etc/rules/local_rules.xml
# Paste rules from docs/custom-rules.xml

# Restart Wazuh
sudo systemctl restart wazuh-manager
```

4. **Run Attack Simulations**

```powershell
# Execute attack simulator
.\scripts\SOC-Lab-Attack-Simulator.ps1 -AttackType All
```

5. **Access Dashboard**

```
URL: https://<WAZUH_SERVER_IP>
User: admin
Password: <from_installation>
```

---

## 📚 Documentation

### Technical Guides

- **[Setup Guide](docs/01-Setup-Guide.md)**: Detailed installation instructions
- **[Attack Simulation](docs/02-Attack-Simulation.md)**: How to run C2 attacks
- **[Detection Rules](docs/03-Detection-Rules.md)**: Custom Wazuh rules explained
- **[MITRE Mapping](docs/04-MITRE-Mapping.md)**: Full coverage matrix

### Scripts

- **[SOC-Lab-Attack-Simulator.ps1](scripts/SOC-Lab-Attack-Simulator.ps1)**: Automated attack generation
- **[Enable-PowerShellLogging.ps1](scripts/Enable-PowerShellLogging.ps1)**: PowerShell audit configuration
- **[Custom Wazuh Rules](config/local_rules.xml)**: MITRE-mapped detection rules

### Roadmap

- **[Complete Roadmap](docs/SOC-Lab-Roadmap.md)**: Full project plan (Levels 1-4)
- **[Progress Tracking](docs/PROGRESS.md)**: Current status and next steps

---

## 💼 Skills Demonstrated

### Technical Skills

- **SIEM Deployment & Configuration**: Wazuh full stack
- **Detection Engineering**: Custom rules mapped to MITRE ATT&CK
- **Attack Simulation**: C2 frameworks (Metasploit, Sliver)
- **Log Analysis**: PowerShell script block logging, Windows Event Log
- **Incident Response**: Purple Team methodology
- **Network Security**: VirtualBox network isolation and configuration
- **Linux Administration**: Ubuntu Server, systemd, firewall management
- **Scripting**: PowerShell, Bash, Python (planned)

### Frameworks & Standards

- MITRE ATT&CK Framework
- NIST Cybersecurity Framework (detection & response)
- Kill Chain methodology
- Purple Team operations

---

## 🎓 Learning Outcomes

This project demonstrates practical knowledge of:

1. **SOC Operations**: Real-world SIEM deployment and tuning
2. **Threat Detection**: Building custom detection rules
3. **Purple Teaming**: Combining offensive and defensive security
4. **MITRE ATT&CK**: Mapping techniques to real-world detections
5. **Incident Response**: Identifying and analyzing security events

**Target Roles**: SOC Analyst, Security Engineer, Threat Detection Engineer, Purple Team Analyst

---

## 📄 License

This project is for educational and portfolio purposes.

**Note**: All attack simulations are conducted in isolated lab environments. Do not use against systems you don't own.

---

## 📊 Project Stats

- **Start Date**: 2026-04-29
- **Current Phase**: Level 2 - Purple Team (70%)
- **Lines of Code**: ~500+ (scripts)
- **Documentation Pages**: 5+ technical guides
- **MITRE Techniques**: 10+ detected
- **Time Invested**: ~15 hours

---

**Last Updated**: 2026-04-29
**Status**: 🚧 Active Development
