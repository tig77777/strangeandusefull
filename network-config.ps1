# Getting the list of all network adapters
$adapters = Get-NetAdapter | Where-Object { $_.Status -eq "Up" }
$index = 1

# Displaying the list of adapters
Write-Host "Select a network adapter to configure:"
foreach ($adapter in $adapters) {
    Write-Host "$index. $($adapter.Name)"
    $index++
}

# User selection of an adapter
$userChoice = Read-Host "Enter the number of the adapter"
$selectedAdapter = $adapters[$userChoice - 1].Name

# Requesting new network settings
$newIp = Read-Host "Enter a new IP address (leave blank if you do not want to change)"
$newSubnet = Read-Host "Enter the subnet mask (leave blank if you do not want to change)"
$newGateway = Read-Host "Enter the gateway address (leave blank if you do not want to change)"
$newDns = Read-Host "Enter the DNS address (leave blank if you do not want to change)"

# Applying IP address settings
if ($newIp -and $newSubnet) {
    $ipParams = @{
        InterfaceAlias = $selectedAdapter
        IPAddress = $newIp
        PrefixLength = $newSubnet
    }
    if ($newGateway) {
        $ipParams['DefaultGateway'] = $newGateway
    }
    New-NetIPAddress @ipParams
}

# Applying DNS server settings
if ($newDns) {
    Set-DnsClientServerAddress -InterfaceAlias $selectedAdapter -ServerAddresses $newDns
}

Write-Host "Network settings updated for adapter $selectedAdapter"
