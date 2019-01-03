Vagrant.require_version ">= 1.4.3"
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	numNodes = 1
	r = numNodes..1
	(r.first).downto(r.last).each do |i|
		config.vm.define "gimel-sandbox#{i}" do |node|
			node.vm.box = "geerlingguy/centos7"
			node.vm.provider "virtualbox" do |v|
			  v.name = "gimel-sandbox#{i}"
			  v.customize ["modifyvm", :id, "--memory", "4096"]
			  v.customize ["modifyvm", :id, "--cpus", 2]
			end
      node.vm.synced_folder '.', '/vagrant', type: :virtualbox
			node.vm.network :private_network, ip: "10.10.10.1%02d" % i
			node.vm.hostname = "gimel-sandbox#{i}.example.com"
			node.vm.provision "shell", path: "scripts/setup-centos.sh"
			node.vm.provision "shell" do |s|
				s.path = "scripts/setup-centos-hosts.sh"
				s.args = "-t #{numNodes}"
			end
			if i == 1
				node.vm.provision "shell" do |s|
					s.path = "scripts/setup-centos-ssh.sh"
					s.args = "-s 1 -t #{numNodes}"
				end
			end
			node.vm.provision "shell", path: "scripts/setup-basic-packages.sh"
			node.vm.provision "shell", path: "scripts/setup-docker.sh"
			node.vm.provision "shell", path: "scripts/setup-gimel.sh"
			node.vm.provision "shell", path: "scripts/setup-udc.sh"
		end
	end
end
