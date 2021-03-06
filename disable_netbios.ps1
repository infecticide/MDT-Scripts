Start-Transcript C:\windows\debug\disable_netbios.log
$base_key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces"
$subkeys = Get-ChildItem -Path Registry::$base_key
foreach($subkey in $subkeys) {
    write-host $subkey
    Remove-ItemProperty -Path "Registry::$subkey" -Name "NetbiosOptions"
    New-ItemProperty -Path "Registry::$subkey" -PropertyType DWord -Name "NetbiosOptions" -Value "2"
    if($? -ne $TRUE) {exit 1} ELSE {exit 0}
    }
Stop-Transcript