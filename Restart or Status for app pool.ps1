# Load IIS module:
Import-Module WebAdministration

$AppPool = "test"
$Action = "restart"
$Date = Get-Date
#check state of app pool


$AppPoolState = Get-WebAppPoolState -Name $AppPool
if ($Action -eq "status") {

    if ((Get-WebAppPoolState($AppPool)).Value -eq "Started") {

                Write-Host "Check 1: At $Date, AppPool: $AppPool is already running"
            }

    elseif ((Get-WebAppPoolState($AppPool)).Value -eq "Stopped") {
        
                Write-Host "Check 1: At $Date, AppPool: $AppPool is not running"
            }
}
elseif ($Action = "restart") {
    Write-Host "Restarting $AppPool"

    if ((Get-WebAppPoolState($AppPool)).Value -eq "Started") {
        
                Write-Host "Check 1: At $Date, AppPool: $AppPool is running" 

                Stop-WebAppPool -Name $AppPool
                Start-Sleep -s 10;  Start-WebAppPool -Name $AppPool

                if ((Get-WebAppPoolState($AppPool)).Value -eq "Started") {

                    Write-Host "Check 2: At $Date, AppPool: $AppPool has been restarted and is currently running"

                }
                else {
                    Write-Host "Check 2: At $Date, AppPool: $AppPool is not running"
                }
            }

    elseif ((Get-WebAppPoolState($AppPool)).Value -eq "Stopped") {

                Write-Host "Check 1: At $Date, AppPool: $AppPool is stopped"

                Start-Sleep -s 10;  Start-WebAppPool -Name $AppPool
        
                if ((Get-WebAppPoolState($AppPool)).Value -eq "Started") {

                    Write-Host "Check 2: At $Date, AppPool: $AppPool has been restarted and is currently running"

                }
                else {
                    Write-Host "Check 2: At $Date, AppPool: $AppPool is not running"
                }
            }
    
}
