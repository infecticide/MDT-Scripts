Start-Transcript -Path "C:\Windows\Debug\disable_windows_firewall.log"
Start-Process netsh -ArgumentList "advfirewall set allprofiles state off" -Wait | Out-Default
if($? -ne $TRUE) {exit 1} ELSE {exit 0}
Stop-Transcript