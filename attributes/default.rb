#
# Cookbook Name:: gdal
# Attributes:: default
#
# Copyright 2014, NREL
#
# All rights reserved - Do Not Redistribute
#

default[:trafficserver][:version] = "4.2.3"
default[:trafficserver][:download_url] = "http://mirrors.sonic.net/apache/trafficserver/trafficserver-#{node[:trafficserver][:version]}.tar.bz2"
default[:trafficserver][:archive_checksum] = "1aaac711fb2ca31f68d814493f230d2d740be014100b7457a76fb614fa9b7933"
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
default[:trafficserver][:records][:ram_cache_size] = "-1"

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
