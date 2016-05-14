user 'goapp'

directory '/opt/goapp' do
  owner 'goapp'
  group 'goapp'
  mode '0755'
  action :create
end

cookbook_file '/opt/goapp/goapp' do
  source 'goapp'
  owner 'goapp'
  group 'goapp'
  mode '0755'
  action :create
end

file '/var/log/goapp.log' do
  owner 'goapp'
  group 'goapp'
  mode '0600'
end

cookbook_file '/etc/init.d/goapp' do
  source 'goapp.service'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

service 'goapp' do
  action [:enable, :start]
end
