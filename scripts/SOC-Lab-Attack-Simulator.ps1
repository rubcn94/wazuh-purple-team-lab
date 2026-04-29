# SOC Lab - Attack Simulation Suite
# Purpose: Generate MITRE ATT&CK technique simulations for Wazuh detection
# Author: Ruben - SOC Lab Project
# Date: 2026-04-29

param(
    [ValidateSet("All", "BruteForce", "PowerShell", "PrivEsc")]
    [string]$AttackType = "All"
)

function Show-Banner {
    Write-Host ""
    Write-Host "=============================================================" -ForegroundColor Cyan
    Write-Host "    SOC Lab - Attack Simulation Suite" -ForegroundColor Cyan
    Write-Host "    Simulating MITRE ATT&CK Techniques" -ForegroundColor Cyan
    Write-Host "=============================================================" -ForegroundColor Cyan
    Write-Host ""
}

function Invoke-BruteForceSimulation {
    Write-Host "[ATTACK 1/3] Brute Force Attack Simulation" -ForegroundColor Yellow
    Write-Host "MITRE Technique: T1110 - Brute Force" -ForegroundColor Gray
    Write-Host "Expected Detection: Wazuh Rule 100002" -ForegroundColor Gray
    Write-Host ""

    Write-Host "  [+] Creating test user..." -ForegroundColor White
    net user testuser Passw0rd123! /add 2>$null | Out-Null

    Write-Host "  [+] Generating 10 failed login attempts..." -ForegroundColor White
    1..10 | ForEach-Object {
        $pw = ConvertTo-SecureString "WrongPassword$_" -AsPlainText -Force
        $cred = New-Object System.Management.Automation.PSCredential ("testuser", $pw)
        Start-Process cmd.exe -Credential $cred -ErrorAction SilentlyContinue 2>$null
        Write-Host "      Attempt $_ failed" -ForegroundColor DarkGray
        Start-Sleep -Milliseconds 500
    }

    Write-Host ""
    Write-Host "  [OK] Brute Force simulation completed!" -ForegroundColor Green
    Write-Host "       Check Wazuh for Rule ID: 100002" -ForegroundColor Cyan
    Write-Host ""
}

function Invoke-PowerShellSuspiciousActivity {
    Write-Host "[ATTACK 2/3] PowerShell Suspicious Activity" -ForegroundColor Yellow
    Write-Host "MITRE Technique: T1059.001 - PowerShell Execution" -ForegroundColor Gray
    Write-Host "Expected Detection: Wazuh Rule 100003" -ForegroundColor Gray
    Write-Host ""

    Write-Host "  [+] Test 1: Bypass ExecutionPolicy..." -ForegroundColor White
    powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Write-Host '  Command executed with bypass'" 2>$null
    Write-Host "      Completed" -ForegroundColor Green
    Start-Sleep -Seconds 1

    Write-Host ""
    Write-Host "  [+] Test 2: Encoded Command (obfuscation)..." -ForegroundColor White
    $cmd = "Write-Host '  Encoded command executed'"
    $bytes = [System.Text.Encoding]::Unicode.GetBytes($cmd)
    $encoded = [Convert]::ToBase64String($bytes)
    powershell.exe -EncodedCommand $encoded 2>$null
    Write-Host "      Completed" -ForegroundColor Green
    Start-Sleep -Seconds 1

    Write-Host ""
    Write-Host "  [+] Test 3: Invoke-Expression (IEX)..." -ForegroundColor White
    Invoke-Expression "Write-Host '  IEX command executed'" 2>$null
    Write-Host "      Completed" -ForegroundColor Green

    Write-Host ""
    Write-Host "  [OK] PowerShell suspicious activity completed!" -ForegroundColor Green
    Write-Host "       Check Wazuh for Rule ID: 100003" -ForegroundColor Cyan
    Write-Host ""
}

function Invoke-PrivilegeEscalationSimulation {
    Write-Host "[ATTACK 3/3] Privilege Escalation Attempt" -ForegroundColor Yellow
    Write-Host "MITRE Technique: T1068 - Privilege Escalation" -ForegroundColor Gray
    Write-Host "Expected Detection: Wazuh Rule 100004" -ForegroundColor Gray
    Write-Host ""

    Write-Host "  [+] Test 1: RunAs command (will fail - expected)..." -ForegroundColor White
    runas /user:Administrator "cmd.exe /c echo Privilege escalation test" 2>$null
    Write-Host "      Attempt logged" -ForegroundColor Green
    Start-Sleep -Seconds 1

    Write-Host ""
    Write-Host "  [+] Test 2: Process elevation attempt..." -ForegroundColor White
    Start-Process powershell.exe -Verb RunAs -ArgumentList "Write-Host 'Elevation test'" -ErrorAction SilentlyContinue 2>$null
    Write-Host "      Attempt logged" -ForegroundColor Green

    Write-Host ""
    Write-Host "  [OK] Privilege escalation simulation completed!" -ForegroundColor Green
    Write-Host "       Check Wazuh for Rule ID: 100004" -ForegroundColor Cyan
    Write-Host ""
}

function Invoke-Cleanup {
    Write-Host "[CLEANUP] Removing test artifacts..." -ForegroundColor Magenta
    net user testuser /delete 2>$null | Out-Null
    Write-Host "  Test user removed" -ForegroundColor Green
    Write-Host ""
}

# MAIN EXECUTION
Show-Banner
Start-Sleep -Seconds 2

switch ($AttackType) {
    "BruteForce" {
        Invoke-BruteForceSimulation
        Invoke-Cleanup
    }
    "PowerShell" {
        Invoke-PowerShellSuspiciousActivity
    }
    "PrivEsc" {
        Invoke-PrivilegeEscalationSimulation
    }
    "All" {
        Invoke-BruteForceSimulation
        Start-Sleep -Seconds 2
        Invoke-PowerShellSuspiciousActivity
        Start-Sleep -Seconds 2
        Invoke-PrivilegeEscalationSimulation
        Invoke-Cleanup
    }
}

# FINAL SUMMARY
Write-Host "=============================================================" -ForegroundColor Cyan
Write-Host "  All simulations completed successfully!" -ForegroundColor Cyan
Write-Host "=============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "  1. Open Wazuh Dashboard: https://<WAZUH_IP>" -ForegroundColor White
Write-Host "  2. Go to: Threat Hunting -> Events" -ForegroundColor White
Write-Host "  3. Search: rule.id:(100002 OR 100003 OR 100004)" -ForegroundColor White
Write-Host ""
Write-Host "Expected Alerts:" -ForegroundColor Yellow
Write-Host "  - Multiple failed login attempts (Brute Force)" -ForegroundColor White
Write-Host "  - Suspicious PowerShell commands" -ForegroundColor White
Write-Host "  - Privilege escalation attempts" -ForegroundColor White
Write-Host ""
Write-Host "Script completed at: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Gray
Write-Host ""
Write-Host "For portfolio documentation, take screenshots of Wazuh alerts!" -ForegroundColor Yellow
Write-Host ""
