require 'open-uri'
require 'openssl'

# Firefox helper
module Firefox
  def firefox_version(url = nil)
    case node['platform']
    when 'windows', 'mac_os_x'
      return node['firefox']['version'] unless node['firefox']['version'] == 'latest'
      url = firefox_download_url unless url
      url.match(/(-|%20)([\d|.]*).(exe|dmg|tar.bz2)/)[2] # http://rubular.com/r/thFO453EZZ
    when 'debian'
      firefox_shellout('iceweasel -v').match(/Mozilla Iceweasel (.*)/)[1]
    else
      firefox_shellout('firefox -v').match(/Mozilla Firefox (.*)/)[1]
    end
  end

  # private

  def firefox_shellout(command)
    cmd = Mixlib::ShellOut.new(command)
    cmd.run_command
    cmd.error!
    cmd.stdout
  end

  def firefox_download_url
    if node['firefox']['version'] == 'latest'
      firefox_lastest_url
    else
      firefox_version_url
    end
  end

  def firefox_lastest_url
    platform = platform?('windows') ? 'win' : 'osx'
    uri = "https://download.mozilla.org/?product=firefox-latest&os=#{platform}&lang=#{node['firefox']['lang']}"
    response = Net::HTTP.get_response(URI(uri))
    response['location']
  end

  def firefox_version_url
    version = node['firefox']['version']
    platform = platform?('windows') ? 'win32' : 'mac'
    package = platform?('windows') ? "Firefox%20Setup%20#{version}.exe" : "Firefox%20#{version}.dmg"
    "#{node['firefox']['releases_url']}#{version}/#{platform}/#{node['firefox']['lang']}/#{package}"
  end
end

Chef::Provider.send(:include, Firefox)
Chef::Recipe.send(:include, Firefox)
Chef::Resource.send(:include, Firefox)
