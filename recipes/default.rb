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
    destination temppath
    action :extract
  end

  windows_package 'SysinternalsSuite' do
    source "#{node['sysinternals']['temp']}\\SysinternalsSuite\\SysinternalsSuiteSetup.exe"
    options '/SILENT'
    installer_type :custom
    action :install
  end
end

unless node['sysinternals']['bginfo_config_url'].nil? || node['sysinternals']['bginfo_config_dir'].nil?
  include_recipe "#{cookbook_name}::bginfo"
end
