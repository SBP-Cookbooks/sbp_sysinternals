#
# Cookbook Name:: sbp_sysinternals
# Recipe:: bginfo
#
# Copyright 2014, Schuberg Philis
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

remote_file "#{Chef::Config[:file_cache_path]}/#{URI.parse(node['sysinternals']['bginfo_config_url']).path.split('/')[-1]}" do
  source node['sysinternals']['bginfo_config_url']
  not_if { File.exist?("#{node['sysinternals']['bginfo_config_dir']}/config.bgi") }
end

archive_file "#{Chef::Config[:file_cache_path]}/#{URI.parse(node['sysinternals']['bginfo_config_url']).path.split('/')[-1]}" do
  extract_to node['sysinternals']['bginfo_config_dir']
  action :extract
  not_if { File.exist?("#{node['sysinternals']['bginfo_config_dir']}/config.bgi") }
end

windows_auto_run 'BGINFO' do
  path "#{node['sysinternals']['install_dir']}\\Bginfo.exe"
  args "\"#{node['sysinternals']['bginfo_config_dir']}\\config.bgi\" /NOLICPROMPT /TIMER:0"
  not_if { Registry.value_exists?(AUTO_RUN_KEY, 'BGINFO') }
end
