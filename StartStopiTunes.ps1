# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" "
        Start-Process -FilePath PowerShell.exe -Verb Runas -WindowStyle Hidden  -ArgumentList $CommandLine
        Exit
    }
}

Start-Service -Name 'Apple Mobile Device Service'
Start-Service -Name 'Bonjour Service'

Start-Sleep(1)

$itunesProcess = Start-Process "E:\Programas\iTunes\iTunes.exe" -Passthru

Wait-Process -Id $itunesProcess.id

Stop-Service -Name 'Apple Mobile Device Service'
Stop-Service -Name 'Bonjour Service'