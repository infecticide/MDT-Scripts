Start-Transcript -Path c:\windows\debug\install_vmware_tools.log
Start-Process -Wait "\\server\MDT_Deployment\Applications\VMWare Tools\setup.exe" -ArgumentList '/S /v "/qn /l*v ""C:\Windows\Debug\VMWare_Tools.log"" REBOOT=R ADDLOCAL=ALL'
if($? -ne $TRUE) {exit 1} ELSE {exit 0}
Stop-Transcript