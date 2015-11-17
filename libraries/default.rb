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

  # install at compile time so version is available during convergence
  def firefox_compiletime_package(name)
    package name do
      version node['firefox']['version'] unless node['firefox']['version'] == 'latest'
      action :nothing
    end.run_action(:upgrade)
  end

  def firefox_shellout(command)
    cmd = Mixlib::ShellOut.new(command)
    cmd.run_command
    cmd.error!
    cmd.stdout
  end

  # for use by win and mac only
  def firefox_download_url
    if node['firefox']['version'] == 'latest'
      firefox_lastest_url
    else
      firefox_version_url
    end
  end

  def firefox_platform
    case node['platform']
    when 'windows'
      firefox_win_platform
    when 'mac_os_x'
      node['firefox']['version'] == 'latest' ? 'osx' : 'mac'
    end
  end

  def firefox_win_64bit?
    version = node['firefox']['version']
    node['kernel']['machine'] == 'x86_64' && !node['firefox']['32bit_only'] &&
      (version == 'latest' || version.split('.').first.to_i >= 42)
  end

  def firefox_win_platform
    if firefox_win_64bit?
      'win64'
    else
      node['firefox']['version'] == 'latest' ? 'win' : 'win32'
    end
  end

  def firefox_lastest_url
    uri = "https://download.mozilla.org/?product=firefox-latest&os=#{firefox_platform}&lang=#{node['firefox']['lang']}"
    response = Net::HTTP.get_response(URI(uri))
    response['location']
  end

  def firefox_version_url
    version = node['firefox']['version']
    package = platform?('windows') ? "Firefox%20Setup%20#{version}.exe" : "Firefox%20#{version}.dmg"
    "#{node['firefox']['releases_url']}#{version}/#{firefox_platform}/#{node['firefox']['lang']}/#{package}"
  end
end

Chef::Provider.send(:include, Firefox)
Chef::Recipe.send(:include, Firefox)
Chef::Resource.send(:include, Firefox)
