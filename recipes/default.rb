#
# Cookbook:: win_sysinternals
# Recipe:: default
#
# Copyright:: 2020, Schuberg Philis B.V.
#
# All rights reserved - Do Not Redistribute
#
unless File.directory?('C:\\Program Files (x86)\\Sysinternals Suite')
  zipfile = File.basename(node['sysinternals']['url'])
  temppath = "#{node['sysinternals']['temp']}\\#{zipfile}"

  remote_file temppath do
    source node['sysinternals']['url']
    action :create
  end

  archive_file zipfile do
    path temppath
    destination node['sysinternals']['install_dir']
    action :extract
  end
end

if node['sysinternals'].key?('bginfo_config_url') && node['sysinternals'].key?('bginfo_config_dir')
  include_recipe '::bginfo'
end
