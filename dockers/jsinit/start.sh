#!/bin/bash

cd /workspace
LOCALDIR=local-dir


if [[ ! -d "$LOCALDIR" ]];then
    git clone $UPSTREAM $LOCALDIR
else
    echo "dir already exist"
fi

if [[ "$NEED_INIT"X = "T"X ]];then
    echo "begin install node packages"
    cd $LOCALDIR&&cnpm install
fi

/usr/bin/supervisord -c /etc/supervisord.conf

