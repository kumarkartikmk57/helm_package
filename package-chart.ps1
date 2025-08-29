# PowerShell script to package Helm chart
Write-Host "Checking Chart.yaml file..."
$chartContent = Get-Content -Path "Chart.yaml" -Raw
$chartContent = $chartContent -replace "`r`n", "`n"
$chartContent | Out-File -FilePath "Chart.yaml" -Encoding utf8 -NoNewline
Write-Host "Chart.yaml file fixed."

Write-Host "Packaging Helm chart..."
helm package .
Write-Host "Done!"