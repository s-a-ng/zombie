#!/bin/bash

mkdir -p Startup

cat <<'EOF' > Startup/install.bat
@echo off
mkdir C:\data
cd C:\data

powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol=3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"

choco install python -y
call refreshenv

pip install websockets pymem psutil pywin32 aiohttp pyautogui

echo @echo off > "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\run_bot_node.bat"
echo cd /d C:\data >> "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\run_bot_node.bat"
echo powershell -NoProfile -ExecutionPolicy Bypass -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.roblox.com/download/client?os=win','RobloxPlayerInstaller.exe')" >> "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\run_bot_node.bat"
echo start /wait "" "RobloxPlayerInstaller.exe" >> "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\run_bot_node.bat"
echo start "" "python" "C:\bot-pool\Node\Node.py" >> "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\run_bot_node.bat"
echo exit >> "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\run_bot_node.bat"

powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-MpPreference -DisableRealtimeMonitoring $true; Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart; Restart-Computer -Force"
EOF

git clone https://s-a-ng:${PAT}@github.com/s-a-ng/bot-pool.git

docker run --rm \
  --name windows \
  -p 8006:8006 \
  --device=/dev/kvm \
  --device=/dev/net/tun \
  --cap-add NET_ADMIN \
  -v "${PWD:-.}/windows:/storage" \
  -v "${PWD}/bot-pool:/data/bot-pool" \
  --stop-timeout 120 \
  -e VERSION="10l" \
  -e CPU_CORES="3" \
  -e RAM_SIZE="8G" \
  -v ./Startup:/oem \
  dockurr/windows
