#
# Cookbook Name:: trafficserver
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "build-essential"

dependencies = value_for_platform_family({
  ["rhel", "fedora"] => [
    "libxml2-devel",
    "lua-devel",
    "openssl-devel",
    "pcre-devel",
    "tcl-devel",
  ],
  "default" => [],
})

dependencies.each do |package_name|
  package package_name
end

user(node[:trafficserver][:user]) do
  system true
  shell "/bin/false"
  home node[:trafficserver][:prefix]
end

dir = "trafficserver-#{node[:trafficserver][:version]}"
archive = "#{dir}.tar.bz2"

remote_file "#{Chef::Config[:file_cache_path]}/#{archive}" do
  source node[:trafficserver][:download_url]
  checksum node[:trafficserver][:archive_checksum]
end

bash "compile_trafficserver" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar -xvf #{archive}
    cd #{dir}
    ./configure \
      --prefix=#{node[:trafficserver][:prefix]} \
      --with-user=#{node[:trafficserver][:user]} \
      --with-group=#{node[:trafficserver][:group]} \
      --enable-experimental-plugins
    make
    make install
    cp #{node[:trafficserver][:prefix]}/bin/trafficserver /etc/init.d/trafficserver
    cd ..
    rm -rf #{dir}
  EOH
  not_if "#{node[:trafficserver][:prefix]}/bin/traffic_server -V 2>&1 | grep 'Apache Traffic Server - traffic_server - #{::Regexp.escape(node[:trafficserver][:version])} - (build'"
end

node[:trafficserver][:storage].each do |storage|
  directory(storage[:path]) do
    owner node[:trafficserver][:user]
    group node[:trafficserver][:group]
    mode "0755"
    recursive true
  end
end

template "/etc/profile.d/trafficserver.sh" do
  source "profile.sh.erb"
  mode "0644"
  owner "root"
  group "root"
end

execute "trafficserver_reread" do
  command "#{node[:trafficserver][:prefix]}/bin/traffic_line -x"
  action :nothing
end

template "#{node[:trafficserver][:prefix]}/etc/trafficserver/records.config" do
  source "records.config.erb"
  owner node[:trafficserver][:user]
  group node[:trafficserver][:group]
  mode "0600"
  notifies :restart, "service[trafficserver]"
end

configs = [
  "cache.config",
  "gzip.config",
  "plugin.config",
  "remap.config",
  "storage.config",
]

configs.each do |config|
  template "#{node[:trafficserver][:prefix]}/etc/trafficserver/#{config}" do
    source "#{config}.erb"
    owner node[:trafficserver][:user]
    group node[:trafficserver][:group]
    mode "0644"
    notifies :start, "service[trafficserver]"
    notifies :run, "execute[trafficserver_reread]"
  end
end

service "trafficserver" do
  supports :restart => true, :reload => true
  action [:enable, :start]
end
