# MozillaFirefox helper
module MozillaFirefox
  def firefox_version(_url = nil)
    case node['platform']
    when 'windows'
      begin
        firefox_shellout('firefox -v | more').match(/Mozilla Firefox (.*)/)[1]
      rescue
        program_files = node['kernel']['machine'] == 'x86_64' ? ENV['ProgramW6432'] : ENV['ProgramFiles']
        firefox_shellout("\"#{program_files}\\Mozilla Firefox\\firefox.exe\" -v | more")
          .match(/Mozilla Firefox (.*)/)[1]
      end
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
