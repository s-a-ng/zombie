#!/bin/bash

mkdir -p Startup

cat <<EOF > Startup/install.bat
@echo off
mkdir data
cd data
git clone https://s-a-ng:${PAT}@github.com/s-a-ng/bot-pool.git
pip install websockets pymem psutil pywin32 aiohttp pyautogui
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.roblox.com/download/client?os=win', 'RobloxPlayerInstaller.exe')"
start /wait "" "RobloxPlayerInstaller.exe"

echo @echo off > "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\run_bot_node.bat"
echo start "" "python" "C:\data\bot-pool\Node\Node.py" >> "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\run_bot_node.bat"
echo exit >> "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\run_bot_node.bat"

powershell -Command "Set-MpPreference -DisableRealtimeMonitoring \$true; Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart; Restart-Computer -Force"
EOF

docker run -it --rm --name windows -p 8006:8006 --device=/dev/kvm --device=/dev/net/tun --cap-add NET_ADMIN -v "${PWD:-.}/windows:/storage" --stop-timeout 120 -e VERSION=10l -v ./Startup:/oem dockurr/windows
