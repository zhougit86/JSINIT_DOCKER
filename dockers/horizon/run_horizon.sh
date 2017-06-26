#!/bin/sh

HORIZON_HOME=/opt/thinkcloud/horizon

. $HORIZON_HOME/.venv/bin/activate

python $HORIZON_HOME/manage.py runserver 0.0.0.0:8000
