Start-Transcript -Path "C:\Windows\Debug\set_swap_size.log"
# Determine memory installed
$ram = Get-WmiObject Win32_OperatingSystem | select TotalVisibleMemorySize
$ram = ($ram.TotalVisibleMemorySize / 1kb).tostring("F00")
[int]$ram = $ram
# Determine swap size
if($ram -lt 8192) { $mem = $ram * 1.5 } ELSE { $mem = $ram + 300 }
# Set swap size$base_key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory management"
$property = "PagingFiles"
$property_type = "String"
$property_value  = "C:\pagefile.sys $mem $mem"

# Does key exist?  If not, create it.
if(test-path Registry::$base_key) {
    # Key exists, check for property
    write-host "Key: $base_key exists"
    $prop_exist = Get-Item -Path Registry::$base_key | select Property
    if($prop_exist.Property -contains $property) {
        # Property exists, check value
        write-host "Property: $property exists"
        $current_value = Get-ItemProperty -path Registry::$base_key -Name $property
        $current_value = $current_value.$property
        if($current_value -eq $property_value) {
            # Value is correct
            write-host "Value: $current_value is correct"
            Stop-Transcript
            exit 0
            } ELSE {
            # Value is wrong
            write-host "Value is wrong, correcting..."
            Remove-ItemProperty -Path Registry::$base_key -Name $property
            New-ItemProperty -Path Registry::$base_key -Name $property -PropertyType $property_type -Value $property_value
            if($? -ne $TRUE) {exit 1} ELSE {exit 0}
            }
        } ELSE {
        # Property does not exist
        write-host "Property does not exist, creating..."
        New-ItemProperty -Path Registry::$base_key -Name $property -PropertyType $property_type -Value $property_value
        if($? -ne $TRUE) {exit 1} ELSE {exit 0}
        }
    } ELSE {
    # Key does not exist, create key and property
    write-host "Key does not exist, creating key and property"
    New-Item -Path Registry::$base_key
    New-ItemProperty -Path Registry::$base_key -Name $property -PropertyType $property_type -Value $property_value
    if($? -ne $TRUE) {exit 1} ELSE {exit 0}
    }