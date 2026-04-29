# 🛡️ Laboratorio Purple Team SOC con Wazuh

> Laboratorio avanzado de Security Operations Center con detección MITRE ATT&CK, simulación C2 y análisis de logs asistido por IA.

![Estado del Lab](https://img.shields.io/badge/Estado-Activo-brightgreen)
![Cobertura MITRE](https://img.shields.io/badge/Cobertura%20MITRE-10%2B%20T%C3%A9cnicas-blue)
![Plataforma](https://img.shields.io/badge/Plataforma-Wazuh%204.9-orange)

📖 **[English Version](README-ENG.md)**

---

## 📋 Tabla de Contenidos

- [Descripción General](#descripción-general)
- [Arquitectura](#arquitectura)
- [Funcionalidades](#funcionalidades)
- [Cobertura MITRE ATT&CK](#cobertura-mitre-attck)
- [Estado del Proyecto](#estado-del-proyecto)
- [Inicio Rápido](#inicio-rápido)
- [Documentación](#documentación)
- [Roadmap](#roadmap)
- [Habilidades Demostradas](#habilidades-demostradas)

---

## 🎯 Descripción General

Este proyecto demuestra un **Laboratorio Purple Team SOC** completamente funcional construido desde cero, combinando:

- **Blue Team**: Wazuh SIEM para detección y monitoreo
- **Red Team**: C2 framework (Metasploit) para simulación de ataques
- **Purple Team**: Ciclo de mejora continua ataque → detectar → mejorar

**Propósito**: Proyecto de portfolio que demuestra habilidades prácticas de SOC para roles de analista de ciberseguridad, con enfoque en el framework MITRE ATT&CK y operaciones de seguridad asistidas por IA.

---

## 🏗️ Arquitectura

```
┌─────────────────────────────────────────────────────────────┐
│                   Laboratorio Purple Team                   │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────┐          ┌──────────────────────┐       │
│  │   Windows    │          │   Ubuntu Server      │       │
│  │   Endpoint   │◄────────►│                      │       │
│  │              │   Agente  │  ┌────────────────┐ │       │
│  │ - Agente Wazuh│         │  │ Wazuh Manager  │ │       │
│  │ - Logging    │          │  │ Wazuh Indexer  │ │       │
│  │   PowerShell │          │  │ Wazuh Dashboard│ │       │
│  │              │          │  └────────────────┘ │       │
│  └──────────────┘          │                      │       │
│         ▲                  │  ┌────────────────┐ │       │
│         │                  │  │ C2 Framework   │ │       │
│         │  Implant         │  │ (Metasploit)   │ │       │
│         └──────────────────┤  └────────────────┘ │       │
│                            │                      │       │
│                            └──────────────────────┘       │
│                                                             │
│  Red: 192.168.1.0/24 (VirtualBox Host-Only)               │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Componentes:

- **Wazuh Manager**: Gestión y correlación de eventos de seguridad
- **Wazuh Indexer**: Almacenamiento y búsqueda de logs (basado en OpenSearch)
- **Wazuh Dashboard**: Interfaz web para visualización y análisis
- **Agente Windows**: Endpoint monitoreado con logging de PowerShell
- **C2 Framework**: Metasploit para simular ataques del mundo real

---

## ✨ Funcionalidades

### Implementadas (✅)

- **✅ Despliegue SIEM**: Instalación all-in-one de Wazuh 4.9
- **✅ Gestión de Agentes**: Agente Windows con configuración personalizada
- **✅ Logging PowerShell**: Logging avanzado de script block
- **✅ Reglas de Detección Personalizadas**: Reglas mapeadas a MITRE ATT&CK
- **✅ Integración C2**: Metasploit Meterpreter para simulación de ataques
- **✅ Simulación de Ataques**: Scripts automatizados para técnicas comunes
- **✅ Mapeo MITRE**: 10+ técnicas detectadas y documentadas

### En Progreso (🚧)

- **🚧 Active Response**: Bloqueo y remediación automática
- **🚧 Threat Intelligence**: Integración con AlienVault OTX
- **🚧 Dashboards Personalizados**: Visualización de heatmap MITRE ATT&CK

### Planificadas (📅)

- **📅 Integración IA**: Análisis de logs basado en RAG con LLM
- **📅 Detección de Anomalías**: Análisis comportamental basado en ML
- **📅 Migración Cloud**: Despliegue con Terraform en AWS/Azure
- **📅 Compliance**: Implementación de políticas PCI-DSS y GDPR

---

## 🎖️ Cobertura MITRE ATT&CK

### Tácticas y Técnicas Detectadas:

| ID Técnica | Nombre de la Técnica | Método de Detección | Estado |
|-----------|---------------------|---------------------|--------|
| **T1110** | Brute Force | Correlación de logins fallidos | ✅ Activo |
| **T1059.001** | PowerShell | Script block logging + regex | ✅ Activo |
| **T1083** | File/Directory Discovery | Sysmon + reglas Wazuh | ✅ Activo |
| **T1082** | System Information Discovery | Monitoreo de procesos | ✅ Activo |
| **T1057** | Process Discovery | Detección de enumeración | ✅ Activo |
| **T1113** | Screen Capture | Logging de comandos Meterpreter | ✅ Activo |
| **T1078** | Valid Accounts | Anomalías de uso de cuentas | ✅ Activo |
| **T1003** | Credential Dumping | Monitoreo de acceso a LSASS | 🚧 Configurado |
| **T1068** | Privilege Escalation | Detección de bypass UAC/Runas | 🚧 Configurado |
| **T1021** | Remote Services | Monitoreo RDP/SMB | 📅 Planificado |

**Cobertura**: 10+ técnicas activamente detectadas y testeadas

---

## 📊 Estado del Proyecto

### Fase 1: Fundación ✅ COMPLETADA

- [x] Infraestructura Wazuh desplegada
- [x] Agente Windows configurado
- [x] Logging PowerShell habilitado
- [x] Conectividad de red establecida
- [x] Reglas de detección básicas implementadas

### Fase 2: Operaciones Purple Team 🚧 EN PROGRESO (70%)

- [x] C2 framework desplegado (Metasploit)
- [x] Generación y ejecución de implant
- [x] Simulaciones de ataque ejecutadas
- [x] Detecciones validadas
- [ ] Active Response configurado
- [ ] Threat Intelligence integrado
- [ ] Dashboards personalizados creados

### Fase 3: Integración IA 📅 PLANIFICADA

- [ ] Sistema RAG para análisis de logs
- [ ] Generación de informes de incidentes con LLM
- [ ] Detección de anomalías con ML
- [ ] Generación automática de IOCs

### Fase 4: Cloud y Compliance 📅 PLANIFICADA

- [ ] Terraform IaC
- [ ] Despliegue AWS/Azure
- [ ] Frameworks de compliance (PCI-DSS, GDPR)
- [ ] Integración SIEM (Sentinel/Splunk)

**Progreso General**: ~40% completado

---

## 🚀 Inicio Rápido

### Requisitos Previos

- VirtualBox (o VMware)
- Ubuntu Server 24.04 LTS (mínimo 8GB RAM)
- Windows 10/11 (mínimo 4GB RAM)
- Red: Adaptador Host-Only configurado

### Instalación

1. **Desplegar Wazuh (Ubuntu Server)**

```bash
# Instalar Wazuh all-in-one
curl -sO https://packages.wazuh.com/4.9/wazuh-install.sh
sudo bash ./wazuh-install.sh -a

# Guardar credenciales mostradas al final
```

2. **Configurar Agente Windows**

```powershell
# Descargar e instalar agente desde el dashboard de Wazuh
# Settings → Agents → Deploy new agent

# Habilitar logging PowerShell
.\scripts\Enable-PowerShellLogging.ps1
```

3. **Desplegar Reglas Personalizadas**

```bash
# Copiar reglas personalizadas a Wazuh
sudo nano /var/ossec/etc/rules/local_rules.xml
# Pegar reglas desde docs/custom-rules.xml

# Reiniciar Wazuh
sudo systemctl restart wazuh-manager
```

4. **Ejecutar Simulaciones de Ataque**

```powershell
# Ejecutar simulador de ataques
.\scripts\SOC-Lab-Attack-Simulator.ps1 -AttackType All
```

5. **Acceder al Dashboard**

```
URL: https://<IP_SERVIDOR_WAZUH>
Usuario: admin
Contraseña: <de_la_instalación>
```

---

## 📚 Documentación

### Guías Técnicas

- **[Guía de Instalación](docs/01-Guia-Instalacion.md)**: Instrucciones detalladas de instalación
- **[Simulación de Ataques](docs/02-Simulacion-Ataques.md)**: Cómo ejecutar ataques C2
- **[Reglas de Detección](docs/03-Reglas-Deteccion.md)**: Reglas personalizadas de Wazuh explicadas
- **[Mapeo MITRE](docs/04-Mapeo-MITRE.md)**: Matriz de cobertura completa

### Scripts

- **[SOC-Lab-Attack-Simulator.ps1](scripts/SOC-Lab-Attack-Simulator.ps1)**: Generación automática de ataques
- **[Enable-PowerShellLogging.ps1](scripts/Enable-PowerShellLogging.ps1)**: Configuración de auditoría PowerShell
- **[Reglas Personalizadas Wazuh](config/local_rules.xml)**: Reglas de detección mapeadas a MITRE

### Roadmap

- **[Roadmap Completo](docs/SOC-Lab-Roadmap.md)**: Plan completo del proyecto (Niveles 1-4)
- **[Seguimiento de Progreso](docs/PROGRESS.md)**: Estado actual y próximos pasos

---

## 🗺️ Roadmap

### Hitos Completados

- ✅ **Nivel 1**: SIEM básico con detección
- ✅ **Nivel 2 (70%)**: Purple Team con simulación C2

### Próximos Hitos

- 🚧 **Completar Nivel 2**: Active Response + Threat Intel (1-2 semanas)
- 📅 **Nivel 3**: Integración IA (2-3 semanas)
- 📅 **Nivel 4**: Migración Cloud (opcional, 1-2 semanas)

**Finalización estimada**: 4-6 semanas desde el inicio

---

## 💼 Habilidades Demostradas

### Habilidades Técnicas

- **Despliegue y Configuración SIEM**: Stack completo de Wazuh
- **Ingeniería de Detección**: Reglas personalizadas mapeadas a MITRE ATT&CK
- **Simulación de Ataques**: C2 frameworks (Metasploit, Sliver)
- **Análisis de Logs**: Script block logging de PowerShell, Windows Event Log
- **Respuesta a Incidentes**: Metodología Purple Team
- **Seguridad de Red**: Aislamiento y configuración de red en VirtualBox
- **Administración Linux**: Ubuntu Server, systemd, gestión de firewall
- **Scripting**: PowerShell, Bash, Python (planificado)

### Frameworks y Estándares

- MITRE ATT&CK Framework
- NIST Cybersecurity Framework (detección y respuesta)
- Metodología Kill Chain
- Operaciones Purple Team

### Habilidades Blandas

- Documentación técnica
- Resolución sistemática de problemas
- Investigación en seguridad y autoaprendizaje
- Planificación y ejecución de proyectos

---

## 🎓 Resultados de Aprendizaje

Este proyecto demuestra conocimiento práctico de:

1. **Operaciones SOC**: Despliegue y ajuste de SIEM en el mundo real
2. **Detección de Amenazas**: Construcción de reglas de detección personalizadas
3. **Purple Teaming**: Combinación de seguridad ofensiva y defensiva
4. **MITRE ATT&CK**: Mapeo de técnicas a detecciones reales
5. **Respuesta a Incidentes**: Identificación y análisis de eventos de seguridad

**Roles Objetivo**: SOC Analyst, Security Engineer, Threat Detection Engineer, Purple Team Analyst

---

## 📧 Autor

**Ruben**
- 🎯 **Objetivo**: SOC Analyst → AI Security Specialist
- 🎓 **Formación**: ASIR (Administración de Sistemas Informáticos en Red)
- 🔍 **Enfoque**: Operaciones Purple Team, seguridad asistida por IA, MITRE ATT&CK
- 📍 **Ubicación**: Barcelona, España

### Contacto

- LinkedIn: [Tu LinkedIn]
- GitHub: [Tu GitHub]
- Portfolio: [Tu Sitio Portfolio]

---

## 📄 Licencia

Este proyecto es para fines educativos y de portfolio.

**Nota**: Todas las simulaciones de ataque se realizan en entornos de laboratorio aislados. No utilizar contra sistemas que no poseas.

---

## 🙏 Agradecimientos

- [Wazuh](https://wazuh.com/) - Plataforma SIEM open-source
- [MITRE ATT&CK](https://attack.mitre.org/) - Framework de threat intelligence
- [Metasploit](https://www.metasploit.com/) - Framework de pentesting
- Blogs y tutoriales de la comunidad de seguridad

---

## 📊 Estadísticas del Proyecto

- **Fecha de Inicio**: 2026-04-29
- **Fase Actual**: Nivel 2 - Purple Team (70%)
- **Líneas de Código**: ~500+ (scripts)
- **Páginas de Documentación**: 5+ guías técnicas
- **Técnicas MITRE**: 10+ detectadas
- **Tiempo Invertido**: ~15 horas (y contando)

---

**Última Actualización**: 2026-04-29
**Estado**: 🚧 Desarrollo Activo
