Start-Transcript c:\windows\debug\install_powershell_v4.log
Copy-Item "\\server\MDT_Deployment\Applications\Powershell 4\Windows Server 2012 x64\Windows8-RT-KB2799888-x64.msu" "$ENV:TEMP"
Set-Location $ENV:TEMP
Start-Process c:\windows\system32\WUSA.exe -ArgumentList "Windows8-RT-KB2799888-x64.msu /quiet /norestart" -Wait
if($? -ne $TRUE) {exit 1} ELSE {exit 0}
Stop-Transcript