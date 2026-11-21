# Stream Juice Shop container logs for copy/paste into challenge notes.
$ErrorActionPreference = "Stop"
$name = (docker compose ps -q juice-shop 2>$null)
if (-not $name) {
    Write-Host "Start the lab first: docker compose up -d"
    exit 1
}
docker logs -f $(docker compose ps -q juice-shop)