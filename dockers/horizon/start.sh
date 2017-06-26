#!/bin/bash

HORIZON_HOME=$REPO_HOME/horizon
ADMINUI_HOME=$REPO_HOME/admin-ui
ADMINUI_REMOTE_WS=/workspace/admin-ui

UPPER_CONSTRAINTS_FILE="https://git.openstack.org/cgit/openstack/requirements/plain/upper-constraints.txt?h=stable/mitaka"
CEPHCLIENT_REPO_URL="ssh://git@10.240.205.131/thinkcloud-sds/StorMgmtClientM.git"

LOCAL_SETTINGS=$HORIZON_HOME/thinkcloud_portal/local/local_settings.py

cd $REPO_HOME

if [[ ! -d "$ADMINUI_REMOTE_WS" ]]; then
	git clone $ADMINUI_REPO $ADMINUI_REMOTE_WS

	(cd $ADMINUI_HOME/frontend; cnpm install; cnpm run build-prod)
else
	echo "SDS Admin UI project already exists!"
	echo ""
fi

ln -sf $ADMINUI_REMOTE_WS $ADMINUI_HOME

if [[ ! -d "$HORIZON_HOME" ]]; then
	git clone $HORIZON_REPO $HORIZON_HOME
	ln -sf $ADMINUI_HOME/frontend/dist $HORIZON_HOME/thinkcloud_portal/static/portal

	# Generate virtual environment
	(cd $HORIZON_HOME; ./run_tests.sh -m help)
	(cd $HORIZON_HOME; source .venv/bin/activate; \
		pip install -c $UPPER_CONSTRAINTS_FILE git+$CEPHCLIENT_REPO_URL)
	
	#python $HORIZON_HOME/manage.py collectstatic --noinput --clear

	echo "Exiting for initialization ..."
	exit 0
else
	echo "Horizon project already exists!"
	echo ""
fi

if [ -f "$LOCAL_SETTINGS" ]; then
	sed -i -e 's/^OPENSTACK_HOST =.*/OPENSTACK_HOST = "'$OPENSTACK_HOST'"/' $LOCAL_SETTINGS
	echo "==== Development Environment Information ===="
	echo ""
	echo " - OPENSTACK_HOST = ${OPENSTACK_HOST}"
	echo ""
	#python $HORIZON_HOME/manage.py collectstatic --noinput
	#python $HORIZON_HOME/manage.py compress
fi

cd /root
/usr/bin/supervisord -c /etc/supervisord.conf
