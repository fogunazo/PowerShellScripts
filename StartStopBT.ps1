# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" "
        Start-Process -FilePath PowerShell.exe -Verb Runas -WindowStyle Hidden  -ArgumentList $CommandLine
        Exit
    }
}

Start-Service bthserv
Start-Service BTAGService

Start-Sleep 60
$deviceName = "HD 4.40BT Stereo"
$device = Get-PnpDevice -PresentOnly -FriendlyName $deviceName

Start-Sleep 1
Stop-Service bthserv
Stop-Service BTAGService