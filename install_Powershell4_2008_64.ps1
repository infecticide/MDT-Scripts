Start-Transcript c:\windows\debug\install_powershell_v4.log
Copy-Item "\\server\MDT_Deployment\Applications\Powershell 4\Windows Server 2008 x64\Windows6.1-KB2819745-x64-MultiPkg.msu" "$ENV:TEMP"
Set-Location $ENV:TEMP
Start-Process c:\windows\system32\WUSA.exe -ArgumentList "Windows6.1-KB2819745-x64-MultiPkg.msu /quiet /norestart" -Wait
if($? -ne $TRUE) {exit 1} ELSE {exit 0}
Stop-Transcript