#!/data/data/com.termux/files/usr/bin/bash
set -e
gh auth setup-git
cd ~/ascend
git pull
railway init --name ascend-backend
railway add --database redis
railway add --service ascend-backend
railway variables --service ascend-backend --set 'REDIS_URL=${{Redis.REDIS_URL}}' --set 'PORT=8080'
railway up ascend-backend --path-as-root --service ascend-backend --detach
DOMAIN=$(railway domain --service ascend-backend --port 8080 2>&1 | grep -oE '[a-z0-9.-]+\.up\.railway\.app' | head -1)
echo "{\"url\":\"https://$DOMAIN\"}" > ascend-api-v1.json
git add ascend-api-v1.json
git commit -m "ascend: leaderboard backend url"
git push
vercel --prod --yes
echo
echo "SAVE THIS  ascend-backend URL:  $DOMAIN"
