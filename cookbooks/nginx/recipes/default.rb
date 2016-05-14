package ['nginx', 'golang', 'git']

cookbook_file '/home/vagrant/.ssh/config' do
  source 'ssh_config'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :create
end

cookbook_file '/vagrant/.git/hooks/post-commit' do
  source 'post-commit'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :create
end

execute 'md5_go_source' do
  command 'md5sum /vagrant/app.go > /home/vagrant/md5'
  user 'vagrant'
end

cookbook_file '/etc/nginx/sites-available/app.conf' do
  source 'app.conf_nginx'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

service 'nginx' do
  action :start
end

link '/etc/nginx/sites-enabled/app.conf' do
  to '/etc/nginx/sites-available/app.conf'
  notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/default' do
  action :delete
  notifies :restart, 'service[nginx]'
end
