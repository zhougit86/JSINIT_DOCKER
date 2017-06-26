cd ..
cd ..

docker-compose stop horizon
docker-compose rm -f horizon

docker-compose up horizon
docker-compose up -d horizon

timeout /t 5 /nobreak > nul

if exist "workspace/horizon" del /q "workspace/horizon"
rsync -rvh --safe-links -e 'ssh -p 2201' --exclude='.git' --exclude='.*' root@127.0.0.1:/opt/thinkcloud/horizon workspace/

pause