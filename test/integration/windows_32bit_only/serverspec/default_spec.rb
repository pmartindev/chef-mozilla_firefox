require 'serverspec'

# Required by serverspec
set :backend, :cmd
set :os, family: 'windows'

describe 'firefox::default' do
  describe command('cmd /c "C:\\Program Files (x86)\\Mozilla Firefox\\firefox.exe" -v | more') do
    its(:stdout) { should match(/Mozilla Firefox /) }
    its(:exit_status) { should eq 0 }
  end

  describe windows_registry_key('HKLM\SOFTWARE\Wow6432Node\Mozilla\Mozilla Firefox') do
    it { should exist }
    it { should have_property('CurrentVersion') }
  end
end
