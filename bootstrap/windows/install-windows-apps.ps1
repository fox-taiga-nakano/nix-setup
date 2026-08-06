$ErrorActionPreference = "Stop"

$apps = @(
  "Google.Chrome",
  "Figma.Figma",
  "SlackTechnologies.Slack",
  "Raycast.Raycast",
  "AutoHotkey.AutoHotkey",
  "Docker.DockerDesktop",
  "Microsoft.VisualStudioCode",
  "Postman.Postman",
  "Microsoft.PowerToys",
  "Git.Git",
  "Logitech.GHUB",
  "Microsoft.VCRedist.2015+.x64"
)

foreach ($app in $apps) {
  Write-Host "Installing: $app"
  winget install --exact --id $app --source winget `
    --accept-package-agreements `
    --accept-source-agreements
}
