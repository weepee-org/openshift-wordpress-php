#!/bin/sh

STAMP=$(date)

if [ ! -f /app/index.php ]; then
  echo "[${STAMP}] Installing wordpress..."
  cp -vfpr /wordpress/* /app/
fi

echo "[${STAMP}] Starting daemon..."
# run apache httpd daemon
httpd -D FOREGROUND
