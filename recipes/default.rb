# Cookbook Name:: firefox
# Recipe:: default
#
# Copyright 2012, Webtrends, Inc.
# Copyright 2014, Limelight Networks, Inc.
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

if platform_family?('windows', 'mac_os_x')
  url = firefox_download_url
  version = firefox_version(url)
end

case node['platform']
when 'windows'
  windows_package "Mozilla Firefox #{version} (x86 #{node['firefox']['lang']})" do
    source url
    installer_type :custom
    options '-ms'
    action :install
  end
when 'mac_os_x'
  dmg_package 'Firefox' do
    dmg_name 'firefox'
    source url
    action :install
  end
else
  package 'firefox' do
    version node['firefox']['version'] unless node['firefox']['version'] == 'latest'
    action :nothing
  end.run_action(:upgrade) # install at compile time so version is available during convergence
end
