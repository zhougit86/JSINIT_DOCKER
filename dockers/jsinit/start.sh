#!/bin/bash

cd /workspace
LOCALDIR=local-dir


if [[ ! -d "$LOCALDIR" ]];then
    git clone $UPSTREAM $LOCALDIR
else
    echo "dir already exist"
fi

if [[ "$NEED_INIT"X = "T"X ]];then
    cd $LOCALDIR&&cnpm install
fi
#top
#while true;
#sleep 1000;
#done

#tailf ~/loop
/usr/bin/supervisord -c /etc/supervisord.conf

