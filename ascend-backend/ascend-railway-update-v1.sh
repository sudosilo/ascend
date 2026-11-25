#!/data/data/com.termux/files/usr/bin/bash
set -e
cd ~/ascend
git pull
if [ -f ascend-api-v1.json ] && railway status >/dev/null 2>&1; then
  railway up ascend-backend --path-as-root --service ascend-backend --detach
  echo
  echo "ascend-backend redeployed"
else
  bash ascend-backend/ascend-railway-v1.sh
fi
