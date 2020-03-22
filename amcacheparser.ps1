$linkPath="$($ENV:SystemDrive)\ShadowCopy"

$class=[WMICLASS]"root\cimv2:win32_shadowcopy"
$result = $class.create("C:\", "ClientAccessible")

$ShadowCopy = (Get-CimInstance Win32_ShadowCopy | Where-Object ID -eq $result.ShadowID ).DeviceObject
$ShadowCopy = $ShadowCopy + "\"

$cmd = "cmd /c mklink /d '" + $linkPath + "' '" + $ShadowCopy + "'"

Invoke-Expression -Command $cmd;

Invoke-Expression -Command "cmd /c rmdir /S /Q '$linkPath'"

reg load "HKLM\amcache" "C:\ShadowCopy\Windows\appcompat\Programs\Amcache.hve"

Get-ChildItem -path "HKLM:\amcache\root\InventoryApplicationFile" | select -First 1

reg unload "HKLM\amcache"