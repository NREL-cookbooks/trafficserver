#
# Cookbook Name:: gdal
# Attributes:: default
#
# Copyright 2014, NREL
#
# All rights reserved - Do Not Redistribute
#

default[:trafficserver][:version] = "4.2.2"
default[:trafficserver][:download_url] = "http://mirrors.sonic.net/apache/trafficserver/trafficserver-#{node[:trafficserver][:version]}.tar.bz2"
default[:trafficserver][:archive_checksum] = "ad8c69a23559960a611ac0f76eb5f14e5efa473f029422bafd9a9a82b67ed509"
default[:trafficserver][:prefix] = "/opt/trafficserver"
default[:trafficserver][:user] = "trafficserver"
default[:trafficserver][:group] = "trafficserver"

default[:trafficserver][:records][:proxy_name] = "trafficserver"
default[:trafficserver][:records][:server_ports] = "8080"
default[:trafficserver][:records][:http_ui_enabled] = "0"
default[:trafficserver][:records][:enable_read_while_writer] = "0"
default[:trafficserver][:records][:accept_no_activity_timeout] = "120"
default[:trafficserver][:records][:background_fill_active_timeout] = "60"
default[:trafficserver][:records][:background_fill_completed_threshold] = "0.5"
default[:trafficserver][:records][:max_open_read_retries] = "-1"
default[:trafficserver][:records][:open_read_retry_time] = "10"

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
