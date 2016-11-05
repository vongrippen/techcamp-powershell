# Initialise machine name
$hostname = "localhost"
 
# Get fixed drive info
$disks = Get-WmiObject -ComputerName $hostname -Class Win32_LogicalDisk -Filter "DriveType = 3";
 
foreach($disk in $disks)
{
    $deviceID = $disk.DeviceID;
    [float]$size = $disk.Size;
    [float]$freespace = $disk.FreeSpace;
 
	$percentFree = [Math]::Round(($freespace / $size) * 100, 2);
	$sizeGB = [Math]::Round($size / 1073741824, 2);
	$freeSpaceGB = [Math]::Round($freespace / 1073741824, 2);

    $props = @{
        Hostname = $hostname
        DeviceID = $deviceID
        SizeGB = $sizeGB
        FreeSpaceGB = $freeSpaceGB
        PercentFree = $percentFree
    }

    $row = New-Object PSObject -Property $props
    $row
}