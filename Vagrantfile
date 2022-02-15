Vagrant.configure("2") do |config|
  config.vm.box = "aspyatkin/ubuntu-20.04-server"

#   config.vm.network "private_network", type: "dhcp"

  config.vm.provider "virtualbox" do |v|
    v.gui = false
    v.linked_clone = true

    v.check_guest_additions = true
    if Vagrant.has_plugin?("vagrant-vbguest") then
      config.vbguest.auto_update = false
    end

    v.memory = 2048
    v.cpus = 2
  end

  config.vm.define "runner", primary: true do |host|
    host.vm.hostname = "runner"
    host.vm.network "private_network", ip: "192.168.56.10"
    host.vm.provision "shell", path: "./.vagrant-provision/provision.sh"
  end

end
