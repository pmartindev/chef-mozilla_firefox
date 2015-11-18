if platform_family?('windows', 'mac_os_x')
  url = firefox_download_url
  version = firefox_version(url)
end

case node['platform']
when 'windows'
  bit = firefox_win_64bit? ? 'x64' : 'x86'
  windows_package "Mozilla Firefox #{version} (#{bit} #{node['mozilla_firefox']['lang']})" do
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
when 'debian'
  firefox_compiletime_package('iceweasel')
else # linux
  firefox_compiletime_package('firefox')
end
