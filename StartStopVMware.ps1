# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" "
        Start-Process -FilePath PowerShell.exe -Verb Runas -WindowStyle Hidden  -ArgumentList $CommandLine
        Exit
    }
}

Start-Service -Name 'VMAuthdService'
Start-Service -Name 'VMnetDHCP'
Start-Service -Name 'VMware NAT Service'

Start-Sleep(1)

$vmWare = Start-Process "E:\Programas\VMware Workstation Pro\vmware.exe" -Passthru

Wait-Process -Id $vmWare.id

Stop-Service -Name 'VMAuthdService'
Stop-Service -Name 'VMnetDHCP'
Stop-Service -Name 'VMware NAT Service'
