require 'spec_helper'

describe 'mozilla_firefox_test::default' do
  context 'windows install of latest version' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2').converge(described_recipe)
    end

    it 'installs latest version' do
      expect(chef_run).to install_windows_package("Mozilla Firefox #{VER} (x64 en-US)").with(
        source: "http://download.cdn.mozilla.net/pub/firefox/releases/#{VER}/win64/en-US/Firefox%20Setup%20#{VER}.exe",
        installer_type: :custom,
        options: '-ms'
      )
    end
  end

  context 'override default version and lang' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
        node.set['mozilla_firefox']['version'] = '38.4.0esr'
        node.set['mozilla_firefox']['lang'] = 'fr'
        node.set['mozilla_firefox']['32bit_only'] = true
      end.converge(described_recipe)
    end

    it 'installs specific version and lang' do
      expect(chef_run).to install_windows_package('Mozilla Firefox 38.4.0esr (x86 fr)').with(
        source: 'https://download-installer.cdn.mozilla.net/pub/firefox/releases/38.4.0esr/win32/fr/'\
        'Firefox%20Setup%2038.4.0esr.exe',
        installer_type: :custom,
        options: '-ms'
      )
    end
  end

  context 'mac install of latest version' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'mac_os_x', version: '10.7.4').converge(described_recipe)
    end

    it 'installs latest version' do
      expect(chef_run).to install_dmg_package('Firefox').with(
        source: "http://download.cdn.mozilla.net/pub/firefox/releases/#{VER}/mac/en-US/Firefox%20#{VER}.dmg",
        dmg_name: 'firefox'
      )
    end
  end

  context 'linux install of latest version using package manager' do
    let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

    it 'installs latest version' do
      expect(chef_run).to upgrade_package('firefox').with(
        version: nil
      )
    end

    it 'updates package manager' do
      expect(chef_run).to_not run_execute('apt-get update')
    end
  end
end
