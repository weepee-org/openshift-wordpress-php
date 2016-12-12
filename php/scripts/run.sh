#!/bin/sh

STAMP=$(date)

if [ ! -f /app/index.php ]; then
  echo "[${STAMP}] Installing wordpress..."
  cp -vfr /wordpress/* /app/
fi

echo "oc:x:`id -u`:0:openshift-wordpress:/:/sbin/nologin" >> /etc/passwd

ulimit -c 0  
echo "[${STAMP}] Starting daemon..."
# run apache httpd daemon
httpd -D FOREGROUND
