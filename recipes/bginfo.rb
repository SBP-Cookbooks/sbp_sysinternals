#
# Cookbook:: sbp_sysinternals
# Recipe:: bginfo
#
# Copyright:: 2014, Schuberg Philis
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

unless File.exist?("#{node['sysinternals']['bginfo_config_dir']}/config.bgi")
  zipfile = File.basename(node['sysinternals']['bginfo_config_url'])
  temppath = "#{node['sysinternals']['temp']}\\#{zipfile}"

  remote_file temppath do
    source node['sysinternals']['bginfo_config_url']
    action :create
  end

  archive_file zipfile do
    path temppath
    destination node['sysinternals']['bginfo_config_dir']
    overwrite :auto
    action :extract
  end
end

windows_auto_run 'BGINFO' do
  program "#{node['sysinternals']['install_dir']}\\Bginfo.exe"
  args "\"#{node['sysinternals']['bginfo_config_dir']}\\config.bgi\" /NOLICPROMPT /TIMER:0"
  not_if { registry_value_exists?('HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', { name: 'BGINFO' }, :machine) }
end
