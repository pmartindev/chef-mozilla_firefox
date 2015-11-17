require 'open-uri'
require 'openssl'

# Firefox helper
module Firefox
  def firefox_version(url = nil)
    if platform_family?('windows', 'mac_os_x')
      return node['firefox']['version'] unless node['firefox']['version'] == 'latest'
      url = firefox_download_url unless url
      url.match(/(-|%20)([\d|.]*).(exe|dmg|tar.bz2)/)[2] # http://rubular.com/r/thFO453EZZ
    else
      cmd = Mixlib::ShellOut.new('firefox --version')
      cmd.run_command
      cmd.error!
      cmd.stdout.match(/Mozilla Firefox (.*)/)[1]
    end
  end

  # private

  def firefox_download_url
    lang = node['firefox']['lang']
    version = node['firefox']['version']
    if version == 'latest'
      platform = platform?('windows') ? 'win' : 'osx'
      uri = "https://download.mozilla.org/?product=firefox-latest&os=#{platform}&lang=#{lang}"
      response = Net::HTTP.get_response(URI(uri))
      response['location']
    else
      platform = platform?('windows') ? 'win32' : 'mac'
      package = platform?('windows') ? "Firefox%20Setup%20#{version}.exe" : "Firefox%20#{version}.dmg"
      "#{node['firefox']['releases_url']}#{version}/#{platform}/#{lang}/#{package}"
    end
  end
end

Chef::Provider.send(:include, Firefox)
Chef::Recipe.send(:include, Firefox)
Chef::Resource.send(:include, Firefox)
