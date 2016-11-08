# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    # Definition der Admin Box
    config.vm.define "admbox", primary: true do |admbox|
        admbox.vm.box = "debian/jessie64"
        admbox.vm.hostname = "admin-box"
        admbox.vm.provision "ansible" do |ansible|
            ansible.playbook = "provisioning/admbox.yml"
        end
        admbox.vm.network "private_network", ip: "10.10.10.10", virtualbox__intnet: "ansible_lab"
    end


    # Definition des Webservers
    config.vm.define "web", primary: false do |web|
        web.vm.box = "debian/jessie64"
        web.vm.hostname = "web01"
        web.vm.network "private_network", ip: "10.10.10.100", virtualbox__intnet: "ansible_lab"

        # Weiterleiten von HTTP und HTTPs
        web.vm.network "forwarded_port", guest: 80, host: 8080
        web.vm.network "forwarded_port", guest: 443, host: 1443
    end


  config.vm.box_check_update = false





end
