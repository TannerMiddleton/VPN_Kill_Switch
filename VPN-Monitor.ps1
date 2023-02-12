# Name of the program to monitor
$Program = "nordvpn.exe"

# Path to the batch file to run
$BatchFile = "Batch file to kill any applications you want."
$applicationStopped = $true


# Check if the program is running
while ($true) {
  $Interface = Get-NetAdapter | Where-Object { $_.status -eq 'Up' -and $_.Virtual -eq $True }

  if ($Interface -and $applicationStopped) {
      Write-Output "You are currently connected to a VPN."
      $applicationStopped = $false
  }
   
  if (!$Interface -and !$applicationStopped) {
      Write-Output "You are not connected to a VPN."

      Start-Process $BatchFile -Wait
      $applicationStopped = $true
  }

  # Wait for 5 seconds before checking again
  Start-Sleep -Seconds 5
}
