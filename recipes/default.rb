#
# Cookbook Name:: twemproxy
# Recipe:: default
#
# Copyright (C) 2014 Greg Sherwood
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"

# install redis-server
package "redis-server" do
  action :install
end

# create config and init files for a 2nd redis instance
template "/etc/redis/redis-common.conf" do
  source "redis-common.conf.erb"
  mode 0644
  owner "root"
  group "root"
end

template "/etc/redis/redis-server.conf" do
  source "redis-server.conf.erb"
  mode 0644
  owner "root"
  group "root"
  variables ({
    :redis_port => node['twemproxy']['redis_server1_port']
  })
end

template "/etc/redis/redis-server2.conf" do
  source "redis-server.conf.erb"
  mode 0644
  owner "root"
  group "root"
  variables ({
    :redis_port => node['twemproxy']['redis_server2_port'],
    :redis_server_number => 2
  })
end

template "/etc/init.d/redis-server" do
  source "redis-server.erb"
  mode 0755
  owner "root"
  group "root"
end

link "/etc/init.d/redis-server2" do
  to "/etc/init.d/redis-server"
end

directory "/var/lib/redis2" do
  owner "redis"
  group "redis"
  action :create
end


service "redis-server" do
  action [:enable, :restart]
end

service "redis-server2" do
  action [:enable, :start]
end


twemproxy_url = node['twemproxy']['url']
nutcracker_ver = node['twemproxy']['version']

nutcracker_dir = "nutcracker-#{nutcracker_ver}"
nutcracker_tarfile = "nutcracker-#{nutcracker_ver}.tar.gz"


# Download the distribution tarball for twemproxy aka nutcracker
remote_file "#{Chef::Config[:file_cache_path]}/#{nutcracker_tarfile}" do
  source "#{twemproxy_url}/#{nutcracker_tarfile}"
  mode '0644'
  notifies :run, "bash[install_nutcracker]", :immediately
  not_if do 
    File.exists?("/usr/local/sbin/nutcracker")
  end
end


bash 'install_nutcracker' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
    tar xvzf #{nutcracker_tarfile}
    cd #{nutcracker_dir}
    ./configure
    make
    make install
  EOF
  action :nothing
end

directory "/etc/nutcracker" do
  owner "root"
  group "root"
  action :create
end

directory "/var/run/nutcracker" do
  owner "redis"
  group "redis"
  action :create
end

template "/etc/nutcracker/nutcracker.conf" do
  source "nutcracker.conf.erb"
  mode 0644
  owner "root"
  group "root"
  variables ({
    :twemproxy_port => node['twemproxy']['twemproxy_port'],
    :server1_port => node['twemproxy']['redis_server1_port'],
    :server2_port => node['twemproxy']['redis_server2_port']
  })
end

template "/etc/init.d/nutcracker" do
  source "nutcracker.erb"
  mode 0755
  owner "root"
  group "root"
end

service "nutcracker" do
  action [:enable, :start]
end
