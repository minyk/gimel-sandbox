#!/usr/bin/env bash

source "/vagrant/scripts/common.sh"

echo "setup udc"
mkdir -p /usr/local/${UDC_NAME}
ln -sf /usr/local/${UDC_NAME} ${UDC_HOME}

cp -rf ${UDC_RES_DIR}/* ${UDC_HOME}

echo "Pull images."
cd ${UDC_HOME} && docker-compose pull
