# Enable PowerShell Logging for Wazuh Detection
# Author: Ruben - SOC Lab Project
# Date: 2026-04-29
# Purpose: Enable comprehensive PowerShell logging for security monitoring

# Requires Administrator privileges

Write-Host "Enabling PowerShell Logging for Wazuh..." -ForegroundColor Cyan

# Enable Module Logging
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging" -Name "EnableModuleLogging" -Value 1

New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging\ModuleNames" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging\ModuleNames" -Name "*" -Value "*" -PropertyType String -Force | Out-Null

Write-Host "[OK] Module Logging enabled" -ForegroundColor Green

# Enable Script Block Logging
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Name "EnableScriptBlockLogging" -Value 1

Write-Host "[OK] Script Block Logging enabled" -ForegroundColor Green

# Enable Transcription (optional - creates local logs)
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription" -Name "EnableTranscripting" -Value 1
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription" -Name "OutputDirectory" -Value "C:\PSTranscripts"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription" -Name "EnableInvocationHeader" -Value 1

Write-Host "[OK] Transcription enabled (logs to C:\PSTranscripts)" -ForegroundColor Green

Write-Host ""
Write-Host "PowerShell logging fully enabled!" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Restart PowerShell for changes to take effect"
Write-Host "  2. Restart Wazuh agent: Restart-Service -Name WazuhSvc"
Write-Host "  3. Test with: .\SOC-Lab-Attack-Simulator.ps1 -AttackType PowerShell"
Write-Host ""
