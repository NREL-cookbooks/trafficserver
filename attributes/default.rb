#
# Cookbook Name:: gdal
# Attributes:: default
#
# Copyright 2014, NREL
#
# All rights reserved - Do Not Redistribute
#

default[:trafficserver][:version] = "6.1.1"
default[:trafficserver][:download_url] = "http://mirrors.sonic.net/apache/trafficserver/trafficserver-#{node[:trafficserver][:version]}.tar.bz2"
default[:trafficserver][:archive_checksum] = "67ddd7fc79e4435f353b2aa8937a7b205f217ca15beba3adb5213a92f9527d8b"
default[:trafficserver][:prefix] = "/opt/trafficserver"
default[:trafficserver][:user] = "trafficserver"
default[:trafficserver][:group] = "trafficserver"

default[:trafficserver][:records] = []
default[:trafficserver][:cache] = []
default[:trafficserver][:plugin] = []
default[:trafficserver][:remap] = []
default[:trafficserver][:storage] = [
  {
    :path => "var/trafficserver",
    :size => "256M",
  },
]

default[:trafficserver][:gzip][:enabled] = "true"
default[:trafficserver][:gzip][:remove_accept_encoding] = "false"
default[:trafficserver][:gzip][:cache] = "true"
default[:trafficserver][:gzip][:compressible_content_type] = ["text/*"]
