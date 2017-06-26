cd ..
cd ..

if [ -d workspace/horizon ];then
	rm -rf workspace/horizon
fi

rsync -rvh --safe-links -e 'ssh -p 2208' --exclude='.git' --exclude='.*' root@127.0.0.1:/opt/thinkcloud/horizon workspace/

