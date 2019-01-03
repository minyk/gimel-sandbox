#!/bin/bash

#java
JAVA_VERSION="8"
JAVA_UPDATE="151"
JAVA_ARCHIVE=jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz
JAVA_HOME="jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}"

#ssh
SSH_RES_DIR=/vagrant/resources/ssh
RES_SSH_COPYID_ORIGINAL=$SSH_RES_DIR/ssh-copy-id.original
RES_SSH_COPYID_MODIFIED=$SSH_RES_DIR/ssh-copy-id.modified
RES_SSH_CONFIG=$SSH_RES_DIR/config

#gimel
GIMEL_VERSION="1.2.0-SNAPSHOT"
GIMEL_COMMIT="19f4e6f4f3e24fb8d90120161c2ed2f008fbfa58"
GIMEL_REPO="https://github.com/paypal/gimel.git"
GIMEL_SQL_LIB="gimel-sql-${GIMEL_VERSION}-uber.jar"
GIMEL_ARCHIVE="gimel-src-${GIMEL_VERSION}.tar.gz"
GIMEL_MIRROR_DOWNLOAD="https://github.com/paypal/gimel/release/"
GIMEL_HOME="/usr/local/gimel"
GIMEL_RES_DIR="/vagrant/resources/gimel"

#udc
UDC_VERSION="0.0.1"
UDC_NAME="udc-${UDC_VERSION}"
UDC_HOME="/usr/local/udc"
UDC_RES_DIR="/vagrant/resources/udc"

#Nifi
NIFI_VERSION=1.8.0
NIFI_NAME=nifi-${NIFI_VERSION}
NIFI_ARCHIVE=${NIFI_NAME}-bin.tar.gz
NIFI_MIRROR_DOWNLOAD=http://www.apache.org/dist/nifi/${NIFI_VERSION}/${NIFI_ARCHIVE}
NIFI_RES_DIR=/vagrant/resources/nifi
NIFI_HOME=/usr/local/nifi
NIFI_CONF=$NIFI_HOME/conf

function resourceExists {
	FILE=/vagrant/resources/$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}

function fileExists {
	FILE=$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}

#echo "common loaded"
