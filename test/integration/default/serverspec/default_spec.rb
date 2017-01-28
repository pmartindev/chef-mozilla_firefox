require 'serverspec'

# Required by serverspec
if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM).nil?
  set :backend, :exec
else
  set :backend, :cmd
  set :os, family: 'windows'
end

describe 'firefox::default' do
  case os[:family]
  when 'windows'
    describe command('cmd /c "C:\\Program Files\\Mozilla Firefox\\firefox.exe" -v | more') do
      its(:stdout) { should match(/Mozilla Firefox /) }
    end

    describe windows_registry_key('HKLM\SOFTWARE\Mozilla\Mozilla Firefox ESR') do
      it { should exist }
      it { should have_property('CurrentVersion') }
    end
  when 'darwin'
    describe command('/Applications/Firefox.app/Contents/MacOS/firefox -v') do
      its(:stdout) { should match(/Mozilla Firefox /) }
      its(:exit_status) { should eq 0 }
    end
  when 'debian'
    describe command('firefox -v') do
      its(:stdout) { should match(/Mozilla Firefox /) }
      its(:exit_status) { should eq 0 }
    end
  else # linux
    describe command('firefox -v') do
      its(:stdout) { should match(/Mozilla Firefox /) }
      its(:exit_status) { should eq 0 }
    end
  end
end
