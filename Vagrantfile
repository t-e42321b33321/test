Vagrant.configure("2") do |config|

  vm_hash = {
    "proxy" => {
      :ip => "192.168.56.100",
      :receipe => "nginx"
    },
    "app1" => {
      :ip => "192.168.56.101",
      :receipe => "app",
    },
    "app2" => {
      :ip => "192.168.56.102",
      :receipe => "app",
    }
  }

  vm_hash.each do |key,value|

    config.vm.define key do |node|
      node.vm.box = "ubuntu/trusty64"
      node.vm.hostname = key
      node.vm.box_url = "ubuntu/trusty64"

      node.vm.network :private_network, ip: value[:ip]

      node.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--memory", 512]
        v.customize ["modifyvm", :id, "--name", node]
      end
      node.vm.provision "chef_solo" do |chef|
        chef.add_recipe value[:receipe]
      end
    end

  end

end
