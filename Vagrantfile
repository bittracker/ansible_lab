# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# HINWEIS: jede weitere Box muss im host.txt File im provisioning Ordner
# mit der IP-Adresse und dem Hostnamen eingetragen werden.
#
# Template für eine Neue Box:
# config.vm.define "<boxname>" do |<boxname>|
#    bc.vm.box = "debian/jessie64"
#    bc.vm.hostname = "<boxname>"
#    bc.vm.network "private_network", ip: "<ipv4_addresse>", virtualbox__intnet: true
#    bc.vm.provision :shell, path: "provisioning/myprovisioner.sh"
#  end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.insert_key = false
  config.vm.synced_folder "C:/GatewayUno/share", "/home/vagrant/share/"
  config.vm.define "admbox", primary: true do |admbox|
    admbox.vm.box = "debian/jessie64"
    admbox.vm.hostname = "admbox"
    admbox.vm.network "private_network", ip: "10.10.10.10", virtualbox__intnet: true
    admbox.vm.provision :shell, path: "provisioning/myprovisioner.sh"
  end

  config.vm.define "bc" do |bc|
    bc.vm.box = "debian/jessie64"
    bc.vm.hostname = "bc-server"
    bc.vm.network "private_network", ip: "10.10.10.100", virtualbox__intnet: true
    bc.vm.provision :shell, path: "provisioning/myprovisioner.sh"
  end
  config.vm.define "client" do |client|
    client.vm.box = "debian/jessie64"
    client.vm.hostname = "client"
    client.vm.network "private_network", ip: "10.10.10.200", virtualbox__intnet: true
    client.vm.provision :shell, path: "provisioning/myprovisioner.sh"
  end

end
