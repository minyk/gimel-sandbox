Sandbox for Paypal gimel
================================

# Introduction

Vagrant project to spin up a cluster of 1 virtual machine with Paypal gimel. Set up by gimel quickstart document:  https://github.com/paypal/gimel/blob/master/docs/try-gimel/0-prerequisite.md

* [gimel doc](https://gimel.readthedocs.io/en/master/)
* [gimel-src](https://github.com/paypal/gimel)

# Getting Started

1. [Download and install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Download and install Vagrant](http://www.vagrantup.com/downloads.html).
3. Run ```vagrant box add geerlingguy/centos7```
4. Git clone this project, and change directory (cd) into this project (directory).
5. Run ```vagrant up``` to create the VM.
6. Run ```vagrant ssh``` to get into your VM.
7. Run ```vagrant destroy``` when you want to destroy and get rid of the VM.

### Start gimel

1. Run ```./start-gimel.sh``` from `/usr/local/gimel/quickstart`.

See this: https://github.com/paypal/gimel/blob/master/docs/try-gimel/0-prerequisite.md#run-gimel-quickstart-script

### Start UDC

1. Run ```docker-compose up -d mysql-standalone``` from `/usr/local/udc`.
2. Wait a minute for database bootstrapping.
3. Run ```docker-compose up -d``` from `/usr/local/udc`.

See this: https://github.com/paypal/gimel/blob/master/udc/README.md

### Some gotcha's.

1. Make sure you download Vagrant v1.9.0 or higher.
2. Make sure when you clone this project, you preserve the Unix/OSX end-of-line (EOL) characters. The scripts will fail with Windows EOL characters.
3. Make sure you have 4Gb of free memory for the VM at least. You may change the Vagrantfile to specify smaller memory requirements.
4. This project has NOT been tested with the VMWare provider for Vagrant.
5. If your machine is not fast enough, the HDFS Namenode is not ready during bootstrap sequence. In this case, edit `gimel-dataapi/gimel-quickstart/bootstrap.sh`, insert `run_cmd "sleep 120s"` at 63 line.

# Advanced Stuff

-If you have the resources (CPU + Disk Space + Memory), you may modify Vagrantfile to have even more HDFS DataNodes, YARN NodeManagers. Just find the line that says "numNodes = 4" in Vagrantfile and increase that number. The scripts should dynamically provision the additional slaves for you.-

# How to Change Stack Versions

Edit variables in `scripts/common.sh`.

## OS

`gimel-sandbox` uses CentOS 7 for default. It can be changed to other version/distribution. Just edit the `Vagrantfile`'s following lines:

```
    node.vm.box = "geerlingguy/centos7"
```

Make sure the OS box has virtualbox guest addition.

## docker


## gimel

Gimel version is described in `scripts/common.sh`.


# Make the VMs setup faster
You can make the VM setup even faster if you pre-download the `gimel-sql-uber.jar` into the `/resources` directory.

1. `/resources/gimel-sql-1.2.0-SNAPSHOT-uber.jar`

The setup script will automatically detect if these files (with precisely the same names) exist and use them instead. If you are using slightly different versions, you will have to modify the script accordingly.

# Web UI
You can check the following URLs to monitor the Hadoop daemons.

1. [Spark Master UI] (http://10.10.10.101:8080)
2. [Spark Driver UI] (http://10.10.10.101:4040) (after launching the spark shell)

UDC UI is also provided.

1. [UDC UI] (http://10.10.10.101:8800)
2. [UDC REST API] (http://10.10.10.101:8801/swagger-ui.html)

# Storage Endpoint

* Elasticsearch http://10.10.10.101:9200
* Kafka `10.10.10.101:9092`
* HBase Master http://10.10.10.101:16010
* HDFS Namenode IPC `10.10.10.101:8020`
* Hive Metastore `10.10.10.101:9083`

# Vagrant box location
The Vagrant box is downloaded to the `~/.vagrant.d/boxes` directory. On Windows, this is `C:/Users/{your-username}/.vagrant.d/boxes`.

# Acknowledgements

This project is started from Jee Vang's [vagrant-hadoop-2.4.1-spark-1.0.1](https://github.com/vangj/vagrant-hadoop-2.4.1-spark-1.0.1). Thanks a lot.

# License
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
