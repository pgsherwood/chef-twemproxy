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
    :redis_port => 6379
  })
end

template "/etc/redis/redis-server2.conf" do
  source "redis-server.conf.erb"
  mode 0644
  owner "root"
  group "root"
  variables ({
    :redis_port => 6380,
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
