# MozillaFirefox helper
module MozillaFirefox
  def firefox_version(url = nil)
    case node['platform']
    when 'windows', 'mac_os_x'
      return node['mozilla_firefox']['version'] unless firefox_latest?
      (url ? url : firefox_download_url).match(%r{releases/([^/]*)})[1] # http://rubular.com/r/JZsE2buXdW
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
    lang = node['mozilla_firefox']['lang']
    uri = URI("https://download.mozilla.org/?product=#{firefox_product}&os=#{firefox_os}&lang=#{lang}")
    response = Net::HTTP.start(uri.host, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
      http.get uri.request_uri
    end
    fail("#{response.code} #{response.message}: #{uri}") unless response.is_a?(Net::HTTPRedirection)
    response['location']
  end

  def firefox_product
    case node['mozilla_firefox']['version']
    when 'latest'
      'firefox-latest'
    when 'latest-esr'
      'firefox-esr-latest'
    when 'latest-beta'
      'firefox-beta-latest'
    else
      "firefox-#{node['mozilla_firefox']['version']}-SSL"
    end
  end

  def firefox_os
    case node['platform']
    when 'windows'
      firefox_win_64bit? ? 'win64' : 'win'
    when 'mac_os_x'
      'osx'
    end
  end

  # support firefox 64-bit windows (v42.0+)
  def firefox_win_64bit?
    node['kernel']['machine'] == 'x86_64' && !node['mozilla_firefox']['32bit_only'] &&
      (firefox_latest? || node['mozilla_firefox']['version'].split('.').first.to_i >= 42)
  end

  def firefox_latest?
    node['mozilla_firefox']['version'].include?('latest')
  end
end

Chef::Provider.send(:include, MozillaFirefox)
Chef::Recipe.send(:include, MozillaFirefox)
Chef::Resource.send(:include, MozillaFirefox)
