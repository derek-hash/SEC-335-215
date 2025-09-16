param (
	[string]$subnet
)

for ($i = 1; $i -le 254; $i++) {
	$ip = "$subnet.$i"
	try {
		$hostname = [System.Net.Dns]::GetHostEntry($ip).HostName
		Write-Host "$ip't$hostname"
	}
	catch {
		Write-Host "$ip"
	}
}