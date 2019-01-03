#!/usr/bin/env bash

source "/vagrant/scripts/common.sh"

function cloneRepoGimel {
  echo "Clone gimel from Github."
  git clone ${GIMEL_REPO} /usr/local/gimel-${GIMEL_VERSION}
  cd /usr/local/gimel-${GIMEL_VERSION} && git reset --hard ${GIMEL_COMMIT}
  ln -s /usr/local/gimel-${GIMEL_VERSION} /usr/local/gimel
}

function installLocalGimel {
	echo "install gimel from local file"
	FILE="/vagrant/resources/${GIMEL_ARCHIVE}"
  SQL_LIB="/vagrant/resources/${GIMEL_SQL_LIB}"
  tar -xzf $FILE -C /usr/local
  ln -s /usr/local/gimel-${GIMEL_VERSION} /usr/local/gimel
  mkdir ${GIMEL_HOME}/gimel-dataapi/gimel-standalone/lib
  cp -f ${SQL_LIB} ${GIMEL_HOME}/gimel-dataapi/gimel-standalone/lib/${GIMEL_SQL_LIB}
}

function installRemoteGimel {
	echo "install gimel from remote file"
  # Download from google drive. see this: https://github.com/paypal/gimel/blob/master/docs/try-gimel/0-prerequisite.md#download-the-gimel-jar
  fileid="1mVia6-dTyX9ZU2-r91TFJu4_hEhapVRA"
  query=`curl -c /tmp/cookie.txt -s -L "https://drive.google.com/uc?export=download&id=${fileid}" | pup 'a#uc-download-link attr{href}' | sed -e 's/amp;//g'`
  curl -b /tmp/cookie.txt -L -o /vagrant/resources/${GIMEL_SQL_LIB} "https://drive.google.com${query}"
  mkdir ${GIMEL_HOME}/gimel-dataapi/gimel-standalone/lib
  cp /vagrant/resources/${GIMEL_SQL_LIB} ${GIMEL_HOME}/gimel-dataapi/gimel-standalone/lib/${GIMEL_SQL_LIB}
}

function installGimel {
	if resourceExists ${GIMEL_ARCHIVE}; then
		installLocalGimel
	else
    cloneRepoGimel
		installRemoteGimel
	fi
  chown -R vagrant:vagrant /usr/local/gimel-${GIMEL_VERSION}
}

function setupGimel {
	echo "install Gimel service"

}

function setupEnvVars {
  echo "creating gimel environment variables"
  cp -f ${GIMEL_RES_DIR}/gimel.sh /etc/profile.d/gimel.sh
	cp -f ${GIMEL_RES_DIR}/hadoop-hive.env ${GIMEL_HOME}/gimel-dataapi/gimel-standalone/docker/hadoop-hive.env
  cp -f ${GIMEL_RES_DIR}/hbase-distributed-local.env ${GIMEL_HOME}/gimel-dataapi/gimel-standalone/docker/hbase-distributed-local.env
}

function fixBugs {
  echo "fix start script bug."
  cp ${GIMEL_HOME}/gimel-dataapi/gimel-quickstart/FLIGHTS.zip ${GIMEL_HOME}/gimel-dataapi/gimel-quickstart/flights.zip
}

function pullDockerImages {
  echo "Pull images."
  cd ${GIMEL_HOME}/gimel-dataapi/gimel-standalone/docker && docker-compose pull
}

echo "setup gimel"
installGimel
setupGimel
setupEnvVars
pullDockerImages
fixBugs
