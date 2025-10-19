#!/bin/bash

cd ~/path/to/tweak || { echo "oh noo it failed to change dirs"; exit 1; }

if ! command -v mitmweb &> /dev/null; then
    echo "oh fuk not found... Install - brew install mitmproxy"
    exit 1
fi

if [ ! -f "manabox_crack.py" ]; then
    echo "big L Place manabox_crack.py here and rerun."
    exit 1
fi

echo "running already??"
pids=$(pgrep mitmweb)
if [ -n "$pids" ]; then
    echo "kill.. $pids"
    kill -9 $pids 2>/dev/null || true
    sleep 1
fi

if lsof -i :8082 | grep LISTEN > /dev/null; then
    echo "port 8082 in use. kill processes..."
    kill -9 $(lsof -i :8082 -t) 2>/dev/null || true
    sleep 1
fi

if lsof -i :8083 | grep LISTEN > /dev/null; then
    echo "port 8083 in use. kill processes..."
    kill -9 $(lsof -i :8083 -t) 2>/dev/null || true
    sleep 1
fi

echo "Starting.."
mitmweb -s ~/Documents/ManaBox/manabox_crack.py --listen-port 8082 --set ssl_insecure=true --set upstream_cert=false --set http2=true --set web_port=8083 &
MITM_PID=$!
sleep 5

if ps -p $MITM_PID > /dev/null; then
    echo "started pid - $MITM_PID"
    echo "manabox_crack.py loaded—api.revenuecat.com/v1/subscribers will be cr4cked."
else
    echo "failed.."
    exit 1
fi

echo "setup complete. launch manabox on ios"
echo "Ctrl+C to kill processes"
wait $MITM_PID
pkill -f mitmweb 2>/dev/null || true
echo "cleanup complete."
