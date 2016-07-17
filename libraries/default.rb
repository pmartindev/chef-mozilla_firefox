# MozillaFirefox helper
module MozillaFirefox
  def firefox_version(_url = nil)
    case node['platform']
    when 'windows'
      firefox_shellout('firefox -v | more').match(/Mozilla Firefox (.*)/)[1]
    when 'debian'
      begin
        firefox_shellout('iceweasel -v').match(/Mozilla Firefox (.*)/)[1]
      rescue
        firefox_shellout('firefox -v').match(/Mozilla Firefox (.*)/)[1]
      end
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
end

Chef::Provider.send(:include, MozillaFirefox)
Chef::Recipe.send(:include, MozillaFirefox)
Chef::Resource.send(:include, MozillaFirefox)
