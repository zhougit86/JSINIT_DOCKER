cd ..
cd ..

rsync -rvh --safe-links -e 'ssh -p 2208' --exclude='.git' --exclude='.*' --del workspace/horizon root@127.0.0.1:/opt/thinkcloud/

